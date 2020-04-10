#!/bin/bash
#file location:
#/usr/local/bin/SavUTube.sh, ./savutube.png, ./youtube-dl
#/usr/share/applications/SavUTube.desktop
#Authored by walt.borovkoff@gmail.com
#Copyright(C) 2020  Walter Borovkoff.
#Permission is granted to copy, distribute and/or modify this
#document under the terms of the GNU Free Documentation License.
DeF="%(title)s"	#DeFault template
EtO="18000"	#Error time Out
EdB=""		#Enable deBugging
VeR=" v200409"
TiL="SavUTube  "
IcN="savutube.png"
TeM=$(mktemp -u)
NiN=$'\n'
pause() { read -p "$* Continue? (Y/N): " cNf && [[ $cNf == [yY] ]] || exit 1; }
# Display Help
HlP () {
local hLp=""
local bLk="Usage:	$TiL  [ Option(s) ]

1)	Change working directory before processing.
	[ ~/path/ | ./Relative/path/ | /absolute/path/ ]

2)	Set the output file name.
	[ output-filename | output-template ]

3)	Both options together: [[ option1 ][ option2 ]]

Example:
	\"https://youtube.com/watch?v=AbCdEfGhIjK  ~/Music/out-%(id)s\"

	Entered in to the \"URL\" input box will download to users
	Music directory, using \"out-AbCdEfGhIjK\" as the filename.
	Options are entered after the \"URL\" followed by a space.

Menu Setup:
	\"Exec = SavUTube.sh ~/Videos/\"
	Edited into the \"savutube.desktop\" file, to set the default
	directory to \"Videos\".

Shell Command:
	 SavUTube.sh \"~/URFolder/URFile-%(title)s-%(id)s\"

	Entered on the command line will set the interim defaults,
	and options must be in quotes.

	SavUTube -h or --help to display this dialog.

Notes:
	If no options are given the current directory and template,
	\"$DeF\" will be used.
	The Icon must be in the same directory as the Script.
	A \"~\" equals the current user home directory.
	The \"|\" means this \"or\" that choice.


$TiL$VeR"
# End bLk
until [ "$hLp" = "1"  ]; do
	echo "$bLk" | zenity  2>/dev/null\
	--window-icon="$IcN" --title="$TiL$VeR" --width=620 --height=410\
	--cancel-label="Done" --ok-label="More" --text-info
# Page 2
	if [ $? = "1" ]; then break; fi
	youtube-dl --help | zenity  2>/dev/null\
	--window-icon="$IcN" --title="Youtube-DL  Options" --width 620 --height=410\
	--cancel-label="Done" --ok-label="Repeat" --text-info
	hLp=$?
done
bLk=""
}
# Check Path & File
CkM () {
if [[ ${PrM:0:1} = '~' ]]; then cd `cd ~/ `; PrM=".${PrM:1}"; fi
if [ ! -z ${PrM##*/} ]; then FnO="${PrM##*/}"; PrM="${PrM%$FnO}"; fi
cd "$PrM" 2>/dev/null
if [ $? = 1 ]; then FlD=""; FnO=""
	notify-send -i error -t $EtO "${TiL}Error, Path Not Found:${NiN}$PrM"; fi
}
# Find Icon Path
IcN="${0%/*}/$IcN"
if [[ ${0:0:1} = '.' ]]; then IcN="$PWD${IcN:1}"; fi
# Check Command-Line, Help, or Get Path & Change Default
if [ $# -ne 0 ]; then
	if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then HlP; exit 1
	else PrM="$1"; CkM; if [[ ${FnO:0:1} = '%' ]]; then DeF=$FnO; fi
	fi
fi
# Main Loop Start
while true; do
	FnO=$DeF
	until [ "$FlD" != "" ]; do
	MsG="Directory: \"$PWD\"${NiN}File or Template: \"$FnO\"\n"
	MsG="${MsG}\nEnter: Youtube-URL  [ Option(s) ]  or enter \"help\""
	FlD=`zenity 2>/dev/null\
		--window-icon="$IcN" --title="$TiL$VeR" --width=520 --height=206\
		--entry --entry-text=$UrL\
		--text="$MsG"\
		--ok-label="Start"`
		if [ $? = "1" ]; then ChC=""; break; fi
		if [ "$FlD" = "help" ]; then FlD=""; HlP; fi
	done
# Get Option
	until [ "$ChC" != "" ]; do
	ChC=`zenity 2>/dev/null\
		--window-icon="$IcN" --title="$TiL$VeR" --width=520 --height=206\
		--list --radiolist\
		--text="Options:"\
		--column="Select"\
		--column="Description"\
		--column="Option"\
		--hide-column=3\
		--print-column=3\
		FALSE "Download audio part only in MP3-format." A\
		FALSE "Download the complete video in MP4-format." V\
		FALSE "Download and Keep the files after processing." K\
		--ok-label="Next"\
		--cancel-label="Exit"`
		if [ $? = 1 ]; then exit; fi
	done
 while [[ ! -z $FlD ]]; do
# Build Parameters
	UrL=${FlD% *}
	if [ "${FlD##* }" != "$UrL" ]; then PrM="${FlD##* }"; CkM; fi
	if [ -z "$FlD" ]; then break; fi
# OK: Build Option
	case $ChC in
		A) OpT="-x --audio-format mp3"; MsG="MP3 Audio"
		if [ ! -z $FnO ]; then OpT="$OpT -o $FnO.mp3"; fi
		;;
		V) OpT="-f mp4"; MsG="MP4 Video"
		if [ ! -z $FnO ]; then OpT="$OpT -o $FnO.mp4"; fi
		;;
		K) OpT="-k"; MsG="Keep All Files"
		if [ ! -z $FnO ]; then OpT="$OpT -o $FnO"; fi
		;;
		*) notify-send -i error -u critical "$TiL${NiN}${NiN}Fatal Internal Error!"
		exit -1 ;;
	esac
# Debugging Message
	if [ ! -z $EdB ]; then pause "$FlD $NiN $UrL $NiN $PrM $NiN $FnO $NiN $PWD $NiN $DeF $NiN $ChC $OpT $NiN"; fi
# Progress Flag
	mkfifo $TeM
# Display Progress Bar
	(< $TeM | zenity 2>/dev/null\
		--progress  --width=520 --height=100 --pulsate --auto-close --no-cancel )\
			& (youtube-dl $OpT $UrL)
		if [ $? = 0 ]; then notify-send -i info "$TiL${NiN}$MsG Completed from:${NiN}$UrL${NiN}Saved to: $PWD"
		else notify-send -i error -t $EtO "$TiL${NiN}$MsG Failed from:${NiN}$UrL${NiN}"; fi
# Set Completed & Remove Flag
		echo 'EOF' > $TeM
		rm -f $TeM; FlD=""; UrL=""
 done
# Main Loop End
done
#	“Those who know, do not speak. Those who speak, do not know” ~ The Tao