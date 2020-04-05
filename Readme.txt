# Authored by walt.borovkoff@gmail.com
# Copyright(C) 2020, Walter Borovkoff.
# Permission is granted to copy, distribute and/or modify this
# document under the terms of the GNU Free Documentation License.

# SavUTube is a simple, light weight graphical Ubuntu front end interface
# for “ytdl-org / youtube-dl”, written in bash.  It has a very small foot
# print and requires only three files, (the script itself 5.0kb, its Icon
# 3.6kb, and a menu.desktop file, 280b) so it can be run on small systems
# with limited resources.  The optional command-line parameters can be
# used to set the default download directory, file name, and youtube-dl
# options.  This allows it to be easily added and launched from the menu
# using the included desktop file.


	#########################################
	#					#
	#   Enter: Youtube-URL  [ Option(s) ]	#
	#					#<-------
	#					#	|
	#		[Cancel]	[Start]	#	|
	#########################################	|
#			   |		   |		|
#			   |		   |		|
#	File Option Set?   |		   |	Yes	|
#			   |		   ----------->
#			   |		   |		^
#			   |		   |		|
#			   V		   V		|
	#########################################	|
	#					#	|
	#   Choose: Download File Type Option.	#	|
	#					#	|
	#					#	|
	#		[Exit]		[Next]	#	|
	#########################################	|
#			   |		   |		|
#			   |		   |		|
#			   |		   |		|
#			   X		   -------------

To Install from your download folder, run this file.

# 1st)  copy: "SavUTube.sh & savutube.png" to "/usr/local/bin/"
 sudo cp SavUTube.sh /usr/local/bin/
 sudo cp savutube.png /usr/local/bin/
 sudo chmod a+rx /usr/local/bin/SavUTube.sh

# 2nd)  copy "SavUTubeMenu.desktop" to "/usr/share/applications/"
 sudo cp SavUTubeMenu.desktop /usr/share/applications/
