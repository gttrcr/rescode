#pragma once

class piece
{
public:
    enum value
    {
        empty_value,
        pawn,
        rook,
        knight,
        bishop,
        king,
        queen
    };

    enum color
    {
        empty_color,
        white,
        black
    };

private:
    value _price;
    color _color;

public:
    piece(value price = value::empty_value, color color = color::empty_color)
    {
        _price = price;
        _color = color;
    }

    value get_value()
    {
        return _price;
    }

    color get_color()
    {
        return _color;
    }
};

inline bool operator==(piece& p1, piece& p2)
{
    return p1.get_color() == p2.get_color() && p1.get_value() == p2.get_value();
}