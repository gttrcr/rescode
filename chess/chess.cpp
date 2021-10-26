#include <thread>
#include <string>
#include <chrono>
#include <fstream>

#include "position.h"
#include "piece.h"
#include "table.h"

//complexity O(n)
void test_av_cap(unsigned int max_test)
{
    std::ofstream outfile;
    outfile.open("test_av_cap.txt", std::ios_base::out | std::ios_base::trunc);
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
            std::cout << "         \r" << (double)i * 100.0 / (double)max_test << "%\r";
            outfile.open("test_av_cap.txt", std::ios_base::app);
            outfile << str;
            outfile.close();
            str = "";
        }
    }
}

void test_match_duration(unsigned int max_test)
{
    std::string str = "";
    std::ofstream outfile;
    outfile.open("test_match_duration.txt", std::ios_base::out | std::ios_base::trunc);
    outfile.close();

    std::random_device dev;
    std::mt19937 rng(dev());
    piece w_queen = piece(piece::value::queen, piece::color::white);
    piece b_queen = piece(piece::value::queen, piece::color::black);
    for (unsigned int i = 1; i <= max_test; i++)
    {
        table t;
        bool w_go_on = false;
        bool b_go_on = false;
        unsigned int count = 0;
        do
        {
            //white moves
            std::tuple<piece, position> pp = std::make_tuple(piece(), position());
            std::vector<position> av_pos;
            std::vector<std::tuple<position, piece>> av_cap;
            std::vector<std::tuple<piece, position>> dist = t.pieces(piece::color::white);
            do
            {
                std::uniform_int_distribution<std::mt19937::result_type> rnd_dist(0, dist.size() - 1);  //select a random element from dist
                pp = dist[rnd_dist(rng)];
                av_pos = t.available_positions(std::get<1>(pp));
                av_cap = t.available_captures(std::get<1>(pp));
            } while (av_pos.size() == 0 && av_cap.size() == 0);

            std::uniform_int_distribution<std::mt19937::result_type> rnd_choice(0, 1);  //select a random from pos and cap
            unsigned int choice = rnd_choice(rng);
            if ((choice == 0 && av_pos.size() != 0) || av_cap.size() == 0)
            {
                std::uniform_int_distribution<std::mt19937::result_type> rnd_av_pos(0, av_pos.size() - 1);  //select a random element from av_pos
                t.move(std::get<1>(pp), av_pos[rnd_av_pos(rng)]);
            }
            else if ((choice == 1 && av_cap.size() != 0) || av_pos.size() == 0)
            {
                std::uniform_int_distribution<std::mt19937::result_type> rnd_av_cap(0, av_cap.size() - 1);  //select a random element from av_cap
                t.move(std::get<1>(pp), std::get<0>(av_cap[rnd_av_cap(rng)]));
            }

            //check mate
            w_go_on = false;
            b_go_on = false;
            dist = t.pieces();
            for (unsigned int d = 0; d < dist.size(); d++)
            {
                if (std::get<0>(dist[d]) == w_queen)
                    w_go_on = true;
                if (std::get<0>(dist[d]) == b_queen)
                    b_go_on = true;
            }
            if (!w_go_on || !b_go_on)
                break;

            //black moves
            pp = std::make_tuple(piece(), position());
            dist = t.pieces(piece::color::black);
            do
            {
                std::uniform_int_distribution<std::mt19937::result_type> rnd_dist(0, dist.size() - 1);  //select a random element from dist
                pp = dist[rnd_dist(rng)];
                av_pos = t.available_positions(std::get<1>(pp));
                av_cap = t.available_captures(std::get<1>(pp));
            } while (av_pos.size() == 0 && av_cap.size() == 0);

            choice = rnd_choice(rng);
            if ((choice == 0 && av_pos.size() != 0) || av_cap.size() == 0)
            {
                std::uniform_int_distribution<std::mt19937::result_type> rnd_av_pos(0, av_pos.size() - 1);  //select a random element from av_pos
                t.move(std::get<1>(pp), av_pos[rnd_av_pos(rng)]);
            }
            else if ((choice == 1 && av_cap.size() != 0) || av_pos.size() == 0)
            {
                std::uniform_int_distribution<std::mt19937::result_type> rnd_av_cap(0, av_cap.size() - 1);  //select a random element from av_cap
                t.move(std::get<1>(pp), std::get<0>(av_cap[rnd_av_cap(rng)]));
            }

            //check mate
            w_go_on = false;
            b_go_on = false;
            dist = t.pieces();
            for (unsigned int d = 0; d < dist.size(); d++)
            {
                if (std::get<0>(dist[d]) == w_queen)
                    w_go_on = true;
                if (std::get<0>(dist[d]) == b_queen)
                    b_go_on = true;
            }
            count++;
        } while (w_go_on && b_go_on);

        str += std::to_string(count) + "\n";
        if ((i % 1000) == 0)
            std::cout << "         \r" << (double)i * 100.0 / (double)max_test << "%\r";
    }

    outfile.open("test_match_duration.txt", std::ios_base::app);
    outfile << str;
    outfile.close();
}

int main()
{
    test_av_cap(10000000);
    test_match_duration(10000000);
}