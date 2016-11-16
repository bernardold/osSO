# Operating Systems I - Main Project

This is the main project for the Operating System I discipline (SSC0104/2016-2)
and consists on building a basic, but functional, Operating System from Scratch.

## REALLY IMPORTANT

Although all of the code done for this project is tested and made with great
care, some parts need to be used/executed while in Kernel Mode and because of
that can cause some catastrophic changes in your machine (going from crashes
that will halt your entire PC to even maybe unrecoverable hard disk changes),
so use it at your own distinction.
WE ARE NOT RESPONSIBLE FOR ANY DAMAGE THAT THIS CAUSE IN YOUR COMPUTER.

Because of that, we sometimes will use a safe approach of executing parts of
the code inside a virtual machine and we recommend you to do the same, at least
in the first try.

## osSO (os is SO)

osSO is a project which aims to create a Unix-like POSIX-compliant computer
operating system (OS) in many aspects similar to linux.

The name osSO is an authors pun for the translation of Operating System to
portuguese language (Sistemas Operacionais - SO) trying to create a fun
recursive name for the project.

Our intention in this work is to provide an OS with a minimum set of
functionalities.

Since this project is mainly done by students of a brazilian university, you
can find a version of this README in portuguese [README_EM_PORTUGUES](README_BR.md).

## Getting Started

### Prerequisities

To the present, the only know prerequisites for running/compiling this project are:

```
GNU Development Tools
GNU Binary Utilities
Linux (or some OS) capable of executing few commands from linux command library
```

In order to perform some of the tests we provide you also need:

```
QEMU emulator version 2.0.0
```

### (Pre)Installing

We recommend that you fork this repository by logging into your github account
and clicking on the fork icon on the top right side of the screen, because that
will make it easy to contribute with the project via pull requests.

After forking you can get your own copy of project by doing:

```
git clone https://github.com/YOUR-USERNAME/SO-I-2016/osSO
```

Alternately, you can just get a copy of this repository by cloning it from
upstream by doing:

```
git clone git://github.com/SO-I-2016/osSO
```

However, please note that if using this second method you will not be able to
contribute unless you get a contributor permission from someone inside the
project.


### Installing

Right now we only have a very basic boot implemented.

In order to build this boot, there is a Makefile
[here](https://github.com/SO-I-2016/osSO/boot/Makefile).

Also, please note that the Makefile was build for a linux path environment and
may need few adjusts if you are trying to build/test in a computer running on
Windows or Mac.

## Running the tests

If you have QEMU emulator installed, you can make the first build/test by
typing (while in boot directory):

```
make
qemu-system-i386 boot.bin -boot a
```

Or using the short version:

```
make full
``` 

## Contributing

Please read [CONTRIBUTING](CONTRIBUTING.md) for details on our code of conduct,
and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available,
see the [tags on this repository](https://github.com/SO-I-2016/osSO/tags).

In summary, this means that our Versioning system follow the specific structure:

A version X.Y.Z-K represents:

* X -> MAJOR version change (reserved for incompatible API changes or Major improvements)
* Y -> MINOR version change (reserved for adding functionality and Minor changes)
* Z -> PATCH version change (reserved for bug fixes, typos...)
* K -> PRE-RELEASE version id (an small ASCII alphanumerics and hyphen
[0-9A-Za-z-] with the identifier for the pre-release)

The current build released is 1.1.0

## Authors

* **Bernardo Simões Lage Gomes Duarte (bernardolageduarte@gmail.com)**
* **Décio Lauro Soares (deciolauro@gmail.com)**
* **Giovani Ortolani Barbosa (giovani.barbosa@usp.br)**
* **Jhonathan Roberto Viudes (jhonathan.viudes@gmail.com)**

See also the list of [contributors](https://github.com/SO-I-2016/osSO/contributors)
who participated in this project.

Please consult our [CONTRIBUTING](CONTRIBUTING.md) for instructions. 

## License

This project is licensed under GPL-3.0 - see the [LICENSE.md](LICENSE.md)
file for details

## Copyright

Copyright (C) <2016>  Bernardo S. L. Gomes Duarte; Décio Lauro Soares; Giovani Ortolani Barbosa; Jhonathan Roberto Viudes

## Acknowledgments

We would like to thank:

* Prof. Francisco José Mônaco, Ph.D for all the support
* Alex Frederico Ramos Barboza initial instructions and support
