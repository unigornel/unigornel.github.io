---
date: 2016-07-04T16:32:28+02:00
title: Development
---

This project is still in the development phase. Read the [Roadmap]({{< relref "development/roadmap.md" >}}).

## Project Structure 

  - Main repository [unigornel](https://github.com/unigornel/unigornel), with submodules
    - [Go fork](https://github.com/unigornel/go)
    - [Mini-OS fork](https://github.com/unigornel/minios)
  - TCP/IP stack [go-tcpip](https://github.com/unigornel/go-tcpip)

## Submitting a Pull Request 

It is crucial that the submodules in the [unigornel](https://github.com/unigornel/unigornel) repository stay matched.

  - Create a pull requests for every submodule that you update
  - Use the ``./update.bash`` to update the submodule commits
  - Create a pull request for the unigornel-repository
  - Reference your submodule pull requests in the unigornel pull request (e.g. _This PR is related to unigornel/minios#3 and unigornel/go#6_)

## Design and Development 
If you want to learn how to help develop this project, read

  * [Debugging a Unikernel]({{< relref "development/debugging.md" >}}): Learn how to debug a unikernel with Xen
  * [System Calls]({{< relref "development/systemcalls.md" >}}): Learn about the interface between Mini-OS and Go