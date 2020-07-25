#!/bin/bash
#--------------------------------------------#
#  A BitCanna Community Installation Script  #
#                NO OFFICIAL                 #   
#--------------------------------------------#
#--------------------------------------------#
#               Version: V1.80               #
#          Donate BitCanna Address:          #
# --> B73RRFVtndfPRNSgSQg34yqz4e9eWyKRSv <-- #
#--------------------------------------------#
#!/bin/bash
colors(){
# Rainbow on our lives
export endc=$'\e[0m'
export sbl=$'\e[4m'
export bld=$'\e[1m'
export blk=$'\e[5m'
export deflt=${bld}$'\e[97m'
export bkwhite=${endc}$'\e[48;5;235m'${deflt}
export red=${bkwhite}$'\e[38;5;196m'
export green=${bkwhite}$'\e[38;5;34m'
export yellow=${bkwhite}$'\e[38;5;172m'
export grey=${bkwhite}$'\e[1;38;5;252m'
}
varys(){
# System variables
DATENOW=$(date +"%Y%m%d%H%M%S")
readonly packages=( "unzip" )
readonly BCNAREP="https://github.com/BitCannaGlobal/BCNA/releases/download"
readonly GETLAST=$(curl --silent "https://api.github.com/repos/BitCannaGlobal/BCNA/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
readonly GETLASTBOOT=$(curl --silent "https://api.github.com/repos/BitCannaCommunity/Bootstrap/releases/latest" | grep -Po '"name": "\K.*?(?=.zip)')
readonly BCNABOOT=$(curl --silent "https://api.github.com/repos/BitCannaCommunity/Bootstrap/releases/latest" | grep 'browser_' | cut -d\" -f4)
readonly BCNAPKG="bcna-$GETLAST-unix"
readonly BCNAHOME="$PWD"
readonly BCNACONF=".bitcanna"
readonly BCNADIR="Bitcanna"
readonly BCNAPORT="12888"
readonly BCNACLI="bitcanna-cli"
readonly BCNAD="bitcannad"
readonly VPSIP="$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')"
readonly SCRPTVER="V1.80"
readonly DONATE="B73RRFVtndfPRNSgSQg34yqz4e9eWyKRSv"
}
dependencies(){
for i in "${packages[@]}"
do
    command -v "$i" > /dev/null 2>&1 || { 
        echo -e >&2 "${grey}--> ${bkwhite}Package(s) ${green}$i ${bkwhite}required ${grey}!!!${bkwhite}\n";
        echo -e "${grey}--> ${bkwhite}Installing ${green}$i ${bkwhite}package ${grey}...${bkwhite}\n"; 
        sleep 0.5
        sudo apt install "$i" > /dev/null 2>&1 ;
    }
done
}
intro(){
echo -e "${bkwhite}\n${green}  bbc                              Script Contribution to BitCanna Community\n${green}  bbb                                     to Ubuntu 18.04 LTS Server\n${green}  bbbbb                            ${grey}-------------------------------------------\n${green}  bbbbb                              ${bkwhite}Executing this script you are Allow to${grey}:\n${green}  bbbbb   cbcb          bbbbbb \n${green}  bbbbb bbbbbbbbb     bbbbbbbbbb     ${grey}- ${bkwhite}Install ${bkwhite}/ ${bkwhite}Update ${bkwhite}/ ${bkwhite}Remove BCNA Wallet\n${green}  bbbcb bbbbbbbbbb   cbbbbbbcbbbb    ${grey}- ${bkwhite}Configure Full Node ${grey}(${bkwhite}Proof-Of-Stake${grey})\n${green}  bbbbbbbb    bbbbbibbbb      cbbb   ${grey}- ${bkwhite}Configure Master Node ${grey}(${bkwhite}MN${grey})\n${green}  bbbbib        bbb bibbb  \n${green}  bbbbib         bbbbbb             ${grey}------------------------------------------\n${green}  bbbbbb         bbbbbb  \n${green}  bbcbbb         bbbbcb                       ${bkwhite}Project Ver${grey}: ${bld}${yellow}$SCRPTVER${green}\n${green}  bbbbbb         bbbbbcb \n${green}  bbbbbbbb      bbbbbbbbbc     cbbb              ${bkwhite}by hellresistor \n${green}    bbbbbbbbbbbbbcbb bbbbbbbbbbbbb   ${bkwhite}Support donate seeds/CBD with Bitcanna\n${green}     bbbbbbbbbbb bbb cbbbbbbbbbib \n${green}       bbbbbbbbb       bbbbibbbb    ${bkwhite}BCNA${grey}: ${yellow}${bld}${sbl}$DONATE${bkwhite}\n\n\n${bld}${sbl}${red}    HAVE IN MIND!! EVERY TIME DO YOUR OWN BACKUPS BEFORE USING THIS SCRIPT\n${bld}${sbl}${red}           I have NO responsability about system/wallet corruption!\n${bld}${sbl}${yellow}                       Use this Script at your own risk!${bkwhite}\n\n"
}
checkin(){
sleep 0.5
echo -e "${grey}(${green}I${grey})${green}nstall ${grey}, (${yellow}U${grey})${yellow}pdate ${grey}, (${red}R${grey})${red}emove ${grey}:${bkwhite}\n"
read -r choix
if [ "$choix" == "i" ] || [ "$choix" == "I" ]; then 
 echo -e "${grey}--> ${bkwhite}New and Clean installation of Bitcanna wallet${bkwhite}"
 sleep 0.5
if [[ ! -a $(find "/usr/bin" -name "$BCNAD") ]] ; then
  bcnadown
  choice
  final
  console
 else
  echo -e "${grey}--> ${yellow}Detected Bitcanna wallet already installed!\n${grey}--> ${bkwhite}Please Run Update${endc}" && exit 1
 fi
elif [ "$choix" == "u" ] || [ "$choix" == "U" ]; then 
  echo -e "${grey}--> ${bkwhite}Update to last version of Bitcanna wallet${grey}...${bkwhite}"
 if [[ -a $(find "/usr/bin" -name "$BCNAD") ]] ; then
   echo -e "${grey}--> ${green}Old Bitcanna version found!\n${grey}--> ${bkwhite}UPDATING Bitcanna${bkwhite}"
   "$BCNACLI" stop > /dev/null 2>&1 || echo -e "${grey}--> ${yellow}Bitcanna Wallet is not Running${grey}...${bkwhite}"
   sleep 5
   rm -R "$BCNADIR"
   sudo rm -f /usr/bin/bitcanna*
   bcnadown
   mess
   echo -e "${grey}--> ${green}Bitcanna Wallet Updated to NEW version: $GETLAST ${bkwhite}\n To start wallet run: bitcannad -daemon" && sleep 0.5
  else
   echo -e "${grey}--> ${red}Can not find Bitcanna Wallet ${grey}!!!\n${green}Install It First ${grey}!!!\n${bkwhite}" && exit 1
  fi
elif [ "$choix" == "r" ] || [ "$choix" == "R" ]; then 
 if [[ -a $(find "/usr/bin" -name "$BCNAD") ]] ; then
   echo -e "${grey}--> ${yellow}Old Bitcanna version found!\n${grey}--> ${red}FULL REMOVING Bitcanna${bkwhite}" && sleep 0.5
   "$BCNACLI" stop > /dev/null 2>&1 || echo -e "${grey}--> ${yellow}Bitcanna Wallet is not Running${grey}...${bkwhite}"
   sleep 5
   cp -f -r --preserve "$BCNACONF" "$BCNACONF"."$DATENOW"
   mess
   rm BCNA-Console.sh
   rm BCNA-ExtractPeerList.sh
   rm BCNA-Recalc.sh
   rm -R "$BCNACONF"
   rm -R "$BCNADIR"
   sudo rm -f /usr/bin/bitcanna*
   echo -e "${grey}--> ${red}Bitcanna Wallet ${green}FULLY ${red}Removed ${grey}!!!${bkwhite}"
  else
   echo -e "${grey}--> ${red}Bitcanna Wallet not exist!\n${green}Install it${grey}...\n${bkwhite}" && exit 1
  fi
 else
  echo -e "${grey}--> ${red}Choose a correct option${grey}!\n${red}Exiting${grey}...${endc}" && exit 1
fi
}
bcnadown(){
echo -e "${grey}--> ${bkwhite}Lets Download and Extract the Bitcanna Wallet from GitHub\n${bkwhite}"
sleep 0.5
[ -d "$BCNACONF" ] && cp -f -r --preserve "$BCNACONF" "$BCNACONF.${DATENOW}"
[ ! -e "$BCNAPKG.zip" ] && echo -e "${grey}--> ${bkwhite}Downloading $BCNAPKG.zip ${grey}...." && wget -f "$BCNAREP/$GETLAST/$BCNAPKG.zip" > /dev/null 2>&1
mkdir "$BCNADIR"
echo -e "${grey}--> ${bkwhite}Extracting $BCNAPKG.zip ${grey}...."
unzip -o "$BCNAPKG".zip > /dev/null 2>&1
if [[ -n $(find ~ -name "unix-*") ]]; then
 cp -f unix-*/* "$BCNADIR" > /dev/null 2>&1
elif [[ -n $(find ~ -name "unix_*") ]]; then
 cp -f unix_*/* "$BCNADIR" > /dev/null 2>&1
elif [[ -n $(find ~ -name "bcna-$GETLAST-unix") ]]; then
 cp -f bcna-"$GETLAST"-unix/* "$BCNADIR" > /dev/null 2>&1
else
 echo -e "${red}ERROR on Extracting. Check extracted folder name structure${endc}" && sleep 0.5 && exit 1
fi
echo -e "${grey}--> ${bkwhite}Copy binaries to right place ${grey}!!\n${bkwhite}"
sudo cp -f "$BCNADIR"/* /usr/bin
sudo chmod +x /usr/bin/bitcanna* 
echo -e "${grey}--> ${green}Downloaded and Extracted to${grey}: ${green}$BCNADIR${bkwhite}"
echo -e "${grey}--> ${bkwhite}Putting Bitcanna Community Scripts on right place ${grey}...\n${bkwhite}"
ln -f BCNA-Installer/BCNA-ExtractPeerList.sh BCNA-ExtractPeerList.sh
ln -f BCNA-Installer/BCNA-Recalc.sh BCNA-Recalc.sh
sleep 0.5
}
choice(){
while true
do
echo -e "${bkwhite}\n\n${grey}--> ${bkwhite}Wich you need Install/Configure ${grey}? (${green}${bld}P${grey}/${yellow}${bld}M${grey})${bkwhite}"
echo -e "${green}${bld}      P ${grey}- ${green}Full Node ${grey}(${green}POStake${grey}) ${bkwhite}\n${yellow}${bld}      M ${grey}- ${yellow}MasterNode ${grey}(${yellow}MN${grey})${bkwhite}\n"
read -r choiz
case "$choiz" in
    p|P) echo -e "${grey}--> ${bkwhite}Selected Full Node${bkwhite}"
         firstrun
         walletposconf
         backup
	 break ;;
    m|M) echo -e "${grey}--> ${bkwhite}Selected Master Node Configuration${bkwhite}"
         firstrun
         walletmnconf
         backup
	 break ;;
      *) echo -e "${red}Really ${grey}!?!? ${red}Missed ${grey}!?"
         sleep 0.5 ;;
esac
done
}
firstrun(){
echo -e "${grey}--> ${bkwhite}First Run of Bitcanna Wallet ${grey}... ${bkwhite}"
echo -e "${grey}--> ${bkwhite}Lets Generate Random RPC User and Password ${grey}... ${bkwhite}"
mkdir "$BCNACONF" > /dev/null 2>&1
touch "$BCNACONF"/bitcanna.conf
RPCUSR=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
RPCPWD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
echo "rpcuser=$RPCUSR" >> "$BCNACONF"/bitcanna.conf
echo "rpcpassword=$RPCPWD" >> "$BCNACONF"/bitcanna.conf
chmod 600 "$BCNACONF"/bitcanna.conf
echo -e "${grey}--> ${green}Random RPC User and Password generated ${grey}!!! ${bkwhite}"
"$BCNAD" -daemon && sleep 10 && "$BCNACLI" stop && sleep 5
echo -e "${grey}--> ${yellow}Removing masternod.conf file ${grey}...${bkwhite}\n"
rm "$BCNACONF"/masternode.conf
}
walletposconf(){
syncr
echo -e "${grey}--> ${bkwhite}Lets Check again ${grey}...${bkwhite}"
sleep 1.5
syncr2
echo -e "${grey}--> ${green}YES${grey}!! ${green}REALLY${grey}!! ${green}Bitcanna Wallet Fully Syncronized ${grey}!!!${bkwhite}\n"
sleep 1.5
walletrec
cryptwallet
WLTADRS=$("$BCNACLI" getaccountaddress wallet.dat)
echo -e "\n${grey}--> ${green}CONGRATULATIONS ${grey}!! ${green}BitCanna POS ${grey}- ${green}Proof-Of-Stake Configurations COMPLETED ${grey}!!!${bkwhite}\n"
sleep 1.5
echo -e "${blk}${grey}--> ${bkwhite}TIME TO SEND SOME COINS TO YOUR wallet address\n      My Wallet Address Is: ${green}${sbl}${bld}$WLTADRS${bkwhite}\n\n"
read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${bkwhite}")"
}
walletmnconf(){
echo "staking=0" >> "$BCNACONF"/bitcanna.conf
syncr
echo -e "${grey}--> ${bkwhite}Lets Check again ....!!${bkwhite}"
sleep 1.5
syncr2
echo -e "${grey}--> ${green}YES!! REALLY! Bitcanna Wallet Fully Syncronized!!!${bkwhite}"
sleep 1.5
echo -e "${grey}--> ${bkwhite}You want Encrypt Bitcanna MasterNode Wallet with passphrase${grey}? ${grey}(${green}Y${grey}/${red}NO${grey})\n${bkwhite}"
read -r -p "" CRYPSN
if [ "$CRYPSN" == "y" ]; then
 WALLETEXIST=0
 cryptwallet
else
 echo -e "${grey}--> ${red}                ATTENTION ${grey}!!!! \n${grey}--> ${yellow} YOUR WALLET IS ${red}NOT ${yellow}PROTECTED WITH PASSWORD ${grey}!!!!${bkwhite}\n"
sleep 1.5
fi
echo -e "${grey}--> ${bkwhite}Set ID of this Masternode${grey}. Example${grey}: ${green}0 ${grey}(${bkwhite}Zer${green}0 ${grey}- ${bkwhite}To ${green}First ${bkwhite}Node${grey}, 1 ${grey}- ${bkwhite}To 2nd node${grey}, 2 ${grey}- ${bkwhite}To 3rd node${grey}... ${bkwhite}"
read -r -p "" IDMN
echo -e "${grey}--> ${bkwhite}Set Your MasterNode wallet Alias ${grey}(Example${grey}: ${green}MN0${grey}, ${green}MN1${grey}, ${green}MN2${grey})... ${bkwhite}"
read -r -p "" MNALIAS
echo -e "${grey}--> ${bkwhite}Generate your MasterNode Private Key ${grey}...${bkwhite}"
readonly MNGENK=$("$BCNACLI" masternode genkey)
echo -e "${grey}--> ${bkwhite}Creating NEW Address to MASTERNODE ${grey}-> ${green}$MNALIAS ${bkwhite}"
readonly NEWWLTADRS=$("$BCNACLI" getnewaddress "\"$MNALIAS\"")
readonly WLTADRS="$NEWWLTADRS"
echo -e "\n\n${blk}${grey}--> ${bkwhite}\tTIME TO SEND 100K COINS TO YOUR ${green}$MNALIAS ${bkwhite}wallet address\n\tMy Label ${green}$MNALIAS and ${bkwhite}Wallet Address Is: ${green}${sbl}${bld}$WLTADRS${bkwhite}\n\n"
while true
do
 echo -e "${grey}--> ${yellow}IDENTIFY YOUR TRANSACTION ID ${grey}!!! \n${bkwhite}"
 sleep 1
 echo -e "${grey}--> ${red}VERIFY ${grey}!!!!\n ${yellow}If you get +10 Confirmations of transaction ${grey}!!! \n${bkwhite}"
 read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${bkwhite}")"
 "$BCNACLI" listtransactions
 echo -e "${grey}--> ${green}Have you IDENTIFY your transaction id ${grey}(${green}TXID${grey}) ? (${green}Y${grey}/${red}N${grey}) \n${bkwhite}"
 read -r -p "" CHOILIST
 case "$CHOILIST" in
  y|Y) sleep 0.5 && break ;;
  n|N) echo -e "${yellow}Please${grey}, You need wait +10 Confirmations to continue ${grey}...${bkwhite}" ;;
  *) echo -e "\n\n${red}Really ${grey}!?!? ${red}Missed ${grey}!?\n\n" && sleep 0.5 ;;
esac
done
echo -e "${grey}--> ${bkwhite}Auto-finding the Collateral Output ${green}TX ${bkwhite}and ${green}INDEX\n${bkwhite}"
readonly MNID=$("$BCNACLI" masternode outputs | awk -F'"' '{print $6}')
readonly MNTX=$("$BCNACLI" masternode outputs | awk -F'"' '{print $8}')
"$BCNACLI" stop
sleep 5
echo "externalip=$VPSIP" >> "$BCNACONF"/bitcanna.conf
echo "port=$BCNAPORT" >> "$BCNACONF"/bitcanna.conf
echo "$IDMN $MNALIAS $VPSIP:$BCNAPORT $MNGENK $MNID $MNTX" > "$BCNACONF"/masternode.conf
echo -e "${grey}--> ${bkwhite}Running Bitcanna Wallet\n${bkwhite}"
rundaemoncheck
echo -e "${grey}--> ${bkwhite}Activating MasterNode ${grey}...\n${bkwhite}"
"$BCNACLI" masternode start-many || { echo -e "${grey}--> ${red}Bitcanna Masternode Failed\nExiting${grey}...${bkwhite}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
}
syncr(){
echo -e "${grey}--> ${bkwhite}Syncronization${bkwhite}\n\n   ${bkwhite}Which mode do you want to sync ? ${grey}(${green}${bld}B${grey}/${yellow}${bld}S${grey})${bkwhite}"
echo -e "${green}${bld}      B ${grey}- ${green}By Bootstrap ${bkwhite}\n${yellow}${bld}      S ${grey}- ${yellow}By network sync${bkwhite}\n"
read -r choicc
case "$choicc" in
 b|B) echo -e "${grey}--> ${bkwhite}Getting Bootstrap ${grey}...${bkwhite}"
  if [[ -n $(find ~ -name "$GETLASTBOOT.zip") ]]; then
   echo -e "${grey}--> ${green}Found $GETLASTBOOT.zip on local storage${bkwhite}"
  else
   echo -e "${grey}--> ${bkwhite}Downloading $GETLASTBOOT.zip ${grey}...${bkwhite}" 
   wget "$BCNABOOT" -P "$BCNAHOME" > /dev/null 2>&1
  fi
  echo -e "${grey}--> ${bkwhite}Extracting $GETLASTBOOT.zip into $BCNACONF ${grey}..."
  unzip -o "$BCNAHOME"/"$GETLASTBOOT".zip -d "$BCNACONF" > /dev/null 2>&1
  ;;
 s|S) echo -e "${grey}--> ${bkwhite}Network Syncronization ${grey}...${bkwhite}"
  ;;
 *) echo -e "${grey}--> ${yellow}Really ${grey}??? ${yellow}Missed ${grey}!?${bkwhite}\n"
  sleep 1 ;;
esac
echo
rundaemoncheck
syncr2 
}
syncr2(){
echo -e "${grey}--> ${bkwhite}Starting Syncronization ${grey}...${bkwhite}"
diff_t="420" ; while [ "$diff_t" -gt "7" ]
do 
clear
echo -e "${red}      __   __     _____   ______ \n${red}     /__/\/__/\  /_____/\/_____/\ 
${red}     \  \ \\${green}: ${red}\ \_\\${green}:::${red}_${green}:${red}\ \\${green}:::${red}_ \ \ 
${red}      \\${green}::${red}\_\\${green}::${red}\/_/\  _\\${green}:${red}\|\\${green}:${red}\ \ \ \ 
${red}       \_${green}:::   ${red}__\/ /${green}::${red}_/__\\${green}:${red}\ \ \ \   
${red}            \\${green}::${red}\ \  \\${green}:${red}\____/\\${green}:${red}\_\ \ \  
${red}             \__\/   \_____\/\_____\/
${green}     T I M E${bkwhite}"
echo -e "${blk}${grey}!!! ${yellow}PLEASE WAIT TO FULL SYNCRONIZATION ${grey}!!!\n"
BLKCNT=$("$BCNACLI" getblockcount)
BLKHSH=$("$BCNACLI" getblockhash "$BLKCNT")
t=$("$BCNACLI" getblock "$BLKHSH" | grep '"time"' | awk -F ":" '{print $2}' | sed -e 's/,$//g')
cur_t=$(date +%s)
diff_t=$(("$cur_t" - "$t"))
echo -n -e "${grey}--> ${yellow}Remaining${grey}: ${green}"
echo "$diff_t" | awk '{printf "%d days, %d:%d:%d\n",$1/(60*60*24),$1/(60*60)%24,$1%(60*60)/60,$1%60}'
sleep 7
done
}
walletrec(){
while true
do
echo -e "${grey}--> ${green}Choose method to recover your wallet${grey}?${bkwhite}\n"
echo -e "${green}${bld}\tW ${grey}- ${yellow}by wallet.dat file ${grey}(${red}NOT Recommended${grey})${bkwhite}\n${green}${bld}\tK ${grey}- ${yellow}by Private Key ${grey}(${green}Recommended${grey})${bkwhite}\n${green}${bld}\tN ${grey}- ${yellow}NOT Recover. Create a NEW wallet${grey}!!!${bkwhite}\n"
read -r choic
case "$choic" in
    w|W) echo -e "${grey}--> ${bkwhite}Detecting wallet.dat file ${grey}... ${bkwhite}"
	     sleep 0.5
	     while [ ! -f "$BCNAHOME"/wallet.dat ]
         do		 
		  echo -e "\n${grey}--> ${yellow}wallet.dat not found ${grey}...${bkwhite}\n ${green}Please, put wallet.dat on this directory ${grey}: ${yellow}$BCNAHOME/wallet.dat ${bkwhite}\n"
		  read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${bkwhite}")"
         done
         echo -e "\n${grey}--> ${green}wallet.dat FOUND in ${yellow}$PWD ${green}Directory${grey}...${bkwhite}\n"
		 "$BCNACLI" importwallet "$BCNAHOME"/wallet.dat
		 sleep 0.5
         WALLETEXIST=1
         break ;;
    k|K) echo -e "${bld}${green}Put PRIVATE KEY of Recovering wallet${grey}:"
	     read -r WALLETPRIVK
         "$BCNACLI" importprivkey "$WALLETPRIVK" MyBCNAWallet false
         WALLETEXIST=0
	     break ;;
	n|N) echo -e "${grey}--> ${yellow} Creating a NEW Wallet${grey}... ${bkwhite}" 
         WALLETEXIST=0
         sleep 0.5 && break ;;
    *) echo -e "${red}Really ${grey}!?!? ${red}Missed ${grey}!?" && sleep 0.5 ;;
esac
done
}
cryptwallet(){
if [ "$WALLETEXIST" -eq 0 ] ; then
 WALLETPASS="dummy1"
 WALLETPASSS="dummy2"
 while [ "$WALLETPASS" != "$WALLETPASSS" ]
 do
  echo -e "${bld}${green}Set PassPhrase to wallet.dat${grey}:" && read -rsp "" WALLETPASS
  echo -e "${bld}${yellow}Repeat PassPhrase again${grey}: ${bkwhite}" && read -rsp "" WALLETPASSS
 done
 "$BCNACLI" encryptwallet "$WALLETPASS" || { echo -e "${grey}--> ${red}Bitcanna Wallet password failed\nExiting${grey}...${bkwhite}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
 sleep 8
 echo -e "${grey}--> ${green}Bitcanna wallet.dat Encrypted ${grey}!!!${bkwhite}\n\n"
 sleep 1
elif [ "$WALLETEXIST" -eq 1 ] ; then
 WALLETPASS="dummy1"
 WALLETPASSS="dummy2"
 while [ "$WALLETPASS" != "$WALLETPASSS" ]
 do
  echo -e "${bld}${green}Put your ${yellow}wallet.dat ${green}PassPhrase${grey}:${bkwhite}" && read -rsp "" WALLETPASS
  echo -e "${bld}${green}Repeat your ${yellow}wallet.dat ${green}PassPhrase${grey}: ${bkwhite}" && read -rsp "" WALLETPASSS
 done
fi
if [ "$choiz" == "p" ] || [ "$choiz" == "P" ] ; then
 rundaemoncheck
 echo -e "\n\n${grey}--> ${bkwhite}Unlocking to Stake ${grey}!${bkwhite}"
 "$BCNACLI" walletpassphrase "$WALLETPASS" 0 false || { echo -e "${grey}--> ${red}Bitcanna Wallet password failed\nExiting${grey}...${bkwhite}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
 echo -e "${grey}--> ${green}What amount to set Split Stake ${grey}(${yellow}1 ${grey}- ${yellow}999999${grey}) ${grey}?${bkwhite}\n"
 read -r STAKE
 "$BCNACLI" setstakesplitthreshold "$STAKE"
 echo -e "${grey}--> ${bkwhite}Staking with ${green}$STAKE ${grey}!!!${bkwhite}"
 sleep 2
 "$BCNACLI" walletlock
 echo -e "\n${grey}--> ${bkwhite}Set to Staking forever ${grey}...${bkwhite}"
 "$BCNACLI" walletpassphrase "$WALLETPASS" 0 true || { echo -e "${grey}--> ${red}Bitcanna Wallet password failed\nExiting${grey}...${bkwhite}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
elif [ "$choiz" == "m" ] || [ "$choiz" == "M" ] ; then
 rundaemoncheck
 echo -e "\n\n${grey}--> ${bkwhite}Unlocking Masternode ${grey}...${bkwhite}\n"
 "$BCNACLI" walletpassphrase "$WALLETPASS" 0 false || { echo -e "${grey}--> ${red}Bitcanna Wallet password failed\nExiting${grey}...${bkwhite}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
fi
sleep 1
}
rundaemoncheck(){
if [ "$choiz" == "m" ] || [ "$choiz" == "M" ]; then 
 "$BCNAD" --maxconnections=1000 -daemon
elif [ "$choiz" == "p" ] || [ "$choiz" == "P" ]; then 
 "$BCNAD" -daemon
else
 echo -e "${red}ERROR ${grey}!! ${red}Maybe someone has hacked this ${grey}:O${endc}" && exit 1
fi
while true
do 
 "$BCNACLI" getinfo > /dev/null 2>&1 && break || echo -e "${bkwhite}${yellow}Wait ${grey}...${bkwhite}" ;
 sleep 10
done
}
backup(){
echo -e "\n${grey}--> ${bld}${sbl}${green}Backup Wallet Info ${grey}:${bkwhite}\n"
mkdir BCNABACKUP
chmod -R 700 BCNABACKUP
"$BCNACLI" walletpassphrase "$WALLETPASS" 0 false
if [ "$choiz" == "p" ] || [ "$choiz" == "P" ] ;  then
 BCNADUMP=$("$BCNACLI" dumpprivkey "$WLTADRS")
elif [ "$choiz" == "m" ] || [ "$choiz" == "M" ] ;  then 
 BCNADUMP="$MNGENK"
fi
cat <<EOF > "$BCNAHOME"/BCNABACKUP/walletinfo.txt
Bitcanna Node Info

Host:        $HOSTNAME
IP:          $VPSIP
Address:     $WLTADRS
Passphrase : $WALLETPASS
Private Key: $BCNADUMP
RPC User:    $RPCUSR
RPC Pass:    $RPCPWD
EOF
"$BCNACLI" backupwallet "$BCNAHOME"/BCNABACKUP/wallet.dat
if [ "$choiz" == "m" ] || [ "$choiz" == "M" ] ;  then cp -f --preserve "$BCNACONF"/masternode.conf "$BCNAHOME"/BCNABACKUP/masternode.conf; fi
echo -e "\n${grey}--> ${bkwhite}Compacting Files ${grey}...${bkwhite}\n"
tar --overwrite -zcvf "$BCNAHOME"/WalletBackup.tar.gz "$BCNAHOME"/BCNABACKUP
chmod 600 "$BCNAHOME"/WalletBackup.tar.gz
echo -e "\n\n${grey}--> ${bkwhite}Info Wallet Backuped on${grey}:${bld}${sbl}${green} $BCNAHOME/WalletBackup.tar.gz \n${yellow}\t${grey}!!! ${yellow}PLEASE ${grey}!!!\n${red}\tSAVE THIS FILE IN MANY DEVICES IN A SECURE PLACE${bkwhite}\n"
read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}Press any key to continue ${grey}... \n${bkwhite}")"
}
final(){
"$BCNACLI" stop
echo
sleep 5
if [ "$choiz" == "p" ] || [ "$choiz" == "P" ] ; then
 rundaemoncheck
 "$BCNACLI" walletpassphrase "$WALLETPASS" 0 true 
 "$BCNACLI" getstakingstatus
 echo -e "\n${grey}--> ${green}Proof Of Stake Finished and Running ${grey}!! \n\n" 
elif [ "$choiz" == "m" ] || [ "$choiz" == "M" ] ; then
 rundaemoncheck
 "$BCNACLI" walletpassphrase "$WALLETPASS" 0 false
 sleep 0.5
 "$BCNACLI" masternode start-many || { echo -e "${grey}--> ${red}Bitcanna Masternode Failed\nExiting${grey}...${bkwhite}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
 echo -e "\n${grey}--> ${green}MasterNode Finished and Running ${grey}!!! \n\n"
else
 echo -e "\n${red}ERROR ${grey}!! ${red}Maybe someone has hacked this ${grey}:O${bkwhite}" && sleep 1 && echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}" && "$BCNACLI" stop && exit 1
fi
sleep 1
}
console(){
sed -i "s/BCNAMODE=\"NONE\"/BCNAMODE=\"$choiz\"/" BCNA-Installer/BCNA-Console.sh
echo -e "\n\n${grey}--> ${bkwhite}You want get a Bitcanna Terminal on user login ${grey}??? (${green}Y${grey}/${red}N${grey})${bkwhite}\n"
read -r MYTERM
if [ "$MYTERM" == "Y" ] || [ "$MYTERM" == "y" ] ; then
 ln -f BCNA-Installer/BCNA-Console.sh BCNA-Console.sh
 if grep -Fxq "BCNA-Console.sh" "$BCNAHOME"/.bashrc ; then
  echo -e "${grey}--> ${yellow}BCNA-Console.sh Existing on $BCNAHOME/.bashrc ${grey}!!!${bkwhite}\n"
 else
  cat <<EOF >> "$BCNAHOME"/.bashrc
if [ -f ~/BCNA-Console.sh ]; then
 . BCNA-Console.sh
fi
EOF
  echo -e "${grey}--> ${bkwhite}Bitcanna Terminal set for user ${green}$USER ${grey}!!!${bkwhite}\n"
 fi
else
 echo -e "${grey}--> ${yellow}Will not get a Bitcanna Terminal ${grey}!!!\n${green}You can run${yellow} 'bash $BCNAHOME/BCNA-Installer/BCNA-ExtractPeerList.sh' ${green}script on future ${grey}!!!${bkwhite}\n" 
 sleep 1
fi 
}
mess(){
echo -e "${grey}--> ${yellow}Cleaning the things ${grey}...${bkwhite}"
[ -d "$(find "$BCNAHOME" -name "*MACOSX*" )" ] && rm -R -f "$BCNAHOME"/*MACOSX*
[ -d "$(find "$BCNAHOME" -name "unix-*" )" ] && rm -R -f unix-*
[ -d "$(find "$BCNAHOME" -name "unix_*" )" ] && rm -R -f unix_*
[ -d "$(find "$BCNAHOME" -name "$BCNAPKG" )" ] && rm -R -f bcna-"$GETLAST"-unix*
[ -d "$(find "$BCNAHOME" -name "BCNABACKUP" )" ] && rm -R -f BCNABACKUP
[ -d "$(find "$BCNAHOME" -name "$BCNADIR" )" ] && rm -R -f "$BCNADIR"
[[ "$choicc" == "b" || "$choicc" == "B" ]] && rm "$BCNACONF"/bootstrap.dat.old
echo "${grey}--> ${green}Cleaned unecessary storage ${grey}!!!${bkwhite}"
sleep 1.5
}
concl(){
echo -e "${bkwhite}${green}\n\t\t __    ___  __  \n\t\t|__) |  |  /  \`  /\  |\ | |\ |  /\  \n\t\t|__) |  |  \__, /~~\ | \| | \| /~~\ ${bkwhite}\n\n"
echo -e "${green}\tProject Ver${grey}: ${bld}${bkwhite}$SCRPTVER ${bkwhite}\n\tby hellresistor\n\n\tDonation with Bitcanna\n\t${green}BCNA${grey}: ${yellow}${bld}${sbl}$DONATE${bkwhite}\n${endc}"
}
###############
#### Start ####
###############
colors
varys
dependencies
if [[ "$EUID" -eq 0 ]]; then 
 echo -e "${grey}--> ${red}You are root ${grey}!!\n   ${yellow}Just NOT USE ROOT user ${grey}!!!\n      ${red}Exiting${grey}...${endc}" && sleep 0.5 && exit 1
else
 MYSUDOER=$(sudo grep '^$USER' /etc/sudoers)
 if [[ "$MYSUDOER" -eq 0 ]]; then
  echo -e "${grey}--> ${green}You are in sudoers file ${grey}!!!${bkwhite}" && sleep 0.2
 else
  echo -e "${red}ERROR${grey}!!! ${bkwhite}User${grey}:${yellow}$USER ${bkwhite}is not a sudoer user\nExiting${grey}...${bkwhite}" && sleep 0.2 
  echo -e "${yellow}$USER user need sudoer privileges to set bitcannad and bitcanna-cli binaries ${grey}!!!${bkwhite}" && sleep 0.2
  exit 1
 fi
 echo -e "${grey}--> ${bkwhite}Nice user${grey}: ${green}$USER ${grey}!! \n${green}Continuing${grey}...${bkwhite}" && sleep 0.7
 cd "$BCNAHOME" || { echo -e "${grey}--> ${red}$BCNAHOME Cant Found!\nExiting...${endc}"; exit 1; }
 clear
 intro
 checkin
 mess
 concl
 history -cw
 echo -e "${endc}"
fi

if [ "$MYTERM" = "Y" ] || [ "$MYTERM" = "y" ]; then
 bash BCNA-Console.sh
fi
