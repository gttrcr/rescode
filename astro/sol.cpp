#include <iostream>
#include <stdint.h>
#include <thread>
#include <cmath>
#include <climits>
#include <string.h>
#include <iomanip>
#include <fstream>
#include <vector>
#include <random>
#include <sstream>
#include <atomic>

#define BIGGEST_CPP_TYPE unsigned long long int
#define DECIMAL_TYPE double
#define SMALLEST_CPP_TYPE unsigned char

#pragma region PLATFORM DEPENDENCIES

unsigned int system_line = 0;
unsigned int console_line = 0;

#ifdef _WIN32
#include <intrin.h>
#include <windows.h>
HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

BIGGEST_CPP_TYPE rdtsc()
{
	return __rdtsc();
}

BIGGEST_CPP_TYPE get_available_system_memory()
{
	MEMORYSTATUSEX status{};
	status.dwLength = sizeof(status);
	GlobalMemoryStatusEx(&status);
	return status.ullAvailPhys;
}

void get_cursor_position(unsigned int &x, unsigned int &y)
{
	CONSOLE_SCREEN_BUFFER_INFO cbsi;
	GetConsoleScreenBufferInfo(hConsole, &cbsi);
	x = cbsi.dwCursorPosition.X;
	y = cbsi.dwCursorPosition.Y;
}

void set_cursor_position(const unsigned int &x, const unsigned int &y)
{
	COORD pos = {x, y};
	SetConsoleCursorPosition(hConsole, pos);
}

void print(const std::string &str)
{
	std::cout << str;
}

std::string get()
{
	std::string str;
	std::getline(std::cin, str);
	return str;
}

void clear()
{
	std::system("cls");
}

void prepare_console()
{
	CONSOLE_CURSOR_INFO cursorInfo;
	GetConsoleCursorInfo(hConsole, &cursorInfo);
	cursorInfo.bVisible = false;
	SetConsoleCursorInfo(hConsole, &cursorInfo);
}

void platform_exit()
{
	CONSOLE_CURSOR_INFO cursorInfo;
	GetConsoleCursorInfo(hConsole, &cursorInfo);
	cursorInfo.bVisible = true;
	SetConsoleCursorInfo(hConsole, &cursorInfo);
}
#else
#include <x86intrin.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/sysinfo.h>
#include <ncurses.h>
WINDOW *win = initscr();

BIGGEST_CPP_TYPE rdtsc()
{
	unsigned int lo, hi;
	__asm__ __volatile__("rdtsc"
						 : "=a"(lo), "=d"(hi));
	return ((uint64_t)hi << 32) | lo;
}

BIGGEST_CPP_TYPE get_available_system_memory()
{
	struct sysinfo memInfo;
	sysinfo(&memInfo);
	return memInfo.freeram;
}

void get_cursor_position(unsigned int &x, unsigned int &y)
{
	getyx(win, y, x);
}

void set_cursor_position(const unsigned int &x, const unsigned int &y)
{
	move(y, x);
}

void print(const std::string &str)
{
	printw("%s", str.c_str());
	refresh();
}

std::string get()
{
	char buff[100];
	getstr(buff);
	return std::string(buff);
}

void prepare_console()
{
	curs_set(0);
}

void platform_exit()
{
	endwin();
}
#endif

void put_console(const std::string &str)
{
	set_cursor_position(0, console_line++);
	print(str);
}

void put_system(const std::string &str)
{
	unsigned int x;
	unsigned int y;
	get_cursor_position(x, y);
	set_cursor_position(50, system_line++);
	print(str);
	set_cursor_position(x, y);
}

#pragma endregion

#pragma region UNIVERSE PROPERTIES

struct properties
{
public:
	DECIMAL_TYPE c = 0;
	DECIMAL_TYPE h = 0;
	DECIMAL_TYPE G = 0;
	DECIMAL_TYPE e = 0;
	unsigned int parallelization = 0;
	BIGGEST_CPP_TYPE universe_size = 0;
	BIGGEST_CPP_TYPE observable_universe_size = 0;
	unsigned int output_precision = 0;
	SMALLEST_CPP_TYPE *space = 0;
	std::atomic<BIGGEST_CPP_TYPE *> time = 0;

	std::string to_string()
	{
		return std::to_string(c) + "," + std::to_string(h) + "," + std::to_string(G) + "," + std::to_string(e);
	}
};

properties prop;

#pragma endregion

#pragma region USEFULL FUNCTION

std::vector<std::string> split_string(const std::string &str, const char &delim)
{
	std::stringstream ss(str);
	std::string segment;
	std::vector<std::string> seglist;

	while (std::getline(ss, segment, delim))
		seglist.push_back(segment);

	return seglist;
}

#pragma endregion

void cpucycle_monitor()
{
	BIGGEST_CPP_TYPE last = 0;
	while (true)
	{
		BIGGEST_CPP_TYPE current = rdtsc();
		if (last > current)
			prop.time[1]++;
		prop.time[0] = current;
		last = current;
	}
}

template <typename T>
void light_travel(const unsigned int &tours)
{
	put_system("Light travel started...");

	T pos = 0;
	BIGGEST_CPP_TYPE start[2] = {};
	BIGGEST_CPP_TYPE stop[2] = {};

	std::ofstream output("c.csv");
	output << std::setprecision(prop.output_precision);

	unsigned int tour = 0;
	while (tour < tours)
	{
		if (pos == 0)
		{
			// no code here!!

			stop[0] = prop.time[0];
			stop[1] = prop.time[1];

			// do not save first tour
			if (tour++ > 0)
			{
				BIGGEST_CPP_TYPE deltaT = pow(2.0, 32.0) * (stop[1] - start[1]) + stop[0] - start[0];
				if (deltaT != 0)
				{
					DECIMAL_TYPE c = prop.observable_universe_size / deltaT;
					prop.c = c;

					output << prop.to_string() << std::endl;
					std::this_thread::sleep_for(std::chrono::milliseconds(1));
				}
			}

			start[0] = prop.time[0];
			start[1] = prop.time[1];

			// no code here!!
		}

		prop.space[pos - 1] = 0;
		prop.space[pos++] = 1;
	}

	output.close();
	put_system("Light travel completed");
}

