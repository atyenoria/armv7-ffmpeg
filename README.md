# Github
https://github.com/atyenoria/ffmpeg-armv7

# Synopsis
This docker image creates ffmpeg static binary working on armv7(rasspi 2) with cross-compile method.

# Usage
First, cross build armv7 ffmpeg on local machine. this task takes long. Be patient.

    git clone https://github.com/atyenoria/ffmpeg-armv7.git
    cd ffmpeg-armv7
    docker build -t atyenoria/ffmpeg-armv7f .

Copy created packed directory from docker container to local machine.

    docker cp $(container id):/opt/ffmpeg .

Send this to armv7 target and run.


    $ ./ffmpeg/bin/ffmpeg

    ffmpeg version N-76529-gddbad15 Copyright (c) 2000-2015 the FFmpeg developers
    built with gcc 4.8.3 (crosstool-NG 1.20.0) 20140106 (prerelease)
    configuration: --enable-cross-compile --cross-prefix=/opt/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi- --arch=armel <--target-> </--target->os=linux --enable-gpl --enable-libx264 --enable-nonfree --enable-libaacplus --enable-static --extra-cflags=-I/opt/ffmpeg/include --extra-ldflags=<-L>    </-L>/opt/ffmpeg/lib --extra-libs=-ldl --prefix=/opt/ffmpeg
    libavutil      55.  5.100 / 55.  5.100
    libavcodec     57. 15.100 / 57. 15.100
    libavformat    57. 14.100 / 57. 14.100
    libavdevice    57.  0.100 / 57.  0.100
    libavfilter     6. 15.100 /  6. 15.100
    libswscale      4.  0.100 /  4.  0.100
    libswresample   2.  0.101 /  2.  0.101
    libpostproc    54.  0.100 / 54.  0.100
    Hyper fast Audio and Video encoder
    usage: ffmpeg [options] [[infile options] -i infile]... {[outfile options] outfile}...

Comp.

# Tested target machine
    Build on mac os x 10.10.5 using boot2docker
    Execute on rasspberry pi 2

# References
https://github.com/fiorix/crosstool-ng-arm/blob/master/Dockerfile

https://github.com/fiorix/ffmpeg-arm

https://trac.ffmpeg.org/wiki/CompilationGuide/RaspberryPi

http://vinsol.com/blog/2014/07/30/cross-compiling-ffmpeg-with-x264-for-android/

http://crosstool-ng.org/