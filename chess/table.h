#pragma once

#include <iostream>
#include <vector>
#include <cstdarg>
#include <random>
#include <tuple>

class table
{
private:
    piece _t[8][8];

    enum freedom
    {
        available,
        out,
        busy
    };

    void set(char x, unsigned int y, piece::value pr = piece::value::empty_value, piece::color c = piece::color::empty_color)
    {
        piece p(pr, c);
        _t[x - 'a'][y - 1] = p;
    }

    void set(char x, unsigned int y, piece p)
    {
        _t[x - 'a'][y - 1] = p;
    }

    freedom what_is(char x, unsigned int y)
    {
        bool is_out;
        piece p = get(x, y, is_out);
        if (is_out)
            return freedom::out;
        if (p.get_color() == piece::color::empty_color && p.piece::get_value() == piece::value::empty_value)
            return freedom::available;
        return freedom::busy;
    }

public:
    table()
    {
        set('a', 1, piece::value::rook, piece::color::white);
        set('b', 1, piece::value::knight, piece::color::white);
        set('c', 1, piece::value::bishop, piece::color::white);
        set('d', 1, piece::value::queen, piece::color::white);
        set('e', 1, piece::value::king, piece::color::white);
        set('f', 1, piece::value::bishop, piece::color::white);
        set('g', 1, piece::value::knight, piece::color::white);
        set('h', 1, piece::value::rook, piece::color::white);
        set('a', 2, piece::value::pawn, piece::color::white);
        set('b', 2, piece::value::pawn, piece::color::white);
        set('c', 2, piece::value::pawn, piece::color::white);
        set('d', 2, piece::value::pawn, piece::color::white);
        set('e', 2, piece::value::pawn, piece::color::white);
        set('f', 2, piece::value::pawn, piece::color::white);
        set('g', 2, piece::value::pawn, piece::color::white);
        set('h', 2, piece::value::pawn, piece::color::white);

        for (unsigned int y = 3; y < 7; y++)
        {
            set('a', y);
            set('b', y);
            set('c', y);
            set('d', y);
            set('e', y);
            set('f', y);
            set('g', y);
            set('h', y);
        }

        set('a', 7, piece::value::pawn, piece::color::black);
        set('b', 7, piece::value::pawn, piece::color::black);
        set('c', 7, piece::value::pawn, piece::color::black);
        set('d', 7, piece::value::pawn, piece::color::black);
        set('e', 7, piece::value::pawn, piece::color::black);
        set('f', 7, piece::value::pawn, piece::color::black);
        set('g', 7, piece::value::pawn, piece::color::black);
        set('h', 7, piece::value::pawn, piece::color::black);
        set('a', 8, piece::value::rook, piece::color::black);
        set('b', 8, piece::value::knight, piece::color::black);
        set('c', 8, piece::value::bishop, piece::color::black);
        set('d', 8, piece::value::queen, piece::color::black);
        set('e', 8, piece::value::king, piece::color::black);
        set('f', 8, piece::value::bishop, piece::color::black);
        set('g', 8, piece::value::knight, piece::color::black);
        set('h', 8, piece::value::rook, piece::color::black);
    }

    piece get(char x, unsigned int y, bool& is_out)
    {
        int x_int = x - 'a';
        int y_int = y - 1;
        if (x_int < 0 || x_int > 7 || y_int < 0 || y_int > 7)
        {
            is_out = true;
            return piece();
        }

        is_out = false;
        return _t[x - 'a'][y - 1];
    }

    void draw()
    {
        for (unsigned int y = 8; y >= 1; y--)
        {
            for (char x = 'a'; x < 'i'; x++)
            {
                bool is_out;
                piece p = get(x, y, is_out);
                if (p.get_color() != piece::color::empty_color)
                    std::cout << "|" << (p.get_color() == piece::color::black ? "B" : "W") << p.get_value() << "|";
                else
                    std::cout << "|  |";
            }
            std::cout << std::endl;
        }
        std::cout << "--------------------------------" << std::endl;
    }

    std::vector<position> available_positions(position pos)
    {
        return available_positions(pos.get_col(), pos.get_row());
    }

