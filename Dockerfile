FROM darlanalves/debian-dev

WORKDIR /home/target
ADD . /home/target
RUN ./bootstrap && ./configure --prefix=`pwd` && make MAKELEVEL=0 && make install MAKELEVEL=0
ENV PATH=/home/target:$PATH