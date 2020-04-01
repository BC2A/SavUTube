# 1st)  Install: "youtube-dl"	See: https://yt-dl.org/

sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
hash -r

# 2nd)  Install: python-minimal, & ffmpeg
apt install python-minimal
apt install ffmpeg

# 2nd)	or Using Synaptic Package Manager:

# To install "python-minimal",
# will install the following packages:
#	libpython-stdlib (2.7.15~rc1-1)
#	python (2.7.15~rc1-1)
#	python-minimal (2.7.15~rc1-1)
#	python2.7 (2.7.17-1~18.04)
#	python2.7-minimal (2.7.17-1~18.04)

# To install "ffmpeg",
# will install the following packages:
#	ffmpeg (7:3.4.6-0ubuntu0.18.04.1)
#	libavdevice57 (7:3.4.6-0ubuntu0.18.04.1)
#	libdc1394-22 (2.2.5-1)
#	libopenal-data (1:1.18.2-2)
#	libopenal1 (1:1.18.2-2)
#	libsdl2-2.0-0 (2.0.8+dfsg1-1ubuntu1.18.04.4)
#	libsndio6.1 (1.1.0-3)

# 3rd)  copy: "SavUTube.sh & savutube.png" to "/usr/local/bin/"
# sudo cp SavUTube.sh /usr/local/bin/
# sudo cp savutube.png /usr/local/bin/
# sudo chmod a+rx /usr/local/bin/SavUTube.sh

# 4th)  copy "SavUTubeMenu.desktop" to "/usr/share/applications/"
# sudo cp SavUTubeMenu.desktop /usr/share/applications/