#pragma region COMMANDS

void help()
{
	put_console("help: print this help");
	put_console("exit: terminate the process");
	put_console("quit: terminate the process");
	put_console("clear: clear console");
	put_console("saturate S: saturate the computational power of the universe for S giga ticks");
	put_console("dense D: create a dense universe where VAL is the density");
	put_console("startlight T: start a light simulation with duration T tours of the universe");
}

void exit()
{
	platform_exit();
}

void clear_console()
{
	clear();
	system_line = 0;
	console_line = 0;
	set_cursor_position(0, 0);
}

void saturate(const std::vector<std::string> &args)
{
	if (args.size() != 1)
		throw std::runtime_error("saturate has 1 arguments, provided " + std::to_string(args.size()));

	put_system("Saturation starting...");
	std::atomic<bool *> completed = new bool[prop.parallelization];
	memset(completed, false, prop.parallelization * sizeof(*completed));
	BIGGEST_CPP_TYPE gTicks = std::stoull(args[0]);

	for (unsigned int i = 0; i < prop.parallelization; i++)
		std::thread([gTicks, i, &completed]
					{
						BIGGEST_CPP_TYPE ticks = gTicks * 1000000000;
						BIGGEST_CPP_TYPE start[2];
						start[0] = prop.time[0];
						start[1] = prop.time[1];
						while (pow(2.0, 32.0) * (prop.time[1] - start[1]) + prop.time[0] - start[0] < ticks) {}
						completed[i] = true; })
			.detach();

	std::thread([&completed]
				{
					while (true)
					{
						bool comp = true;
						for (unsigned int i = 0; i < prop.parallelization; i++)
							comp &= completed[i];
						if (comp)
							break;
						std::this_thread::sleep_for(std::chrono::milliseconds(500));
					}
					put_system("Saturation completed"); })
		.detach();
}

void startlight(const std::vector<std::string> &args)
{
	if (args.size() != 1)
		throw std::runtime_error("startlight has 1 arguments, provided " + std::to_string(args.size()));

	const unsigned int tours = std::stoull(args[0]) + 1;
	std::thread light_travel_simulation;
	if (prop.observable_universe_size == ULLONG_MAX)
		light_travel_simulation = std::thread(light_travel<unsigned long long int>, tours);
	else if (prop.observable_universe_size > ULONG_MAX)
		light_travel_simulation = std::thread(light_travel<unsigned long int>, tours);
	else if (prop.observable_universe_size > UINT_MAX)
		light_travel_simulation = std::thread(light_travel<unsigned int>, tours);
	else if (prop.observable_universe_size > USHRT_MAX)
		light_travel_simulation = std::thread(light_travel<unsigned short int>, tours);
	else if (prop.observable_universe_size > UCHAR_MAX)
		light_travel_simulation = std::thread(light_travel<unsigned char>, tours);
	else
		throw std::runtime_error("Resource not available");

	light_travel_simulation.detach();
}

#pragma endregion

int main()
{
	prepare_console();
	put_system("Creating universe...");

	prop.parallelization = std::thread::hardware_concurrency();
	prop.universe_size = get_available_system_memory() / sizeof(SMALLEST_CPP_TYPE);
	prop.output_precision = 20;

	put_system("Let there be time...");
	prop.time = new BIGGEST_CPP_TYPE[2];
	memset(prop.time, 0, 2 * sizeof(*(prop.time)));
	std::thread cpucycle_monitor_thread(cpucycle_monitor);
	cpucycle_monitor_thread.detach();
	put_system("Time created");

	put_system("Let there be space...");
	if (prop.universe_size > ULLONG_MAX)
		prop.observable_universe_size = ULLONG_MAX;
	else if (prop.universe_size > ULONG_MAX)
		prop.observable_universe_size = ULONG_MAX;
	else if (prop.universe_size > UINT_MAX)
		prop.observable_universe_size = UINT_MAX;
	else if (prop.universe_size > USHRT_MAX)
		prop.observable_universe_size = USHRT_MAX;
	else if (prop.universe_size > UCHAR_MAX)
		prop.observable_universe_size = UCHAR_MAX;
	else
		throw std::runtime_error("Resource not available");

	prop.space = new SMALLEST_CPP_TYPE[prop.observable_universe_size];
	memset(prop.space, 0, prop.observable_universe_size * sizeof(*(prop.space)));
	put_system("Space created");

	while (true)
	{
		try
		{
			put_console("conSOLe$ ");
			std::string command = get();
			std::vector<std::string> cmds = split_string(command, ' ');
			if (cmds.size() == 0)
				continue;

			command = cmds[0];
			std::vector<std::string> args;
			for (unsigned int i = 1; i < cmds.size(); i++)
				args.push_back(cmds[i]);

			if (command == "help")
				help();
			else if (command == "exit" || command == "quit")
				exit();
			else if (command == "clear")
				clear_console();
			else if (command == "saturate")
				saturate(args);
			else if (command == "dense")
				; // dense(args);
			else if (command == "startlight")
				startlight(args);
			else
			{
				put_console("Unknown command " + command);
				put_console("Please consider the following list of commands");
				help();
			}
		}
		catch (std::exception &ex)
		{
			put_console("ERROR: " + std::string(ex.what()));
		}
	}
}