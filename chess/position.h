#pragma once

class position
{
private:
	char _col;
	unsigned int _row;

public:
	position()
	{
		_col = 'a';
		_row = 1;
	}
	
	position(char col, unsigned int row)
	{
		_col = col;
		_row = row;
	}

	char get_col()
	{
		return _col;
	}
	
	unsigned int get_row()
	{
		return _row;
	}
};

inline bool operator==(position& p1, position& p2)
{
	return p1.get_col() == p2.get_col() && p1.get_row() == p2.get_row();
}