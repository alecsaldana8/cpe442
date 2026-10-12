CXX := g++
CXXFLAGS := -std=c++17 -O0 -Wall -Wextra $(shell pkg-config --cflags opencv5)
LDFLAGS := $(shell pkg-config --libs opencv5) -Wl,-rpath,$(CONDA_PREFIX)/lib
#LDFLAGS := $(shell pkg-config --libs opencv5)

TARGET := sobel_lab
SRC := main.cpp

LAB4 := lab4

.PHONY: all clean

all: $(TARGET) $(LAB4)

$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

$(LAB4): lab4.cpp
	$(CXX) $(CXXFLAGS) -o $(LAB4) lab4.cpp $(LDFLAGS)

clean:
	rm -f $(TARGET) $(LAB4)