    std::vector<position> available_positions(const char x, const unsigned int y)
    {
        bool is_out;
        piece p = get(x, y, is_out);
        std::vector<position> ret;
        if (is_out)
            return ret;

        switch (p.piece::get_value())
        {
        case piece::value::pawn:  //something wrong?
        {
            if (p.get_color() == piece::color::white)
            {
                //free movement
                if (what_is(x, y + 1) == freedom::available)
                {
                    ret.push_back(position(x, y + 1));
                    if (what_is(x, y + 2) == freedom::available)
                        ret.push_back(position(x, y + 2));
                }
            }
            else if (p.get_color() == piece::color::black)
            {
                //free movement
                if (what_is(x, y - 1) == freedom::available)
                {
                    ret.push_back(position(x, y - 1));
                    if (what_is(x, y - 2) == freedom::available)
                        ret.push_back(position(x, y - 2));
                }
            }
        }
        break;
        case piece::value::rook:  //ok
        {
            //free movement
            char pos_x = x;
            unsigned int pos_y = y;
            while (what_is(++pos_x, pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(--pos_x, pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(pos_x, ++pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(pos_x, --pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));
        }
        break;
        case piece::value::knight:  //ok
        {
            //free movement and eat something
            if (what_is(x + 1, y + 2) == freedom::available)
                ret.push_back(position(x + 1, y + 2));
            if (what_is(x - 1, y + 2) == freedom::available)
                ret.push_back(position(x - 1, y + 2));
            if (what_is(x + 2, y + 1) == freedom::available)
                ret.push_back(position(x + 2, y + 1));
            if (what_is(x + 2, y - 1) == freedom::available)
                ret.push_back(position(x + 2, y - 1));
            if (what_is(x + 1, y - 2) == freedom::available)
                ret.push_back(position(x + 1, y - 2));
            if (what_is(x - 1, y - 2) == freedom::available)
                ret.push_back(position(x - 1, y - 2));
            if (what_is(x - 2, y - 1) == freedom::available)
                ret.push_back(position(x - 2, y - 1));
            if (what_is(x - 2, y + 1) == freedom::available)
                ret.push_back(position(x - 2, y + 1));
        }
        break;
        case piece::value::bishop:
        {
            //free movement
            char pos_x = x;
            unsigned int pos_y = y;
            while (what_is(++pos_x, ++pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(--pos_x, --pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(++pos_x, --pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(--pos_x, ++pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));
        }
        break;
        case piece::value::queen:
        {
            //free movement
            char pos_x = x;
            unsigned int pos_y = y;
            while (what_is(++pos_x, pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(--pos_x, pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(pos_x, ++pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(pos_x, --pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(++pos_x, ++pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(--pos_x, --pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(++pos_x, --pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(--pos_x, ++pos_y) == freedom::available)
                ret.push_back(position(pos_x, pos_y));
        }
        break;
        case piece::value::king:
        {
            //free movement
            if (what_is(x + 1, y) == freedom::available)
                ret.push_back(position(x + 1, y));

            //free movement
            if (what_is(x - 1, y) == freedom::available)
                ret.push_back(position(x - 1, y));

            //free movement
            if (what_is(x, y + 1) == freedom::available)
                ret.push_back(position(x, y + 1));

            //free movement
            if (what_is(x, y - 1) == freedom::available)
                ret.push_back(position(x, y - 1));

            //free movement
            if (what_is(x + 1, y + 1) == freedom::available)
                ret.push_back(position(x + 1, y + 1));

            //free movement
            if (what_is(x - 1, y - 1) == freedom::available)
                ret.push_back(position(x - 1, y - 1));

            //free movement
            if (what_is(x + 1, y - 1) == freedom::available)
                ret.push_back(position(x + 1, y - 1));

            //free movement
            if (what_is(x - 1, y + 1) == freedom::available)
                ret.push_back(position(x - 1, y + 1));
        }
        break;
        default:
            break;
        }

        return ret;
    }

    std::vector<std::tuple<position, piece>> available_captures(position pos)
    {
        return available_captures(pos.get_col(), pos.get_row());
    }

    std::vector<std::tuple<position, piece>> available_captures(const char x, const unsigned int y)
    {
        bool is_out;
        piece p = get(x, y, is_out);
        std::vector<std::tuple<position, piece>> ret;
        if (is_out)
            return ret;

        switch (p.piece::get_value())
        {
        case piece::value::pawn:  //something wrong?
        {
            if (p.get_color() == piece::color::white)
            {
                //eat something
                if (what_is(x + 1, y + 1) == freedom::busy && get(x + 1, y + 1, is_out).get_color() == piece::color::black)
                    ret.push_back(std::make_tuple(position(x + 1, y + 1), get(x + 1, y + 1, is_out)));
                if (what_is(x - 1, y + 1) == freedom::busy && get(x - 1, y + 1, is_out).get_color() == piece::color::black)
                    ret.push_back(std::make_tuple(position(x - 1, y + 1), get(x - 1, y + 1, is_out)));
            }
            else if (p.get_color() == piece::color::black)
            {
                //eat something
                if (what_is(x + 1, y - 1) == freedom::busy && get(x + 1, y - 1, is_out).get_color() == piece::color::white)
                    ret.push_back(std::make_tuple(position(x + 1, y - 1), get(x + 1, y - 1, is_out)));
                if (what_is(x - 1, y - 1) == freedom::busy && get(x - 1, y - 1, is_out).get_color() == piece::color::white)
                    ret.push_back(std::make_tuple(position(x - 1, y - 1), get(x - 1, y - 1, is_out)));
            }
        }
        break;
        case piece::value::rook:  //ok
        {
            //free movement
            char pos_x = x;
            unsigned int pos_y = y;
            while (what_is(++pos_x, pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(--pos_x, pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(pos_x, ++pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(pos_x, --pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));
        }
        break;
        case piece::value::knight:  //ok
        {
            bool is_out;
            //eat something
            if (what_is(x + 1, y + 2) == freedom::busy && get(x + 1, y + 2, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x + 1, y + 2), get(x + 1, y + 2, is_out)));
            if (what_is(x - 1, y + 2) == freedom::busy && get(x - 1, y + 2, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x - 1, y + 2), get(x - 1, y + 2, is_out)));
            if (what_is(x + 2, y + 1) == freedom::busy && get(x + 2, y + 1, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x + 2, y + 1), get(x + 2, y + 1, is_out)));
            if (what_is(x + 2, y - 1) == freedom::busy && get(x + 2, y - 1, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x + 2, y - 1), get(x + 2, y - 1, is_out)));
            if (what_is(x + 1, y - 2) == freedom::busy && get(x + 1, y - 2, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x + 1, y - 2), get(x + 1, y - 2, is_out)));
            if (what_is(x - 1, y - 2) == freedom::busy && get(x - 1, y - 2, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x - 1, y - 2), get(x - 1, y - 2, is_out)));
            if (what_is(x - 2, y - 1) == freedom::busy && get(x - 2, y - 1, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x - 2, y - 1), get(x - 2, y - 1, is_out)));
            if (what_is(x - 2, y + 1) == freedom::busy && get(x - 2, y + 1, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x - 2, y + 1), get(x - 2, y + 1, is_out)));
        }
        break;
        case piece::value::bishop:
        {
            //free movement
            char pos_x = x;
            unsigned int pos_y = y;
            while (what_is(++pos_x, ++pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(--pos_x, --pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(++pos_x, --pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(--pos_x, ++pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));
        }
        break;
        case piece::value::queen:
        {
            //free movement
            char pos_x = x;
            unsigned int pos_y = y;
            while (what_is(++pos_x, pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(--pos_x, pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(pos_x, ++pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(pos_x, --pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(++pos_x, ++pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(--pos_x, --pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(++pos_x, --pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));

            //free movement
            pos_x = x;
            pos_y = y;
            while (what_is(--pos_x, ++pos_y) == freedom::available);

            //eat something
            if (what_is(pos_x, pos_y) == freedom::busy && get(pos_x, pos_y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(pos_x, pos_y), get(pos_x, pos_y, is_out)));
        }
        break;
        case piece::value::king:
        {
            //eat something
            if (what_is(x + 1, y) == freedom::busy && get(x + 1, y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x + 1, y), get(x + 1, y, is_out)));

            //eat something
            if (what_is(x - 1, y) == freedom::busy && get(x - 1, y, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x - 1, y), get(x - 1, y, is_out)));

            //eat something
            if (what_is(x, y + 1) == freedom::busy && get(x, y + 1, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x, y + 1), get(x, y + 1, is_out)));

            //eat something
            if (what_is(x, y - 1) == freedom::busy && get(x, y - 1, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x, y - 1), get(x, y - 1, is_out)));

            //eat something
            if (what_is(x + 1, y + 1) == freedom::busy && get(x + 1, y + 1, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x + 1, y + 1), get(x + 1, y + 1, is_out)));

            //eat something
            if (what_is(x - 1, y - 1) == freedom::busy && get(x - 1, y - 1, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x - 1, y - 1), get(x - 1, y - 1, is_out)));

            //eat something
            if (what_is(x + 1, y - 1) == freedom::busy && get(x + 1, y - 1, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x + 1, y - 1), get(x + 1, y - 1, is_out)));

            //eat something
            if (what_is(x - 1, y + 1) == freedom::busy && get(x - 1, y + 1, is_out).get_color() != p.get_color())
                ret.push_back(std::make_tuple(position(x - 1, y + 1), get(x - 1, y + 1, is_out)));
        }
        break;
        default:
            break;
        }

        return ret;
    }

    void move(position p1, position p2)
    {
        move(p1.get_col(), p1.get_row(), p2.get_col(), p2.get_row());
    }

    void move(char x_i, unsigned int y_i, char x_f, unsigned int y_f, bool check = true)
    {
        bool is_out;
        piece p = get(x_i, y_i, is_out);
        if (!is_out)
        {
            bool ok = false || !check;
            if (check)
            {
                std::vector<position> locs = available_positions(x_i, y_i);
                for (unsigned int i = 0; i < locs.size(); i++)
                    if (locs[i].get_col() == x_f && locs[i].get_row() == y_f)
                    {
                        ok = true;
                        break;
                    }

                if (!ok)
                {
                    std::vector<std::tuple<position, piece>> capt = available_captures(x_i, y_i);
                    for (unsigned int i = 0; i < capt.size(); i++)
                        if (std::get<0>(capt[i]).get_col() == x_f && std::get<0>(capt[i]).get_row() == y_f)
                        {
                            ok = true;
                            break;
                        }
                }
            }

            if (ok)
            {
                set(x_i, y_i);
                set(x_f, y_f, p);
            }
        }
    }

    //white (pawn, rook, knight, bishop, king, queen), black (pawn, rook, knight, bishop, king, queen)
    void random(unsigned int how_many = 0, ...)
    {
        //clear table
        for (char x = 'a'; x < 'i'; x++)
            for (unsigned int y = 1; y < 9; y++)
                set(x, y);

        std::random_device dev;
        std::mt19937 rng(dev());
        std::uniform_int_distribution<std::mt19937::result_type> pos(0, 8);  //from 0 to 8
        std::uniform_int_distribution<std::mt19937::result_type> rkb(0, 2);  // rook, knight, bishop from 0 to 2
        std::uniform_int_distribution<std::mt19937::result_type> kq(0, 1);   //king, queen from 0 to 1
        if (how_many == 0)
        {
            for (unsigned int i = 0; i < 12; i++)
            {
                unsigned int arg = 0;
                if (i == 0 || i == 6)
                    arg = pos(rng);
                else if (i == 1 || i == 2 || i == 3 || i == 7 || i == 8 || i == 9)
                    arg = rkb(rng);
                else
                    arg = kq(rng);

                while (arg > 0)
                {
                    char x = pos(rng) + 'a';
                    unsigned int y = pos(rng);
                    if (what_is(x, y) == freedom::available)
                    {
                        set(x, y, (piece::value)(i % 6 + 1), (piece::color)((i > 5) + 1));
                        arg--;
                    }
                }
            }
        }
        else
        {
            va_list args;
            va_start(args, how_many);
            for (unsigned int i = 0; i < how_many; i++)
            {
                unsigned int arg = va_arg(args, unsigned int);
                while (arg > 0)
                {
                    char x = pos(rng) + 'a';
                    unsigned int y = pos(rng);
                    if (what_is(x, y) == freedom::available)
                    {
                        set(x, y, (piece::value)(i % 6 + 1), (piece::color)(i < 6 + 1));
                        arg--;
                    }
                }
            }
            va_end(args);
        }
    }

    std::vector<std::tuple<piece, position>> pieces(piece::color color = piece::color::empty_color)
    {
        std::vector<std::tuple<piece, position>> ret;
        for (char x = 'a'; x < 'i'; x++)
            for (unsigned int y = 1; y < 9; y++)
            {
                bool is_out;
                if (what_is(x, y) == freedom::busy)
                {
                    piece p = get(x, y, is_out);
                    if (color != piece::color::empty_color && p.get_color() == color)
                        ret.push_back(std::make_tuple(p, position(x, y)));
                    else if (color == piece::color::empty_color)
                        ret.push_back(std::make_tuple(p, position(x, y)));
                }
            }

        return ret;
    }
};