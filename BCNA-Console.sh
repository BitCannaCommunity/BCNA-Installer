#!/bin/bash
# --------------------------------------------------------
# Bitcanna Community - Bitcanna Console Management 
# Ver: 1.80
# by: hellresistor
# --------------------------------------------------------

# shellcheck disable=SC1001

BCNAMODE="NONE"

varys(){
readonly BCNAHOME="$PWD"
readonly BCNACLI="bitcanna-cli"
readonly BCNAD="bitcannad"
readonly SCRPTVER="V1.78"
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
 t|T) if grep -iq '^BCNAMODE="P"' "$BCNAHOME"/BCNA-Console.sh ; then "$BCNAD" -daemon || { echo -e "${grey}--> ${red}Bitcanna Wallet  Failed\nExiting${grey}...${background}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Force power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop > /dev/null 2>&1 ; break ; }; elif grep -iq '^BCNAMODE="M"' "$BCNAHOME"/BCNA-Console.sh ; then "$BCNAD" --maxconnections=1000 -daemon || { echo -e "${grey}--> ${red}Bitcanna Wallet  Failed\nExiting${grey}...${background}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Force power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop > /dev/null 2>&1 ; break ; }; fi
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
 echo -e "$BORDER1 ${green}E${grey}- ${yellow}Extract Peer List$BORDER1 ${green}I${grey}- ${yellow}Get List Address \t$BORDER1"
 echo -e "$BORDER1\t\t\t$BORDER1  ${green}A${grey}- ${yellow}Add a New MN \t$BORDER1" 
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
  	  read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")" ;;
 g|G) "$BCNACLI" getstakingstatus
   	  echo -e "${green}Get Staking Status ${grey}!!!"
	  read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")" ;;
 e|E) bash "$BCNAHOME"/BCNA-ExtractPeerList.sh 
	  echo -e "${green}IP Peer List ${red}Extracted ${grey}!!!"
	  read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")" ;;
 c|C) bash "$BCNAHOME"/BCNA-Recalc.sh ;;
 l|L) "$BCNACLI" walletlock 
	  echo -e "${green}Wallet ${red}Locked ${grey}!!!"
   	  read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")"  && sleep 0.5 ;;
 o|O) echo -e "${green}Getting Blockchain Information ${grey}!!!"
      "$BCNACLI" getblockchaininfo
	  read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")" ;;
 i|I) "$BCNACLI" listaccounts
      read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")" ;;
 n|N) "$BCNACLI" getnetworkinfo
      read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")" ;;
 k|K) "$BCNACLI" getstakesplitthreshold
      read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")" ;;
 d|D) echo -e "${green}Set how much your Stake Split ${grey}(${yellow}${grey}-${yellow}999,999${grey}):${background}"
      read -r SETSTAKE
      "$BCNACLI" setstakesplitthreshold "$SETSTAKE"
      read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")" ;;
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
 a|A) addnewmn ;;
 u|U) echo -e "${yellow}Put Wallet Password/Passphrase ${grey}?? " 
      read -p -r -s MWLTPASS
      "$BCNACLI" walletpassphrase "$MWLTPASS" 0 false || { echo "Wrong Password ..." ; break ; }
      "$BCNACLI" masternode start-many
      echo -e "${green}Wallet UNLOCKED ${grey}!!!" && sleep 0.5 ;;
 e|E) bash "$BCNAHOME"/BCNA-ExtractPeerList.sh 
	  echo -e "${green}IP Peer List ${red}Extracted ${grey}!!!"
	  read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")" ;;
 o|O) echo -e "${green}Getting Blockchain Information ${grey}!!!"
      "$BCNACLI" getblockchaininfo
      read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")" ;;
 i|I) "$BCNACLI" listaddressgroupings
      read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")" ;;
 n|N) "$BCNACLI" getnetworkinfo
       read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")" ;;
 p|P) "$BCNACLI" stop && break ;;
 t|T) echo "Starting Bitcanna MasterNode"
      "$BCNAD" --maxconnections=1000 -daemon || { echo -e "${grey}--> ${red}Bitcanna Masternode Failed\nExiting${grey}...${background}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Force power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop > /dev/null 2>&1 ; break ; }
      while true
	  do
	   "$BCNACLI" getinfo > /dev/null 2>&1 && break || echo -e "${yellow}Wait ${grey}...${background}";
       sleep 5
      done ;;
 s|S) HELP=1
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
addnewmn(){
 echo " IN DEV ... "
echo -e "${grey}--> ${white}Set ID of this Masternode${grey}. Example${grey}: ${green}1 ${grey}- ${white}To 2nd node${grey}, 2 ${grey}- ${white}To 3rd node${grey}... ${white}"
read -r -p "" NEWIDMN
echo -e "${grey}--> ${white}Set Your MasterNode wallet Alias ${grey}(${yellow}Example${grey}: ${green}MN1${grey}, ${green}MN2${grey})... ${white}"
read -r -p "" NEWMNALIAS
echo -e "${grey}--> ${white}SET a NEW Bitcanna Port ${grey}... ${white}" 
read -r-p "" NEWBCNAPORT
echo -e "${grey}--> ${white}Generate your MasterNode Private Key ${grey}...${white}"
readonly NEWMNGENK=$("$BCNACLI" masternode genkey)
echo -e "${grey}--> ${white}Creating NEW Address to MASTERNODE ${grey}-> ${green}$NEWMNALIAS ${white}"
readonly NEWWLTADRSNEW=$("$BCNACLI" getnewaddress "\"$NEWMNALIAS\"")
readonly WLTADRSNEW="$NEWWLTADRSNEW"
echo -e "\n\n${bld}${grey}--> ${white}\tTIME TO SEND 100K COINS TO YOUR ${green}$NEWMNALIAS ${white}wallet address\n\tMy Label ${green}$NEWMNALIAS and ${white}Wallet Address Is: ${green}${sbl}${bld}$WLTADRSNEW${white}\n\n"
while true
do
 echo -e "${grey}--> ${yellow}IDENTIFY YOUR TRANSACTION ID ${grey}!!! \n${white}"
 sleep 1
 echo -e "${grey}--> ${red}VERIFY ${grey}!!!!\n ${yellow}If you get +10 Confirmations of transaction ${grey}!!! \n${white}"
 read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${white}")"
 "$BCNACLI" listtransactions
 echo -e "${grey}--> ${green}Have you IDENTIFY your transaction id ${grey}(${green}TXID${grey}) ? (${green}Y${grey}/${red}N${grey}) \n${white}"
 read -r -p "" CHOILIST
 case "$CHOILIST" in
  y|Y) sleep 0.5 && break ;;
  n|N) echo -e "${yellow}Please${grey}, You need wait +10 Confirmations to continue ${grey}...${white}" ;;
  *) echo -e "\n\n${red}Really ${grey}!?!? ${red}Missed ${grey}!?\n\n" && sleep 0.5 ;;
