import sys

sys.dont_write_bytecode = True

import os
import cv2
import matplotlib
import numpy as np

matplotlib.use("qtagg")
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from astropy.io import fits
from os.path import join
from utils import print_progress_bar

folder = "orion"
video_name = f"{folder.split('/')[0]}.mp4"

folder = os.path.abspath(folder)
video_name = join(folder, video_name)
norm_folder = join(os.path.abspath(folder), "norm")


def process(path):

    def normalize_image(image, alpha=0, beta=255):
        normalized_image = np.zeros(image.shape, dtype=np.float32)
        cv2.normalize(
            image,
            normalized_image,
            alpha=alpha,
            beta=beta,
            norm_type=cv2.norm_,
            dtype=cv2.CV_32F,
        )
        return normalized_image

    def process_jpg(input_path):
        image = cv2.imread(input_path, cv2.IMREAD_COLOR)
        if image is None:
            print(f"Error: Unable to read JPG image at {input_path}")
            return

        normalized_image = normalize_image(image)
        # normalized_image = cv2.convertScaleAbs(normalized_image)
        return normalized_image

    def process_fits(input_path):
        with fits.open(input_path) as hdul:
            fits_data = hdul[0].data
            fits_header = hdul[0].header

        if fits_data is None:
            print(f"Error: No data found in FITS file at {input_path}")
            return

        fits_data_normalized = normalize_image(fits_data, alpha=0, beta=255)
        # fits_data_normalized = cv2.convertScaleAbs(fits_data_normalized)
        return fits_data_normalized

    _, ext = os.path.splitext(path)
    if ext.lower().startswith(".jpg"):
        img = process_jpg(path)
    elif ext.lower().startswith(".fit"):
        img = process_fits(path)

    path = join(norm_folder, f"{os.path.splitext(os.path.basename(path))[0]}.jpg")
    cv2.imwrite(path, img)
    return img


def of_calcOpticalFlowFarneback(video_name, folder):
    cap = cv2.VideoCapture(video_name)
    ret, first_frame = cap.read()
    if not ret:
        return

    # first_frame = first_frame[100:600, 400:550]
    prev_frame = cv2.cvtColor(first_frame, cv2.COLOR_BGR2GRAY)
    mask = np.zeros_like(first_frame)
    mask[..., 1] = 255

    video = cv2.VideoWriter(
        f"{folder}/Farneback_{os.path.basename(video_name)}",
        cv2.VideoWriter_fourcc(*"DIVX"),
        10,
        (first_frame.shape[1], first_frame.shape[0]),
    )

    index = 0
    frame_count = int(cv2.VideoCapture.get(cap, int(cv2.CAP_PROP_FRAME_COUNT)))
    print_progress_bar(0, frame_count, prefix="Farneback")
    mags = []
    angs = []
    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        # frame = frame[100:600, 400:550]
        frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        cv2.imshow("Video", frame)

        flow = cv2.calcOpticalFlowFarneback(
            prev=prev_frame,
            next=frame,
            flow=None,
            pyr_scale=0.5,
            levels=5,
            winsize=8,
            iterations=10,
            poly_n=5,
            poly_sigma=1.2,
            flags=0,
        )

        magnitude, angle = cv2.cartToPolar(flow[..., 0], flow[..., 1])
        mask[..., 0] = angle * 180 / np.pi / 2
        mask[..., 2] = cv2.normalize(magnitude, None, 0, 255, cv2.NORM_MINMAX)
        rgb = cv2.cvtColor(mask, cv2.COLOR_HSV2BGR)
        video.write(rgb)

        magnitude_to_the_centre = np.average(magnitude)
        angle_to_the_centre = np.average(mask[..., 0])

        mags.append(magnitude_to_the_centre)
        angs.append(angle_to_the_centre)

        prev_frame = frame.copy()
        print_progress_bar(index + 1, frame_count, prefix="Farneback")
        index += 1
        cv2.waitKey(1)

    print_progress_bar(frame_count, frame_count, prefix="Farneback")
    cap.release()
    video.release()

    return mags, angs


def plot_motion_trend(mags, angs):
    frame = np.arange(0, len(mags))
    fig, ax1 = plt.subplots()

    ax1.plot(frame, mags, "b-", label=f"Magnitude ({str(round(np.average(mags), 3))})")
    ax1.set_xlabel("Frame")
    ax1.set_ylabel("Magnitude", color="b")
    ax1.tick_params(axis="y", labelcolor="b")

    ax2 = ax1.twinx()
    ax2.plot(frame, angs, "r--", label=f"Angle ({str(round(np.average(angs), 3))})")
    ax2.set_ylabel("Angle [rad]", color="r")
    ax2.tick_params(axis="y", labelcolor="r")

    fig.legend(loc="upper left", bbox_to_anchor=(0.1, 0.9))

    plt.title("Magnitude and angle")
    plt.show(block=True)


if __name__ == "__main__":
    print("Starting...")
    imgs = [
        os.path.abspath(join(folder, img))
        for img in os.listdir(folder)
        if img.lower().endswith((".jpg", ".fit", ".fits"))
    ]

    if imgs:
        first_norm_img = None
        if not os.path.exists(norm_folder):
            if not os.path.exists(norm_folder):
                os.makedirs(norm_folder)

            print_progress_bar(0, len(imgs), prefix="Normalization")
            for index, img in enumerate(imgs):
                first_norm_img = process(img)
                print_progress_bar(index + 1, len(imgs), prefix="Normalization")

            print_progress_bar(len(imgs), len(imgs), prefix="Normalization")
        else:
            print(f"Files in folder {norm_folder} are already normalized: skip!")

        if not os.path.exists(video_name):
            first_norm_img = (
                process(imgs[0]) if first_norm_img is None else first_norm_img
            )
            height, width = len(first_norm_img), len(first_norm_img[0])
            video = cv2.VideoWriter(
                video_name, cv2.VideoWriter_fourcc(*"DIVX"), 10, (width, height)
            )

            imgs = [
                os.path.abspath(join(norm_folder, img))
                for img in os.listdir(norm_folder)
                if img.lower().endswith(".jpg")
            ]

            print_progress_bar(0, len(imgs), prefix="Composition")
            for index, img in enumerate(imgs):
                video.write(cv2.imread(img))
                print_progress_bar(index + 1, len(imgs), prefix="Composition")

            print_progress_bar(len(imgs), len(imgs), prefix="Composition")
            video.release()
        else:
            print(f"Video {video_name} already exists: skip!")
    else:
        print(f"Not images in the folder {folder}")

    mags, angs = of_calcOpticalFlowFarneback(video_name, folder)
    plot_motion_trend(mags, angs)

    print("Done")
