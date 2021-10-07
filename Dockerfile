FROM darlanalves/debian-dev

WORKDIR /home/target
ADD . /home/target
RUN ./bootstrap && ./configure --prefix=`pwd` && make MAKELEVEL=0 && make install MAKELEVEL=0
ENV CT_EXPERIMENTAL=y
ENV CT_ALLOW_BUILD_AS_ROOT=y
ENV CT_ALLOW_BUILD_AS_ROOT_SURE=y
ENV PATH=/home/target:$PATH
ENV TOOLCHAIN="$PWD/xtensa-lx106-elf"
RUN ct-ng xtensa-lx106-elf && \
  sed -r -i.org s%CT_PREFIX_DIR=.*%CT_PREFIX_DIR="$TOOLCHAIN"% .config && \
  sed -r -i s%CT_INSTALL_DIR_RO=y%"#"CT_INSTALL_DIR_RO=y% .config && \
  cat crosstool-config-overrides >> .config

RUN ct-ng build