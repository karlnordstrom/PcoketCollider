## Makefile to build and install Rivet analyses

CC=g++
WFLAGS= -Wall -Wextra
CFLAGS=-m64 -pg -I$(INCDIR) -I$(RIVETINCDIR) -O2 $(WFLAGS) -pedantic -ansi

INCDIR=$(PWD)/include
LIBDIR:=$(shell rivet-config --libdir)
PREFIX:=$(shell rivet-config --prefix)
RIVETINCDIR:=$(shell rivet-config --includedir)
LDFLAGS:=$(shell rivet-config --ldflags)

## Get the first part of the string passed
ANALYSISPATH = $(firstword $(subst :, ,$1))

all: RivetPocketCollider.so

RivetPocketCollider.so: PocketCollider.cc
	rivet-buildplugin RivetPocketCollider.so PocketCollider.cc

install: RivetPocketCollider.so
	cp -f RivetPocketCollider.so $(call ANALYSISPATH, $(RIVET_ANALYSIS_PATH))

clean:
	rm -f *.o  *.so
	rm -rf plots
	rm -f *.yoda
