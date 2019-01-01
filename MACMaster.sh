#!/bin/bash



banner()
{
echo -e "\e[91m  ╔╦╗╔═╗╔═╗  ╔╦╗┌─┐┌─┐┌┬┐┌─┐┬─┐  ╔╦╗┌─┐┌─┐┬   "
echo -e "\e[91m  ║║║╠═╣║    ║║║├─┤└─┐ │ ├┤ ├┬┘   ║ │ ││ ││   "
echo -e "\e[91m  ╩ ╩╩ ╩╚═╝  ╩ ╩┴ ┴└─┘ ┴ └─┘┴└─   ╩ └─┘└─┘┴─┘ "
echo -e "\e[93m                 Made by : Waseem Sajjad"
echo -e "\e[93m   https://secrethackersite.blogspot.com"
echo
}
banner
cou=1
gen()
{
	for (( i = 0; i < 10; i++ )); do
		hexchars="0123456789ABCDEF"
		end=$( for i in {1..6} ; do echo -n ${hexchars:$(( $RANDOM % 16 )):1} ; done | sed -e 's/\(..\)/:\1/g' )
		echo    $cou : 08:00:27$end
		((cou++))
	done
}

help()
{
	echo " [*] ./MACMaster.sh <options>"
	echo " -h    :  show help "
	echo " -g    :  Generate MAC Address "
	echo " -u    :  Change MAC Address  "
	echo " -s    :  Show Current MAC Address "
	echo " -p    :  Permanent MAC Address "
	echo " -r    :  Reset to original hardware MAC
"
}
update()
{

	read -p "Enter Interface : " int
	read -p "Enter MAC Address : " macc
	ifconfig $int down
	sleep 5
	macchanger $int -m $macc
	sleep 2
	ifconfig $int up
}
show()
{
	read -p "Enter Interface : " sin
	macchanger $sin -s | grep "Current MAC:"
}
Permanent()
{
	read -p "Enter Interface : " pin
	macchanger $pin -s | grep "Permanent MAC:"
}

re()
{
	read -p "Enter Interface : " rin
	macchanger $rin -p
	ifconfig $rin up
}

chk()
{
if ! [ -x "$(command -v macchanger)" ]; then
	sudo apt-get install macchanger
	exit 0
fi
}
chk
case $1 in
	-g )
		gen;;
	-u )
		update;;
	-h )
		help;;
	 -s )
		show;;
	 -p )
		Permanent;;
	 -r )
		re;;
	* )
		help;;
esac
exit 0