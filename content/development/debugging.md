---
date: 2016-07-04T16:46:24+02:00
title: Debugging a Unikernel
menu:
  main:
    parent: Development
    identifier: Debugging a Unikernel
    weight: 0
---

## Installing gdbsx 

Xen has a debugging tool for guests: ``gdbsx``. It is maintained in the [Xen source tree](http://xenbits.xen.org/gitweb/?p=xen.git;a=tree;f=tools/debugger/gdbsx;h=9a0f5937e0a207f1431c0f4ed5e2f9bd0c555074;hb=HEAD)

To compile and install ``gdbsx``:

```sh
# apt-get install python-dev gettext bin86 bcc iasl uuid-dev libglib2.0-dev libpixman-1-dev libaio-dev libssl-dev libyajl-dev libncurses5-dev
$ git clone git://xenbits.xen.org/xen.git
$ xl info | grep version
xen_version : 4.4.1
$ cd xen
$ git checkout RELEASE-4.4.1
$ cd tools
$ ./configure
$ cd debugger/gdbsx
$ make
# install -m 0755 gdbsx /usr/local/bin/gdbsx
```

**Note:** It is crucial that you checkout the current release of Xen matched to your system installation.

## Using gdbsx 

Debugging a Xen guest takes two steps:

  - Start the Xen guest in paused mode (e.g. ``xl create -p -c config.xen``)
  - Get the domain ID of the host (e.g. ``xl domid domain-name-here``)
  - Attach ``gdbsx`` (e.g. ``gdbsx -a dom-id-here 64 9000 -d``)
  - Attach ``gdb`` to the running ``gdbsx``-instance (e.g. ``gdb -ex 'target remote:9000' mini-os``)
  - Use ``gdb`` to debug: (e.g. in ``gdb`` type ``ni`` for next instruction)

Look at [xl-debug](https://github.com/unigornel/xl-debug) for a script that automates some of the above steps.