esac
done
echo -e "${grey}--> ${white}Auto-finding the Collateral Output ${green}TX ${white}and ${green}INDEX\n${white}"
readonly NEWMNID=$("$BCNACLI" masternode outputs | awk -F'"' '{print $6}')
readonly NEWMNTX=$("$BCNACLI" masternode outputs | awk -F'"' '{print $8}')
"$BCNACLI" stop
sleep 5
readonly VPSIP="$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')"
echo "port=$NEWBCNAPORT" >> "$BCNACONF"/bitcanna.conf
echo "$NEWIDMN $NEWMNALIAS $VPSIP:$NEWBCNAPORT $NEWMNGENK $NEWMNID $NEWMNTX" >> "$BCNACONF"/masternode.conf
echo -e "${grey}--> ${white}Running Bitcanna Wallet\n${white}"
"$BCNAD" --maxconnections=1000 -daemon
while true
do 
 "$BCNACLI" getinfo > /dev/null 2>&1 && break || echo -e "${white}${yellow}Wait ${grey}...${white}" ;
 sleep 10
done
echo -e "${grey}--> ${white}Activating All MasterNodes ${grey}...\n${white}"
"$BCNACLI" masternode start-many || { echo -e "${grey}--> ${red}Bitcanna Masternode Failed\nExiting${grey}...${white}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
read -n 1 -s -r -p "$(echo -e "\n${grey}--> ${green}Press any key to continue ${grey}... \n${white}")"
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

 