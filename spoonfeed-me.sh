#!/bin/bash

#Zenity fix attempter for Ark Survival Evolved, V 1.0
#Created by 123 for Linux Potatoes (aka newbies) using ♥♥♥♥♥♥ code. Temp Fix for Zenity not working until Steam decides wtf to do with it properly or WildCard decides to fix their ♥♥♥♥♥♥ ♥♥♥♥
#They have made some attempts to fix it, but it does not work if the application itself does not use their workaround. WildCard sucks so ofc they have
#not fixed it.
#This fixes the issue by giving steam the systems own zenity binary. Script has only been tested on Manjaro XFCE!
#This script must be run using sudo ./spoonfeed-me.sh otherwise it will immediatly stop.
#Do not alter this script unless you have steam itself installed somewhere else for some wierd reason.
#Run this shell script after every steam update, 
#delete the zenity file at /home/yourusername/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/bin
#just incase Steam decides to overwrite the zenity you got from the filesystem with their own again.
#The script will download a fresh copy of the original steam's zenity file from MY dropbox if you delete zenity from
#/home/yourusername/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/bin
#folder! It also does a SHA1 checksum to ensure that it really is the original zenity file that Steam provided at 24th March 2020 that was
#downloaded from my dropbox.

#If you delete the Backflupp folder. You must also delete zenity in /home/yourusername/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/bin
#if you also want to redownload the original zenity file. Otherwise the systems zenity file is placed into the Backflupp folder. Making this pointless.


if [ "$EUID" -ne 0 ]
  then echo "You must run this as root in order to properly copy zenity from the filesystem"
  echo "into steams folders and to change ownership of files etc."
  echo ""
  read -n 1 -s -r -p "Press any key to exit, failed due to not running the program with sudo"
  exit
fi

set -e

userr=$(logname)

DIR="/home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/Backflupp"
if [ ! -d "$DIR" ]; then
  # Take action if $DIR exists. #
  mkdir /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/Backflupp
  chown "$userr":"$userr" /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/Backflupp
  echo "Created the Backflupp folder and made it owned by $userr."
fi
echo "Setting shellscript to exit incase anything wierd happens or something does not work."


echo "Running the commands to copy the original zenity file that steam"
echo "provided into Backflupp"
echo ""

if [ -f /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/zenity ] && [ ! -f /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/Backflupp/zenity ]; then
    cp /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/zenity /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/Backflupp
elif [ ! -f /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/zenity ]; then
	echo "For some reason you seem to be missing the zenity that is provided by Steam, or you deleted it."
	echo "Downloading the original file from dropbox."
	wget https://www.dropbox.com/s/9cpvelx4ban4as8/zenity -O /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/zenity
	echo "Making the zenity file executeable (so it is prepared for usage later if you"
	echo "need the original file that steam provides"
	chmod +x /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/zenity
	echo "Checking the SHA1 checksum of the downloaded zenity file to see if it matches the following checksum:"
	echo "817b82133f37ad8d043144d0a438fda5a1c05d10"
	echo "If downloaded file checksum does not match that, the shellscript will terminate"
	echo ""
	sha1sum -c <<<"817b82133f37ad8d043144d0a438fda5a1c05d10 */home/$userr/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/zenity"
	echo "Now we can copy the zenity file into the Backflupp folder!"
	cp /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/zenity /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/Backflupp
	echo "Chowning the downloaded file so it can be used by YOU"
	echo "later if you need to restore it."
	chown "$userr":"$userr" /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/Backflupp/zenity
	echo "Done getting the original zenity file as was provided by steam for"
	echo "safe keeping and getting it into the Backflupp folder,"
	echo "proceeding with the rest of the script."
	echo ""
else
	echo "There was no need to do anything with Backflupp, it already contains"
	echo "the original zenity file that Steam provided."
	echo ""
fi



echo "Copying the zenity file from the file system to steam's bin folder"
cp /usr/bin/zenity /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin
echo "chowning the copied file (zenity in the file system is owned by root, it must be owned by YOU in order to work."
chown "$userr":"$userr" /home/"$userr"/.steam/steam/ubuntu12_32/steam-runtime/amd64/usr/bin/zenity
echo ""
echo "Done..."
echo "Ark will now be able to properly display it's Error Crash Window"
echo "if you are using the Native Linux Client."
read -n 1 -s -r -p "Press any key to exit, if you see this all operations was successfull! :)"