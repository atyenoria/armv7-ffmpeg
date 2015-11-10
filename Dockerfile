#author atyenoria
#image atyenoria/ffmpeg-armv7

FROM fiorix/crosstool-ng-arm
RUN apt-get update
RUN apt-get install -y git yasm
ENV PATH=${PATH}:/opt/x-tools/arm-unknown-linux-gnueabi/bin/


RUN curl -s http://tipok.org.ua/downloads/media/aac+/libaacplus/libaacplus-2.0.2.tar.gz | tar -zx -C /usr/src
WORKDIR /usr/src/libaacplus-2.0.2
RUN ct-ng-env ./autogen.sh --with-parameter-expansion-string-replace-capable-shell=/bin/bash --enable-static=yes --enable-shared=no --host=arm-unknown-linux-gnueabi --prefix=/opt/ffmpeg
RUN ct-ng-env make
RUN ct-ng-env make install



RUN curl -s http://pkgs.fedoraproject.org/repo/pkgs/alsa-lib/alsa-lib-1.0.25.tar.bz2/06fe5819020c6684b991dcffc5471304/alsa-lib-1.0.25.tar.bz2 | tar -jx -C /usr/src
WORKDIR /usr/src/alsa-lib-1.0.25
RUN ct-ng-env ./configure  --host=arm-unknown-linux-gnueabi --prefix=/opt/ffmpeg --enable-static=yes --enable-shared=no
RUN ct-ng-env make
RUN ct-ng-env make install


RUN git clone git://git.videolan.org/x264 /usr/src/x264
WORKDIR /usr/src/x264
RUN ct-ng-env ./configure --host=arm-unknown-linux-gnueabi --enable-static --cross-prefix='/opt/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-' --prefix=/opt/ffmpeg
RUN ct-ng-env make
RUN ct-ng-env make install



RUN git clone https://github.com/FFmpeg/FFmpeg.git /usr/src/ffmpeg
WORKDIR /usr/src/ffmpeg
RUN ct-ng-env ./configure --enable-cross-compile --cross-prefix='/opt/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-' --arch=armel --target-os=linux --enable-gpl --enable-libx264 --enable-nonfree --enable-libaacplus --enable-static --extra-cflags="-I/opt/ffmpeg/include" --extra-ldflags="-L/opt/ffmpeg/lib" --extra-libs=-ldl --prefix=/opt/ffmpeg


RUN ct-ng-env make
RUN ct-ng-env make install
WORKDIR /opt/ffmpeg