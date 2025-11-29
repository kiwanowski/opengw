#include "profiler.hpp"

#include <cstdio>

#include "SDL2/SDL.h"

profiler::profiler(const std::string& name): name(name)
{

}

profiler::~profiler()
{
    const auto frequency = SDL_GetPerformanceFrequency();
    const auto duration = static_cast<double>(performanceCounter) / static_cast<double>(frequency);
    const auto average = 1000.0 * duration / static_cast<double>(runCounter);

    printf("[%s] Duration %f s, run counter %lu, average %f ms\n", name.c_str(), duration, runCounter, average);
}

void profiler::start()
{
    started = SDL_GetPerformanceCounter();
}

void profiler::stop()
{
    const auto finished = SDL_GetPerformanceCounter();
    performanceCounter += (finished - started);
    runCounter++;
}
