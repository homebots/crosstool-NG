FROM homebotz/debian-dev

WORKDIR /home/crosstool
ADD . /home/crosstool
RUN ./bootstrap && ./configure --prefix=`pwd` && make MAKELEVEL=0 && make install MAKELEVEL=0
ENV CT_EXPERIMENTAL=y
ENV CT_ALLOW_BUILD_AS_ROOT=y
ENV CT_ALLOW_BUILD_AS_ROOT_SURE=y
ENV PATH=/home/crosstool:$PATH
ENV TOOLCHAIN="/home/crosstool/xtensa-lx106-elf"
RUN ct-ng xtensa-lx106-elf && \
  sed -r -i.org s%CT_PREFIX_DIR=.*%CT_PREFIX_DIR="$TOOLCHAIN"% .config && \
  sed -r -i s%CT_INSTALL_DIR_RO=y%"#"CT_INSTALL_DIR_RO=y% .config && \
  sed 's/CT_LOG_PROGRESS_BAR/# CT_LOG_PROGRESS_BAR/' -i .config && \
  cat crosstool-config-overrides >> .config

RUN apt update && apt install -y python
RUN ct-ng build
RUN apt remove -y python
RUN mkdir /home/project
WORKDIR /home/project
ENV PATH=/home/crosstool/xtensa-lx106-elf/xtensa-lx106-elf/bin:/home/crosstool/xtensa-lx106-elf/bin:$PATH
