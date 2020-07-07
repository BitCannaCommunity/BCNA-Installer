#!/bin/bash
# --------------------------------------------------------
# Bitcanna Community - Bitcanna Console Management 
# Ver: 1.77
# by: hellresistor
# --------------------------------------------------------

# shellcheck disable=SC1001

BCNAMODE="p"

varys(){
readonly BCNAHOME="$PWD"
readonly BCNACLI="bitcanna-cli"
readonly BCNAD="bitcannad"
readonly SCRPTVER="V1.75"
readonly DONATE="B73RRFVtndfPRNSgSQg34yqz4e9eWyKRSv"
export endc=$'\e[0m'
export sbl=$'\e[4m'
export bld=$'\e[1m'
export white=$'\e[97m'
export background=${endc}$'\e[48;5;235m'${white}
export red=${background}$'\e[38;5;196m'
export green=${background}$'\e[38;5;34m'
export yellow=${background}$'\e[38;5;172m'
export grey=${background}$'\e[1;38;5;252m'
readonly LINE="${grey}+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+"
readonly BORDER1="${grey}+-+"
readonly BORDER2="${grey}+-+\t\t\t\t\t\t\t+-+"
}

bcnafooterconsole(){
echo -e "$BORDER1${grey}_________________${sbl}${yellow} Bitcanna Manager ${grey}__________________$BORDER1"
echo -e "$BORDER1 ${green}P${grey}- ${yellow}StoP Bitcanna\t${BORDER1} ${green}T${grey}- ${yellow}StarT Bitcanna\t\t$BORDER1"
echo -e "$LINE"
echo -e "$BORDER1${grey}___________________${sbl}${red} S Y S T E M ${grey}_____________________$BORDER1"
echo -e "$BORDER1 ${green}S/s${grey}- ${yellow}Shell\t\t${BORDER1}${green} R${grey}- ${red}Reboot\t\t\t$BORDER1"
echo -e "$LINE"
echo -e "$BORDER1 ${red}Donate Bitcanna${grey}: ${green}$DONATE $BORDER1"
echo -e "$BORDER1\t${red}Version${grey}: ${green}$SCRPTVER\t$BORDER1 ${red}by ${green}hellresistor\t\t$BORDER1"
echo -e "$LINE"
}

bcnaheaderconsole(){
# clear
echo -e "$LINE"
echo -e "$BORDER2"
echo -e "$BORDER1\t\t  ${green}Bitcanna ${yellow}User ${red}Console\t\t\t$BORDER1"
echo -e "$BORDER2"
echo -e "$LINE"
}

bcnabasicconsole(){
while true
do
bcnaheaderconsole
bcnafooterconsole
echo -e "${yellow}Choice${grey}: ${background}"
read -r SELECT
case "$SELECT" in
 p|P) "$BCNACLI" stop && break ;;
 t|T) "$BCNAD" -daemon || { echo -e "${grey}--> ${red}Bitcanna Wallet  Failed\nExiting${grey}...${background}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Force power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop > /dev/null 2>&1 ; break ; }
      while true
	  do
	   "$BCNACLI" getinfo > /dev/null 2>&1 && break || echo -e "${yellow}Wait ${grey}...${background}";
       sleep 5
      done
	  break ;;
 s|S) clear
      HELP=1
      "$BCNACLI" help
      break ;;
 r|R) "$BCNACLI" stop
      sudo reboot ;;
 *) echo -e "${red}Really ${grey}!?!? ${red}Missed ${grey}!?"
    sleep 0.5 ;;
 esac
done
}

