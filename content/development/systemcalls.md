---
date: 2016-07-04T17:39:12+02:00
title: System Calls
menu:
  main:
    parent: Development
    identifier: System Calls
    weight: 2
---

## Introduction 
System calls are functions implemented by Mini-OS that can be called from the Go runtime. Most system calls are implemented in ``syscalls.c``, ``mmap.c`` and ``futex.c``.

Calling these functions from Go requires two steps:

  - Create a function written in Go assembly that calls these functions
  - Create a Go function that wraps the Go assembly

Both the ``runtime`` and the ``syscall`` package need access to lower level system calls.

## Adding a system call 

After adding new system calls to Mini-OS with annotations (see examples in ``syscalls.c`` and ``include/syscalls.h``), update the Go code base by running the following script from Mini-OS:

```sh
$ cd unigornel/minios/tools
$ ./updatesys.bash
```

You'll probably want to use your new system call in places like ``syscall/zsyscall_unigornel_amd64.go``, which is not (yet) generated. [commit 3951f57f](https://github.ugent.be/unigornel/go/commit/3951f57f5f2090ef2cc32dfd5f1aa53bcd3ce8f2) gives a good example on how to add a system call.

_**Important**: You must still add your C symbol to ''runtime/cgo/unigornel.go'' [check examples](https://github.com/unigornel/go/tree/master/src/runtime/cgo/unigornel.go)_