Fortran regex
=============

Regular expression for Fortran

## Description

Fortran module to wrap regex.h.

## Demo

```
program test
   use regex_module
   type(regex) :: re

   re%compile("abc(.*)(ghi)")
   re%match("abcdefghi")
   write(*,*) re%group(0) ! abcdefghi
   write(*,*) re%group(1) ! def
   write(*,*) re%group(2) ! ghi
end program test
```

```
program rem_operator_test
   use regex_module
   type(regex) :: re

   re = "abcdefghi" .rem. "abc(.*)(ghi)"
   write(*,*) re%group(0) ! abcdefghi
   write(*,*) re%group(1) ! def
   write(*,*) re%group(2) ! ghi
end program rem_operator_test
```

Compile and run

```
gfortran demo.f90 regex.f90
./a.out
```

## Requirement

* Check that regex library is available.
* GCC gfortran

## Install and Usage

Copy regex.f90 to the directory where you want to use regex_module.

* Fundamental functions

  * `ret = re%compile(pattern)`  compile pattern characters and the return a status integer ret.
  * `ret = re%match(string)`  do regular expression match on string and the return a status integer ret.
  * `str = re%group(i)` obtains i-th matched substring from string
  * `str = re%get_error_message(ret)` get error message of regex corresponds to status ret

* Other definitions
  * Assignment operator `=` is the copy constructor of type(regex)
  * operator `re = A .rem. B` is equivalent to:
  ```
  ret = temp%re_compile(B)
  ret = temp%re_match(A)
  re = temp
  ```
  * `call re%print_status()` prints compile and matching status to stdout

## Files

* README.md
    - This file.
* regex.f90
    - Module source file.
* test.f90
    - A program to test functions.
* demo.f90
    - One of examples in the Demo section.
* check_structure_size.c
    - Supplemental C program to check `regex_t` structure size.

## Note

* Assinment operator `=` do the regular expression matching of lhs again in order to make the regex_t pointer unique.
  * This means the sentense `re = "str" .rem. "pat"` will do compile and match twice.
* If the size of `regex_t` changes, especially bigger than 32 byte, please change `REGEX_T_SIZE` value.
  * `regex_t_size_checker.c` is a simple program to print the size of `regex_t`.

## TODO

* Find a way to solve regex structure size dependency.
* Modify copy constructor to avoid doing the same matching twice
* Check compability for other fortran compiler

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

Seiji Ueno

[ブログ（日本語）](http://sage-t.tumblr.com/)
