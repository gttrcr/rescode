import os
import cv2
import matplotlib
import numpy as np

matplotlib.use("qtagg")
import matplotlib.pyplot as plt
from astropy.io import fits
from os.path import join
from utils import print_progress_bar

folder = "OFDM31"
video_name = f"{folder}.avi"

folder = os.path.abspath(folder)
video_name = join(folder, video_name)
norm_folder = join(os.path.abspath(folder), "norm")


def normalize_picture(filename):
    hdul = fits.open(filename)
    image_data = hdul[0].data
    hdul.close()
    cmap = matplotlib.cm.flag
    norm = matplotlib.colors.PowerNorm(
        gamma=0.5,
        vmin=np.min(image_data),
        vmax=np.max(image_data),
    )
    image_data = cmap(norm(image_data))
    return image_data


def process(path):
    img = normalize_picture(path)
    path = join(norm_folder, f"{os.path.splitext(os.path.basename(path))[0]}.jpg")
    plt.imsave(path, img)
    return img


def of_calcOpticalFlowPyrLK(video_name, folder):
    cap = cv2.VideoCapture(video_name)
    feature_params = dict(maxCorners=100, qualityLevel=0.3, minDistance=7, blockSize=7)
    lk_params = dict(
        winSize=(15, 15),
        maxLevel=2,
        criteria=(cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 10, 0.03),
    )
    color = np.random.randint(0, 50, (100, 3))
    ret, old_frame = cap.read()
    old_gray = cv2.cvtColor(old_frame, cv2.COLOR_BGR2GRAY)
    p0 = cv2.goodFeaturesToTrack(old_gray, mask=None, **feature_params)
    mask = np.zeros_like(old_frame)

    video = cv2.VideoWriter(
        f"{folder}/PyrLK_{os.path.basename(video_name)}",
        cv2.VideoWriter_fourcc(*"DIVX"),
        10,
        (old_frame.shape[1], old_frame.shape[0]),
    )

    index = 0
    frame_count = int(cv2.VideoCapture.get(cap, int(cv2.CAP_PROP_FRAME_COUNT)))
    print_progress_bar(0, frame_count, prefix="LK")
    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break
        frame_gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        p1, st, err = cv2.calcOpticalFlowPyrLK(
            prevImg=old_gray, nextImg=frame_gray, prevPts=p0, nextPts=None, **lk_params
        )

        if p1 is not None:
            good_new = p1[st == 1]
            good_old = p0[st == 1]

        for i, (new, old) in enumerate(zip(good_new, good_old)):
            a, b = new.ravel()
            c, d = old.ravel()
            mask = cv2.line(
                mask, (int(a), int(b)), (int(c), int(d)), color[i].tolist(), 2
            )
            frame = cv2.circle(frame, (int(a), int(b)), 10, color[i].tolist(), -1)
        img = cv2.add(frame, mask)
        video.write(img)

        old_gray = frame_gray.copy()
        p0 = good_new.reshape(-1, 1, 2)
        print_progress_bar(index + 1, frame_count, prefix="LK")
        index += 1

    cap.release()
    video.release()


def of_calcOpticalFlowFarneback(video_name, folder):
    cap = cv2.VideoCapture(video_name)
    ret, first_frame = cap.read()
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
    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        flow = cv2.calcOpticalFlowFarneback(
            prev=prev_frame,
            next=frame,
            flow=None,
            pyr_scale=0.5,
            levels=3,
            winsize=15,
            iterations=3,
            poly_n=5,
            poly_sigma=1.2,
            flags=0,
        )
        magnitude, angle = cv2.cartToPolar(flow[..., 0], flow[..., 1])
        mask[..., 0] = angle * 180 / np.pi / 2
        mask[..., 2] = cv2.normalize(magnitude, None, 0, 255, cv2.NORM_MINMAX)
        rgb = cv2.cvtColor(mask, cv2.COLOR_HSV2BGR)
        video.write(rgb)

        prev_frame = frame.copy()
        print_progress_bar(index + 1, frame_count, prefix="Farneback")
        index += 1

    cap.release()
    video.release()


if __name__ == "__main__":
    print("Starting...")
    imgs = [
        os.path.abspath(join(folder, img))
        for img in os.listdir(folder)
        if img.lower().endswith(".fit")
    ]

    first_norm_img = None
    if not os.path.exists(norm_folder):
        if not os.path.exists(norm_folder):
            os.makedirs(norm_folder)

        print_progress_bar(0, len(imgs), prefix="Normalization")
        for index, img in enumerate(imgs):
            first_norm_img = process(img)
            print_progress_bar(index + 1, len(imgs), prefix="Normalization")
    else:
        print(f"Files in folder {norm_folder} are already normalized: skip!")

    if not os.path.exists(video_name):
        first_norm_img = process(imgs[0]) if first_norm_img is None else first_norm_img
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

        video.release()
    else:
        print(f"Video {video_name} already exists: skip!")

    of_calcOpticalFlowFarneback(video_name, folder)
    # of_calcOpticalFlowPyrLK(video_name, folder)
