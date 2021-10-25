#include <thread>
#include <string>
#include <chrono>
#include <fstream>

#include "position.h"
#include "piece.h"
#include "table.h"

#define MAX_TEST 5000000

//complexity n(n+1)/2 => O(n^2)
void execute_test_v1(unsigned int max_test)
{
    table t;
    std::vector<std::tuple<piece, double, double>> average;
    average.push_back(std::make_tuple(piece(piece::value::pawn, piece::color::white), 0.0, 0.0));
    average.push_back(std::make_tuple(piece(piece::value::pawn, piece::color::black), 0.0, 0.0));
    average.push_back(std::make_tuple(piece(piece::value::rook, piece::color::white), 0.0, 0.0));
    average.push_back(std::make_tuple(piece(piece::value::rook, piece::color::black), 0.0, 0.0));
    average.push_back(std::make_tuple(piece(piece::value::knight, piece::color::white), 0.0, 0.0));
    average.push_back(std::make_tuple(piece(piece::value::knight, piece::color::black), 0.0, 0.0));

    std::string str = "";
    for (unsigned int max_t = 0; max_t < max_test; max_t += 100)
    {
        for (unsigned int r = 0; r < average.size(); r++)
        {
            std::get<1>(average[r]) = 0.0;
            std::get<2>(average[r]) = 0.0;
        }

        for (unsigned int i = 0; i < max_t; i++)
        {
            t.random();
            std::vector<std::tuple<piece, position>> dist = t.pieces();
            for (unsigned int d = 0; d < dist.size(); d++)
            {
                double pos = (double)(t.available_positions(std::get<1>(dist[d])).size());
                double cap = (double)(t.available_captures(std::get<1>(dist[d])).size());
                double count = 0.0;
                for (unsigned int t = 0; t < dist.size(); t++)
                    if (std::get<0>(dist[d]) == std::get<0>(dist[t]))
                        count++;
                pos /= count;
                cap /= count;

                for (unsigned int r = 0; r < average.size(); r++)
                    if (std::get<0>(average[r]) == std::get<0>(dist[d]))
                    {
                        std::get<1>(average[r]) += pos;
                        std::get<2>(average[r]) += cap;
                    }
            }
        }

        std::string tmp = std::to_string(max_t) + " ";
        for (unsigned int r = 0; r < average.size(); r++)
        {
            piece p = std::get<0>(average[r]);
            double avg_pos = std::get<1>(average[r]) / (double)(max_t);
            double avg_cap = std::get<2>(average[r]) / (double)(max_t);
            tmp += std::to_string(p.get_color()) + std::to_string(p.get_value()) + " " + std::to_string(avg_pos) + " " + std::to_string(avg_cap) + " ";
        }
        //std::cout << tmp << std::endl;
        str += tmp + "\n";

        if ((max_t % 5000) == 0)
        {
            std::cout << max_t << "/" << max_test << std::endl;
            std::ofstream outfile;
            outfile.open("output.txt", std::ios_base::app);
            outfile << str;
            outfile.close();
            str = "";
        }
    }
}

//complexity O(n)
void execute_test_v2(unsigned int max_test)
{
    std::ofstream outfile;
    outfile.open("output.txt", std::ios_base::out | std::ios_base::trunc);
    outfile.close();

    table t;
    std::vector<std::tuple<
        piece, //for each piece
        unsigned int,  //number of this piece on table
        unsigned int,  //number of available positions
        unsigned int,  //number of available captures
        std::tuple<
        unsigned int,  //number of pawn to capture
        unsigned int,  //number of rook to capture
        unsigned int,  //number of knight to capture
        unsigned int,  //number of bishop to capture
        unsigned int,  //number of king to capture
        unsigned int  //number of queen to capture
        >
        >> average;

    average.push_back(std::make_tuple(piece(piece::value::pawn, piece::color::white), 0, 0, 0, std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int>()));
    average.push_back(std::make_tuple(piece(piece::value::rook, piece::color::white), 0, 0, 0, std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int>()));
    average.push_back(std::make_tuple(piece(piece::value::knight, piece::color::white), 0, 0, 0, std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int>()));
    average.push_back(std::make_tuple(piece(piece::value::bishop, piece::color::white), 0, 0, 0, std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int>()));
    average.push_back(std::make_tuple(piece(piece::value::king, piece::color::white), 0, 0, 0, std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int>()));
    average.push_back(std::make_tuple(piece(piece::value::queen, piece::color::white), 0, 0, 0, std::tuple<unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int>()));

    std::string str = "";
    for (unsigned int i = 1; i <= max_test; i++)
    {
        t.random();
        std::vector<std::tuple<piece, position>> dist = t.pieces();
        for (unsigned int d = 0; d < dist.size(); d++)
        {
            unsigned int pos = (unsigned int)(t.available_positions(std::get<1>(dist[d])).size());
            std::vector<std::tuple<position, piece>> av_cap = t.available_captures(std::get<1>(dist[d]));
            unsigned int cap = (unsigned int)(av_cap.size());
            for (unsigned int r = 0; r < average.size(); r++)
                if (std::get<0>(average[r]) == std::get<0>(dist[d]))
                {
                    std::get<1>(average[r]) += 1;
                    std::get<2>(average[r]) += pos;
                    std::get<3>(average[r]) += cap;
                    for (unsigned int av = 0; av < av_cap.size(); av++)
                    {
                        piece::value v = std::get<1>(av_cap[av]).get_value();
                        if (v == piece::value::pawn)
                            std::get<0>(std::get<4>(average[r])) += 1;
                        else if (v == piece::value::rook)
                            std::get<1>(std::get<4>(average[r])) += 1;
                        else if (v == piece::value::knight)
                            std::get<2>(std::get<4>(average[r])) += 1;
                        else if (v == piece::value::bishop)
                            std::get<3>(std::get<4>(average[r])) += 1;
                        else if (v == piece::value::king)
                            std::get<4>(std::get<4>(average[r])) += 1;
                        else if (v == piece::value::queen)
                            std::get<5>(std::get<4>(average[r])) += 1;
                    }
                }
        }

        if ((i % 1000) == 0)
        {
            std::string tmp = std::to_string(i) + " ";
            for (unsigned int r = 0; r < average.size(); r++)
            {
                tmp += "(" + std::to_string(std::get<1>(average[r])) + " " + std::to_string(std::get<2>(average[r])) + " " + std::to_string(std::get<3>(average[r])) + " ";
                tmp += "("
                    + std::to_string(std::get<0>(std::get<4>(average[r]))) + " "
                    + std::to_string(std::get<1>(std::get<4>(average[r]))) + " "
                    + std::to_string(std::get<2>(std::get<4>(average[r]))) + " "
                    + std::to_string(std::get<3>(std::get<4>(average[r]))) + " "
                    + std::to_string(std::get<4>(std::get<4>(average[r]))) + " "
                    + std::to_string(std::get<5>(std::get<4>(average[r]))) + ")) ";
            }
            //std::cout << tmp << std::endl;
            str += tmp + "\n";
        }

        if ((i % 10000) == 0)
        {
            std::cout << "         \r" << (double)i / (double)max_test;
            outfile.open("output.txt", std::ios_base::app);
            outfile << str;
            outfile.close();
            str = "";
        }
    }
}

int main()
{
    execute_test_v2(MAX_TEST);

    getchar();
    getchar();
}