bcnafullconsole(){
while true
do
# clear
bcnaheaderconsole
echo -e "$BORDER1${grey}___________________${sbl}${yellow} Wallet Info ${grey}_____________________$BORDER1"
echo -e "$BORDER1 ${yellow}Connections${grey}: ${green}$($BCNACLI getconnectioncount)\t${yellow}Blocks${grey}: ${green}$($BCNACLI getblockcount)\t${yellow} MN Counter${grey}:${green}$(bitcanna-cli getmasternodecount | grep 'count' | cut -d\" -d\: -f2) $BORDER1"
echo -e "$BORDER1 ${green}Wallet${grey}: ${yellow}$($BCNACLI getaccountaddress wallet.dat) \t\t${BORDER1}\n${BORDER1} ${green}With Balance${grey}: ${yellow}$($BCNACLI getbalance wallet.dat) \t\t\t\t$BORDER1"
echo -e "$LINE"
if [ "$BCNAMODE" = "p" ] || [ "$BCNAMODE" = "P" ]; then
 echo -e "$BORDER1${grey}__________________${sbl}${yellow} Wallet Manager ${grey}___________________$BORDER1"
 echo -e "$BORDER1\t\t\t$BORDER1\t\t\t\t$BORDER1" 
 echo -e "$BORDER1 ${green}U${grey}- ${yellow}Unlock to STAKE\t$BORDER1 ${green}G${grey}- ${yellow}Get Staking Status\t$BORDER1"
 echo -e "$BORDER1 ${green}E${grey}- ${yellow}Extract Peer List$BORDER1 ${green}I${grey}- ${yellow}Get List Address \t$BORDER1"
 echo -e "$BORDER1 ${green}L${grey}- ${yellow}Lock Wallet\t$BORDER1 ${green}C${grey}- ${yellow}Recalculate STAKE\t$BORDER1"
 echo -e "$BORDER1\t\t\t$BORDER1\t\t\t\t$BORDER1" 
 echo -e "$BORDER1 ${green}O${grey}- ${yellow}Get Info\t\t$BORDER1 ${green}D${grey}- ${yellow}Set Stake Threshold\t$BORDER1"
 echo -e "$BORDER1 ${green}N${grey}- ${yellow}Get Network Info\t$BORDER1 ${green}K${grey}- ${yellow}Get StakeSplit Info\t$BORDER1"
 echo -e "$BORDER1\t\t\t$BORDER1\t\t\t\t$BORDER1" 
elif [ "$BCNAMODE" = "m" ] || [ "$BCNAMODE" = "M" ]; then
 echo -e "$BORDER1${grey}__________________${sbl}${yellow} Wallet Manager ${grey}___________________$BORDER1"
 echo -e "$BORDER1\t\t\t$BORDER1\t\t\t\t$BORDER1" 
 echo -e "$BORDER1 ${green}U${grey}- ${yellow}Unlock to STAKE\t$BORDER1\t\t\t\t$BORDER1"
 echo -e "$BORDER1 ${green}E${grey}- ${yellow}Extract Peer List$BORDER1 ${green}I${grey}- ${yellow}Get List Address \t$BORDER1"
 echo -e "$BORDER1 ${green}L${grey}- ${yellow}Lock Wallet\t$BORDER1\t\t\t\t$BORDER1"
 echo -e "$BORDER1\t\t\t$BORDER1\t\t\t\t$BORDER1" 
 echo -e "$BORDER1 ${green}O${grey}- ${yellow}Get Info\t\t$BORDER1\t\t\t\t$BORDER1"
 echo -e "$BORDER1 ${green}N${grey}- ${yellow}Get Network Info\t$BORDER1\t\t\t\t$BORDER1"
 echo -e "$BORDER1\t\t\t$BORDER1\t\t\t\t$BORDER1" 
else
 echo -e "${red}ERROR ${grey}!! ${red}Maybe someone has hacked this ${grey}:O${endc}" 
 exit 1
fi
echo -e "$LINE"
bcnafooterconsole
echo -e "${yellow}Choice${grey}: ${background}"
read -r SELECT
if [ "$BCNAMODE" = "p" ] || [ "$BCNAMODE" = "P" ]; then
 case "$SELECT" in
 u|U) echo -e "${yellow}Put Wallet Password/Passphrase ${grey}?? " 
      read -p -r -s MWLTPASS
	  "$BCNACLI" walletpassphrase "$MWLTPASS" 0 true || { echo "Wrong Password ..." ; break ; }
	  echo -e "${green}Wallet UNLOCKED ${grey}!!!"
  	  read -n 1 -s -r -p "Press any key to continue" ;;
 g|G) "$BCNACLI" getstakingstatus
   	  echo -e "${green}Get Staking Status ${grey}!!!"
	  read -n 1 -s -r -p "Press any key to continue" ;;
 e|E) bash "$BCNAHOME"/BCNA-ExtractPeerList.sh 
	  echo -e "${green}IP Peer List ${red}Extracted ${grey}!!!"
	  read -n 1 -s -r -p "Press any key to continue" ;;
 c|C) bash "$BCNAHOME"/BCNA-Recalc.sh ;;
 l|L) "$BCNACLI" walletlock 
	  echo -e "${green}Wallet ${red}Locked ${grey}!!!"
   	  read -n 1 -s -r -p "Press any key to continue"  && sleep 0.5 ;;
 o|O) echo -e "${green}Getting Blockchain Information ${grey}!!!"
      "$BCNACLI" getblockchaininfo
	  read -n 1 -s -r -p "Press any key to continue" ;;
 i|I) "$BCNACLI" listaddressgroupings
      read -n 1 -s -r -p "Press any key to continue" ;;
 n|N) "$BCNACLI" getnetworkinfo
      read -n 1 -s -r -p "Press any key to continue" ;;
 k|K) "$BCNACLI" getstakesplitthreshold
      read -n 1 -s -r -p "Press any key to continue" ;;
 d|D) echo -e "${green}Set how much your Stake Split ${grey}(${yellow}${grey}-${yellow}999,999${grey}):${background}"
      read -r SETSTAKE
      "$BCNACLI" setstakesplitthreshold "$SETSTAKE"
      read -n 1 -s -r -p "Press any key to continue" ;;
 p|P) "$BCNACLI" stop && sleep 2
      break ;;
 t|T) echo "Starting Bitcanna POS"
      "$BCNAD" -daemon || { echo -e "${grey}--> ${red}Bitcanna Wallet  Failed\nExiting${grey}...${background}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Force power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop > /dev/null 2>&1 ; break ; }
      while true
	  do
	   "$BCNACLI" getinfo > /dev/null 2>&1 && break || echo -e "${yellow}Wait ${grey}...${background}";
       sleep 5
      done 
	  break ;;
 s|S) clear
      HELP=1
	  "$BCNACLI" help
	  break ;;
 r|R) "$BCNACLI" stop
      sudo reboot ;;
 *) echo -e "${red}Really ${grey}!?!? ${red}Missed ${grey}!?"
    sleep 0.5 ;;
 esac
