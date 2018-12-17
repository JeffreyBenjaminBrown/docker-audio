### Ran
apt update
apt upgrade -y
apt install build-essential libsndfile1-dev libasound2-dev libavahi-client-dev libicu-dev libreadline6-dev libfftw3-dev libxt-dev libudev-dev pkg-config git cmake qt5-default qt5-qmake qttools5-dev qttools5-dev-tools qtdeclarative5-dev qtpositioning5-dev libqt5sensors5-dev libqt5opengl5-dev qtwebengine5-dev libqt5svg5-dev libqt5websockets5-dev -y
cd /root
apt-get -s install jackd1 jackd2
  # This already gives me an unmet dependencies error!
  # See "error-1"
sudo apt-get install libjack-jackd2-dev
  # After that, it suggested installing jackd2.
  # I haven't.
git clone --recursive https://github.com/supercollider/supercollider.git
cd supercollider
mkdir build && cd build

## cmake was fiddly
cmake  ..
  # The SC instructions don't mention the Emacs dependency.
  # Trying again.
cmake -SC_EL=no ..
  # Doesn't work. Installing emacs instead.
apt install emacs
cmake  ..
make
make install
ldconfig
