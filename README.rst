XCore Parallel Matrix Manipulation
.......

:Stable release:  0.1.0

:Status:  Alpha

:Maintainer:  https://github.com/stevekerrison

:Description:  A library for doing matrix ops in parallel on XS1 hardware


Key Features
============

* Straightforward matrix creation and re-dimensioning
* Easy to use in XC or C
* Row-major matrix layout
* Congigurable level of parallelism

To Do
=====

* Ops on different size data types (e.g. matrix of chars, shorts, 64-bit)
* Cell-wise ops such as addition and subtraction
* Transformations, inversions and other common matrix ops

Firmware Overview
=================

Use module_matrix in applications that require matrix operations and have
some spare threads.

Known Issues
============

* Early demonstration version, API may be unstable

Required Repositories
================

* xcommon git\@github.com:xcore/xcommon.git

Support
=======

Issues can be submitted via Github issue tracker. Even better, submit patches/pull requests.