elif [ "$BCNAMODE" = "m" ] || [ "$BCNAMODE" = "M" ]; then
 case "$SELECT" in
 u|U) echo -e "${yellow}Put Wallet Password/Passphrase ${grey}?? " 
      read -p -r -s MWLTPASS
      "$BCNACLI" walletpassphrase "$MWLTPASS" 0 false || { echo "Wrong Password ..." ; break ; }
      "$BCNACLI" masternode start-many
      echo -e "${green}Wallet UNLOCKED ${grey}!!!" && sleep 0.5 ;;
 e|E) bash "$BCNAHOME"/BCNA-ExtractPeerList.sh 
	  echo -e "${green}IP Peer List ${red}Extracted ${grey}!!!"
	  read -n 1 -s -r -p "Press any key to continue" ;;
 l|L) "$BCNACLI" wallet-lock 
      echo -e "${green}Wallet ${red}Locked ${grey}!!!"
      read -n 1 -s -r -p "Press any key to continue" && sleep 0.5 ;;
 o|O) echo -e "${green}Getting Blockchain Information ${grey}!!!"
      "$BCNACLI" getblockchaininfo
      read -n 1 -s -r -p "Press any key to continue" ;;
 i|I) "$BCNACLI" listaddressgroupings
      read -n 1 -s -r -p "Press any key to continue" ;;
 n|N) "$BCNACLI" getnetworkinfo
       read -n 1 -s -r -p "Press any key to continue" ;;
 p|P) "$BCNACLI" stop && break ;;
 t|T) echo "Starting Bitcanna MasterNode"
      "$BCNAD" --maxconnections=1000 -daemon || { echo -e "${grey}--> ${red}Bitcanna Masternode Failed\nExiting${grey}...${background}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Force power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop > /dev/null 2>&1 ; break ; }
      while true
	  do
	   "$BCNACLI" getinfo > /dev/null 2>&1 && break || echo -e "${yellow}Wait ${grey}...${background}";
       sleep 5
      done ;;
 s|S) # clear
      HELP=1
	  "$BCNACLI" help
       break ;;
 r|R) "$BCNACLI" stop
      sudo reboot ;;
 *) echo -e "${red}Really ${grey}!?!? ${red}Missed ${grey}!?"
    sleep 0.5 ;;
 esac
else
 echo -e "${red}ERROR ${grey}!! ${red}Maybe someone has hacked this ${grey}:O${endc}" 
 exit 1
fi
done
}

varys
if grep -iq '^BCNAMODE="P"\|^BCNAMODE="M"' "$BCNAHOME"/BCNA-Console.sh ; then
 while :
 do
  if [[ "$HELP" -eq 1 ]] ; then
   HELP=0
   break
  fi
  if pgrep -x "$BCNAD" >/dev/null ; then
   bcnafullconsole
  else
   bcnabasicconsole
  fi
 done
else
 echo -e "${red}Check variable BCNAMODE ${grey}!!!${background}\n\t${green}MODEs Avaliable\n\t${green}BCNAMODE=\"P\" ${grey}- ${red}POS${background}\n\t${green}BCNAMODE=\"M\" ${grey}- ${red}Masternode${background}\n"
 exit 1
fi

 