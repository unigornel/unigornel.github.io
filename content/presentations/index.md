---
date: 2016-07-04T20:01:49+02:00
title: Presentations
menu:
  main:
    identifier: Presentations (Dutch)
    weight: 30
---

- [Projectvoorstel - Unikernel voor Go](projectvoorstel.pdf)
- [The Go Compiler - Linking with Mini-OS (16/02/2016)](1_the_go_compiler.pdf)
	- **Remarks:**
		- Don't edit linux, edit some other Go target to not interfere with host Go tools.
		- Avoid ``-r`` flag when compiling Go itself
		- Stub pthreads in mini-os
- [Initializing Go in Mini-OS (Part 1) (01/03/2016)](2_initializing_go_in_minios.pdf)
    - **Remarks**:
      - Disable stack cookies to fix problem on Ubuntu
      - Use ``-fno-stack-protector`` flag ([34aac4d](https://github.ugent.be/unigornel/go/commit/34aac4d43a4460b173a0fcf40a4c36db77d2af5c))
- [Initializing Go in Mini-OS (Part 2) (07/03/2016)](3_initializing_go_gdt.pdf)
	- **Remarks**:
        - Why initialize CS and DS? And if you do so why not for SS? ([0dfe356](https://github.ugent.be/unigornel/minios/commit/0dfe35620fc431b41e46262917434664a17d1e9b))
- [Initializing Go in Mini-OS (Part 3) - Memory (07/03/2016)](4_initializing_go_runtime_memory.pdf)
    - **Remarks**:
      - Try short term solution first ([d37f567](https://github.ugent.be/unigornel/go/commit/d37f5677be6a604c41e713ed3d186fc110ce1a06))
      - Give guest more memory
- [Eerste tussentijdse presentatie (10/03/2016)](5_tussentijdse_presentatie_1.pdf)
- [Initializing Go in Mini-OS (Part 4) - Hello World (15/03/2016)](6_initializing_go_runtime_hello_world.pdf)
    - **Remarks:**
      - thread sleep bug: edit main from print sleep to print sleep print
      - break after first print, use gdb and look where it crashes
      - set watchpoint on address
      - short term goals: tests, read from console input (but first check if the concept is the same as for network) 
- [Tweede tussentijdse presentatie (12/04/2016)](unigornel_tweede_tussentijdse_presentatie.pdf)
- [Console Input (21/04/2016)](8_read_from_console.pdf)
    - **Remarks:**
      - No terminal emulation, doesn't handle special characters, this is not a priority
      - Not written in Go
- [Basic Ethernet (28/04/2016)](9_basic_ethernet.pdf)
    - **Remarks:**
      - Implement network stack until ping echo-reply
- [Eindverslag (11/05/2016)](10_eindverslag_unigornel.pdf)
- [Eindpresentatie (17/05/2016)](11_eindpresentatie.pdf)