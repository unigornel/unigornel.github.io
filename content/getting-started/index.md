---
date: 2016-07-04T14:40:23+02:00
title: Getting Started
---

This tutorial will guide you through the basic steps of creating a Go unikernel. We assume you have a working 64-bit Xen installation. At the end of this tutorial, you'll be able to print something to the Xen console.

----


## Installation 

The unigornel project can be downloaded using ``go get``. Use this command to get the source of the ``unigornel`` command and its dependencies.
```sh
go get -v github.com/unigornel/unigornel/unigornel
```
The ``github.com/unigornel/unigornel`` repository contains two submodules. These submodules reference to matching versions of the ``go``-fork and the ``mini-os`` fork. Use ``git`` to update these submodules.
```sh
cd $GOPATH/src/github.com/unigornel/unigornel
git submodule update --init --recursive
```
You are now ready to build the ``unigornel`` command line utility and the fork of the Go programming language. We assume you have a working Go installation in ``/usr/local/go``.
```sh
  cd $GOPATH/src/github.com/unigornel/unigornel
  GOROOT_BOOTSTRAP=/usr/local/go make
```
This command will build an edited version of Go and a command line utility called ``unigornel`` (in ``$GOPATH/bin/unigornel'``. This command line utility is used to actually build unikernels. It relies on the correct values of the environment variables ``GOROOT``, ``UNIGORNEL_MINIOS`` and ``PATH`` to build unikernels.

To automatically configure your environment you can use the ``unigornel env``. This command reads out a configuration file in ``$HOME/.unigornel.yaml`` and spits out the correct environment variables. To generate ''.unigornel.yaml'' for your current environment, run
```sh
cd $GOPATH/src/github.com/unigornel/unigornel
make install
```
## Setup your environment 
Make sure the ``unigornel`` command line utility is in your path.
```sh
export PATH="$GOPATH/bin:$PATH"
```
Now make sure all environment variables are set correctly.
```sh
eval $(unigornel env)
```
You can now use ``unigornel build`` to build unikernels.

## Building a unikernel 
Source code for unikernels should be placed in your GOPATH. We will be compiling a unikernel that prints out ``Hello World!`` to the console.
```sh
mkdir $GOPATH/src/helloworld
```
Put the following code in ``$GOPATH/src/helloworld/main.go``

```Go
package main

import "C"
import "fmt"

func main() {}

//export Main
func Main(unused int) {
	fmt.Printf("Hello World!\n")
}
```

Now build your unikernel
```sh
cd $GOPATH/src/helloworld
unigornel build -o helloworld
```
## Running a unikernel 
The resulting binary can be executed directly under Xen. The following configuration file can be used. Note that currently a lot of memory is needed, as the memory subsystem is not yet finished.
```sh
cd $GOPATH/src/helloworld
cat helloworld.xen
kernel = "helloworld"
memory = 256
name = "helloworld"
on_crash = "preserve"
```
Run the unikernel using the ``xl`` command
```sh
xl create -c helloworld.xen
```
It should generate the following console output

```sh
Xen Minimal OS!
  start_info: 0000000000221000(VA)
    nr_pages: 0x10000
  shared_inf: 0xa8da5000(MA)
     pt_base: 0000000000224000(VA)
nr_pt_frames: 0x5
    mfn_list: 00000000001a1000(VA)
   mod_start: 0x0(VA)
     mod_len: 0
       flags: 0x0
    cmd_line: 
       stack: 000000000015b8c0-000000000017b8c0
MM: Init
      _text: 0000000000000000(VA)
     _etext: 000000000008f559(VA)
   _erodata: 000000000012e000(VA)
     _edata: 000000000012fee0(VA)
stack start: 000000000015b8c0(VA)
       _end: 000000000019bdf8(VA)
  start_pfn: 22c
    max_pfn: 10000
Mapping memory range 0x22c000 - 0x10000000
setting 0000000000000000-000000000012e000 readonly
skipped 1000
MM: Initialise page allocator for 2aa000(2aa000)-10000000(10000000)
MM: done
Demand map pfns at 10001000-0000002010001000.
Initialising timer interface
Initialising console ... done.
gnttab_table mapped at 0000000010001000.
Initialising scheduler
Thread "Idle": pointer: 0x000000000032e070, stack: 0x0000000000330000
Thread "xenstore": pointer: 0x000000000032e0d8, stack: 0x0000000000340000
xenbus initialised on irq 1 mfn 0x103e6b
Thread "shutdown": pointer: 0x000000000032e140, stack: 0x0000000000350000
go_main.c: app_main(000000000017b8c0)
Thread "main": pointer: 0x000000000032e220, stack: 0x0000000000370000
Thread "initialize_go": pointer: 0x000000000032e300, stack: 0x0000000000380000
mmap(addr=000000c000000000,len=0x4412000,prot=0x0, flags=0x1002)
mmap(addr=0000000000000000,len=0x40000,prot=0x3, flags=0x1002)
mmap(addr=0000000004410000,len=0x100000,prot=0x3, flags=0x1002)
mmap(addr=0000000004408000,len=0x8000,prot=0x3, flags=0x1002)
mmap(addr=0000000004000000,len=0x1000,prot=0x3, flags=0x1002)
mmap(addr=0000000000000000,len=0x10000,prot=0x3, flags=0x1002)
Thread "pthread-0": pointer: 0x000000000032e488, stack: 0x00000000003a0000
mmap(addr=0000000000000000,len=0x40000,prot=0x3, flags=0x1002)
Thread "pthread-1": pointer: 0x000000000032e5a0, stack: 0x00000000003b0000
Hello World!
crash: go_main.c, line 20: main thread must not return
```