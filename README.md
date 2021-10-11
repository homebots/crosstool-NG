# Crosstool-NG

## Usage

Crosstool-NG follows the `autoconf` dance. So, to get you kick-started, just run:

    ./configure --help

If you are using a development snapshot, you'll have to create the configure script, first. Just run:

    ./bootstrap

You will find the documentation in the directory `docs`.

To build in one go, run the following:

```
./bootstrap && ./configure --prefix=`pwd` && make MAKELEVEL=0 && make install MAKELEVEL=0
```

## Using docker

This fork of crosstool-NG add a Docker image so you can download the final build without the hassle of a looong compile time.

```
docker run --rm -it -v $PWD:/home/project homebotz/crosstool-ng
```