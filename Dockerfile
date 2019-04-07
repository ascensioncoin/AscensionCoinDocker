FROM ubuntu:14.04
RUN apt-get update && apt-get install -y wget build-essential libtool autotools-dev autoconf pkg-config libssl-dev libevent-dev libboost-all-dev git libminiupnpc-dev libevent-dev

WORKDIR /asn/
RUN wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
RUN tar -xzvf db-4.8.30.NC.tar.gz && rm db-4.8.30.NC.tar.gz
RUN cd db-4.8.30.NC/build_unix && ../dist/configure --enable-cxx && make && make install
ENV BDB_INCLUDE_PATH /usr/local/BerkeleyDB.4.8/include
ENV BDB_LIB_PATH /usr/local/BerkeleyDB.4.8/lib
RUN ln -s /usr/local/BerkeleyDB.4.8/lib/libdb-4.8.so /usr/lib/libdb-4.8.so
RUN ln -s /usr/local/BerkeleyDB.4.8/lib/libdb_cxx-4.8.so /usr/lib/libdb_cxx-4.8.so
RUN rm -r db-4.8.30.NC

RUN git clone https://github.com/ascensioncoin/AscensionCoin
RUN cd AscensionCoin/src && cd leveldb && chmod +x build_detect_platform
RUN cd AscensionCoin/src && make -f makefile.unix USE_UPNP=- STATIC=1 && strip ascensiond
RUN mv AscensionCoin/src/ascensiond /usr/bin
RUN rm -r AscensionCoin

ADD run.sh run.sh
ENTRYPOINT ["/asn/run.sh"]
