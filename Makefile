# Lab 5: compiler optimization experiment.
# Override OPENCV_PKG if needed. Otherwise prefer OpenCV 5, then OpenCV 4.
CXX ?= c++
OPENCV_PKG ?= $(shell if pkg-config --exists opencv5 2>/dev/null; then echo opencv5; else echo opencv4; fi)
OPENCV_CFLAGS := $(shell pkg-config --cflags $(OPENCV_PKG) 2>/dev/null)
OPENCV_LIBS := $(shell pkg-config --libs $(OPENCV_PKG) 2>/dev/null)

CPPFLAGS := -std=c++17 -Wall -Wextra $(OPENCV_CFLAGS)
LDFLAGS := $(OPENCV_LIBS)
LAB5FLAGS ?= -O0

.PHONY: all clean lab4 lab5-o0 lab5-o3-novec lab5-o3 lab5-native baseline-o3 asm-o0 asm-o3-novec asm-o3 asm-native

all: lab5 lab4

lab4: lab4.cpp
	$(CXX) $(CPPFLAGS) $(LAB5FLAGS) -o $@ $< $(LDFLAGS)

lab5: lab5.cpp
	$(CXX) $(CPPFLAGS) $(LAB5FLAGS) -o $@ $< $(LDFLAGS)

lab5-o0: lab5.cpp
	$(CXX) $(CPPFLAGS) -O0 -o $@ $< $(LDFLAGS)

lab5-o3-novec: lab5.cpp
	$(CXX) $(CPPFLAGS) -O3 -fno-tree-loop-vectorize -fno-tree-slp-vectorize -o $@ $< $(LDFLAGS)

lab5-o3: lab5.cpp
	$(CXX) $(CPPFLAGS) -O3 -o $@ $< $(LDFLAGS)

lab5-native: lab5.cpp
	$(CXX) $(CPPFLAGS) -O3 -march=native -o $@ $< $(LDFLAGS)

baseline-o3: lab2.cpp lab5.cpp
	$(CXX) $(CPPFLAGS) -DLAB2_BASELINE -O3 -o lab2-o3 lab5.cpp $(LDFLAGS)

asm-o0: lab5.cpp
	$(CXX) $(CPPFLAGS) -O0 -S -fverbose-asm -o lab5-o0.s $<

asm-o3-novec: lab5.cpp
	$(CXX) $(CPPFLAGS) -O3 -fno-tree-loop-vectorize -fno-tree-slp-vectorize -S -fverbose-asm -o lab5-o3-novec.s $<

asm-o3: lab5.cpp
	$(CXX) $(CPPFLAGS) -O3 -S -fverbose-asm -o lab5-o3.s $<

asm-native: lab5.cpp
	$(CXX) $(CPPFLAGS) -O3 -march=native -S -fverbose-asm -o lab5-native.s $<

clean:
	rm -f lab4 lab5 lab5-o0 lab5-o3-novec lab5-o3 lab5-native lab2-o3 lab5-o0.s lab5-o3-novec.s lab5-o3.s lab5-native.s
