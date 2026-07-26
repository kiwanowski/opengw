FRAMEWORK_PATH = /Library/Frameworks

SDL_CFLAGS := $(shell pkg-config --cflags sdl3 2>/dev/null)
SDL_LIBS := $(shell pkg-config --libs sdl3 2>/dev/null)

ifeq ($(strip $(SDL_LIBS)),)
SDL_CFLAGS = -F $(FRAMEWORK_PATH)
SDL_LIBS = -F $(FRAMEWORK_PATH) -framework SDL3 -rpath $(FRAMEWORK_PATH)
endif

LIBS = $(SDL_LIBS) -framework OpenGL
OWN_PATHS = -I.
HEADERS = $(OWN_PATHS) $(SDL_CFLAGS)
CFLAGS = -std=c++20 -Wall -Wextra -O3 -ggdb
NAME = opengw
OBJDIR = obj

ALL_SRC = $(wildcard *.cpp)
SRC_FILES = $(notdir $(ALL_SRC))
OBJ_FILES = $(SRC_FILES:.cpp=.o)

OBJS = $(addprefix $(OBJDIR)/, $(OBJ_FILES))
DEPS = $(OBJS:.o=.d)

CLANG_ANALYZE   = #--analyze
CLANG_THREAD    = #-fsanitize=thread
CLANG_ADDRESS   = #-fsanitize=address
CLANG_MEMORY    = #-fsanitize=memory
CLANG_UNDEFINED = #-fsanitize=undefined

CLANG_FLAGS= $(CLANG_ANALYZE) $(CLANG_THREAD) $(CLANG_ADDRESS) $(CLANG_MEMORY) $(CLANG_UNDEFINED)

COMPILER = g++
#COMPILER = clang++

all: $(NAME)
	#./$(NAME)

# dependencies
$(OBJDIR)/%.d : %.cpp | $(OBJDIR)
	$(COMPILER) -MM -MP -MT $(@:.d=.o) -o $@ $< $(CFLAGS) $(DEFINES) $(HEADERS)

# compiling
$(OBJDIR)/%.o : %.cpp
	$(COMPILER) -o $@ -c $< $(CFLAGS) $(CLANG_FLAGS) $(DEFINES) $(HEADERS)

clean:
	rm $(OBJDIR)/*

$(NAME): $(OBJS)
	$(COMPILER) -o $@ $(OBJS) $(LIBS) $(CLANG_FLAGS)

$(OBJDIR):
	mkdir -p $@

# Load .d files
ifneq ($(MAKECMDGOALS),clean)
-include $(DEPS)
endif
