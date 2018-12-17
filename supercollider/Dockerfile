FROM ubuntu:18.04

RUN apt update        \
    && apt upgrade -y

RUN apt install build-essential libsndfile1-dev libasound2-dev libavahi-client-dev libicu-dev libreadline6-dev libfftw3-dev libxt-dev libudev-dev pkg-config git cmake qt5-default qt5-qmake qttools5-dev qttools5-dev-tools qtdeclarative5-dev qtpositioning5-dev libqt5sensors5-dev libqt5opengl5-dev qtwebengine5-dev libqt5svg5-dev libqt5websockets5-dev emacs libjack-jackd2-dev -y

### Make SuperCollider (divided because long steps may be timing out)
RUN cd root                                                          \
    && git clone                                                     \
      --recursive https://github.com/supercollider/supercollider.git \
    && cd supercollider && mkdir build && cd build                   \
    && cmake ..
RUN cd /root/supercollider/build && make
RUN cd /root/supercollider/build && make install                     \
  && ldconfig

### Install KXStudio
RUN apt-get install apt-transport-https software-properties-common wget -y
RUN wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_9.5.1~kxstudio3_all.deb
RUN dpkg -i kxstudio-repos_9.5.1~kxstudio3_all.deb
RUN apt update
RUN apt install kxstudio-meta-audio -y

# It breaks here
RUN apt install kxstudio-meta-audio-plugins -y
RUN apt install kxstudio-meta-restricted-extras -y
