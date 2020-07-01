#!/bin/bash
#---------------------------
# Should Change It !
STAKE="100"
#---------------------------
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
readonly SCRPTVER="V1.20"
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
concl(){
clear
echo -e "${bkwhite}${green}\n\t\t __    ___  __  \n\t\t|__) |  |  /  \`  /\  |\ | |\ |  /\  \n\t\t|__) |  |  \__, /~~\ | \| | \| /~~\ ${bkwhite}\n\n"
echo -e "${green}\tProject Ver${grey}: ${bld}${bkwhite}$SCRPTVER ${bkwhite}\n\tby hellresistor\n\n\tDonation with Bitcanna\n\t${green}BCNA${grey}: ${yellow}${bld}${sbl}$DONATE${bkwhite}\n${endc}"
}
choi(){
while true
do
echo -e "${bkwhite}\n\n${grey}--> ${bkwhite}Wich you need Install/Configure ${grey}? (${green}${bld}P${grey}/${yellow}${bld}M${grey})${bkwhite}"
echo -e "${green}${bld}      P ${grey}- ${green}Full Node ${grey}(${green}POStake${grey}) ${bkwhite}\n${yellow}${bld}      M ${grey}- ${yellow}MasterNode ${grey}(${yellow}MN${grey})${bkwhite}\n"
read -r choiz
readonly choiz
case "$choiz" in
    p|P) break ;;
    m|M) break ;;
    *) echo -e "${red}Really ${grey}!?!? ${red}Missed ${grey}!?"
       sleep 0.5 ;;
esac
done
}
bcnadown(){
echo -e "${grey}--> ${bkwhite}Lets Download and Extract the Bitcanna Wallet from GitHub\n${bkwhite}"
sleep 0.5
[ -d "$BCNACONF" ] && cp -f -r --preserve "$BCNACONF" "$BCNACONF.${DATENOW}"
[ ! -e "$BCNAPKG.zip" ] && echo -e "${grey}--> ${bkwhite}Downloading $BCNAPKG.zip ${grey}...." && wget "$BCNAREP/$GETLAST/$BCNAPKG.zip" > /dev/null 2>&1
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
echo -e "${grey}--> ${bkwhite}Copy binaries to right place ${grey}!!\n${bkwhite}Enter ${grey}'${yellow}sudo password${grey}':\n"
sudo cp -f "$BCNADIR"/* /usr/bin
sudo chmod +x /usr/bin/bitcanna* 
echo -e "${grey}--> ${bkwhite}Downloaded and Extracted to${grey}: ${green}$BCNADIR${bkwhite}"
echo -e "${grey}--> ${bkwhite}Putting Bitcanna Community Scripts on right place ${grey}...\n${bkwhite}"
mv "$BCNAHOME"/BCNA-Installer/BCNA-Console.sh "$BCNAHOME"/BCNA-Console.sh
mv "$BCNAHOME"/BCNA-Installer/BCNA-ExtractPeerList.sh "$BCNAHOME"/BCNA-ExtractPeerList.sh
chown "$USER" "$BCNAHOME"/BCNA-ExtractPeerList.sh
chmod +r "$BCNAHOME"/BCNA-ExtractPeerList.sh
sleep 0.5
}
choice(){
if [ "$choiz" == "m" ] || [ "$choiz" == "M" ]; then 
 echo -e "${grey}--> ${bkwhite}Selected Master Node Configuration${bkwhite}"
 sleep 1
 masternode
elif [ "$choiz" == "p" ] || [ "$choiz" == "P" ]; then 
 echo -e "${grey}--> ${bkwhite}Selected Full Node${bkwhite}"
 sleep 1
 stake
else
 echo -e "${red}ERROR ${grey}!! ${red}Maybe someone has hacked this ${grey}:O${endc}" && exit 1
fi
}
rundaemoncheck(){
if [ "$choiz" == "m" ] || [ "$choiz" == "M" ]; then 
 "$BCNAD" --maxconnections=1000 -daemon || { echo -e "${grey}--> ${red}Bitcanna Masternode Failed\nExiting${grey}...${bkwhite}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Force power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
elif [ "$choiz" == "p" ] || [ "$choiz" == "P" ]; then 
 "$BCNAD" -daemon || { echo -e "${grey}--> ${red}Bitcanna Wallet  Failed\nExiting${grey}...${bkwhite}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Force power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
else
 echo -e "${red}ERROR ${grey}!! ${red}Maybe someone has hacked this ${grey}:O${endc}" && exit 1
fi
while true
do 
 "$BCNACLI" getinfo > /dev/null 2>&1 && break || echo -e "${bkwhite}${yellow}Wait ${grey}...${bkwhite}";
 sleep 10
done
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
sleep 5
done
}
syncr(){
echo -e "${grey}--> ${bkwhite}Syncronization${bkwhite}\n\n   ${bkwhite}Which mode do you want to sync ? ${grey}(${green}${bld}B${grey}/${yellow}${bld}S${grey})${bkwhite}"
echo -e "${green}${bld}      B ${grey}- ${green}By Bootstrap ${bkwhite}\n${yellow}${bld}      S ${grey}- ${yellow}By network sync${bkwhite}\n"
read -r choicc
readonly choicc
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
echo -e "${grey}--> ${bkwhite}Start Bitcanna Daemon ${grey}...${bkwhite}"
rundaemoncheck
syncr2 
}
firstrun(){
echo -e "${grey}--> ${bkwhite}Lets Generate Random RPC User and Password ${grey}... ${bkwhite}"
mkdir "$BCNACONF" > /dev/null 2>&1
touch "$BCNACONF"/bitcanna.conf
readonly RPCUSR=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
readonly RPCPWD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
echo "rpcuser=$RPCUSR" >> "$BCNACONF"/bitcanna.conf
echo "rpcpassword=$RPCPWD" >> "$BCNACONF"/bitcanna.conf
chmod 600 "$BCNACONF"/bitcanna.conf
echo -e "${grey}--> ${green}Random RPC User and Password generated ${grey}!!! ${bkwhite}"
sleep 1
echo -e "${grey}--> ${bkwhite}Detecting wallet.dat file ${grey}... ${bkwhite}" && sleep 0.5
if [ -e "$BCNAHOME/wallet.dat" ]; then
 echo -e "${grey}--> ${green}wallet.dat FOUND in ${yellow}$PWD ${green}Directory${grey}... ${green}Putting it in right place ${yellow}$BCNACONF ${grey}!!!${bkwhite}\n"
 cp --preserve "$BCNAHOME"/wallet.dat "$BCNACONF"/wallet.dat
 chown "$USER" "$BCNACONF"/wallet.dat
 chmod 600 "$BCNACONF"/wallet.dat
 WALLETEXIST=1
 sleep 0.5
else
 echo -e "${grey}--> ${yellow}wallet.dat not found ${grey}... ${green}Creating a new one ${grey}...${bkwhite}\n"
 WALLETEXIST=0
 sleep 0.5
fi
readonly WALLETEXIST
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
 readonly WALLETPASS
 "$BCNACLI" encryptwallet "$WALLETPASS" || { echo -e "${grey}--> ${red}Bitcanna Wallet password failed\nExiting${grey}...${bkwhite}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
 sleep 8
 echo -e "${grey}--> ${green}Bitcanna wallet.dat Encrypted ${grey}!!!${bkwhite}\n\n"
 sleep 1
elif [ "$WALLETEXIST" -eq 1 ] ; then
 WALLETPASS="dummy1"
 WALLETPASSS="dummy2"
 while [ "$WALLETPASS" != "$WALLETPASSS" ]
 do
  echo -e "${bld}${green}Put your wallet.dat PassPhrase${grey}:" && read -rsp "" WALLETPASS
  echo -e "${bld}${yellow}Repeat your wallet.dat PassPhrase${grey}: ${bkwhite}" && read -rsp "" WALLETPASSS
 done
 readonly WALLETPASS
fi
if [ "$choiz" == "p" ] || [ "$choiz" == "P" ] ; then
 rundaemoncheck
 echo -e "\n\n${grey}--> ${bkwhite}Unlocking to Stake ${grey}!${bkwhite}"
 "$BCNACLI" walletpassphrase "$WALLETPASS" 0 false || { echo -e "${grey}--> ${red}Bitcanna Wallet password failed\nExiting${grey}...${bkwhite}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
 sleep 3 
 "$BCNACLI" setstakesplitthreshold "$STAKE"
 echo -e "${grey}--> ${bkwhite}Staking with ${green}$STAKE${bkwhite}"
 sleep 2
 "$BCNACLI" walletlock
 sleep 2
 echo -e "\n${grey}--> ${bkwhite}Set to Staking forever ${grey}...${bkwhite}"
 sleep 0.5
 "$BCNACLI" walletpassphrase "$WALLETPASS" 0 true || { echo -e "${grey}--> ${red}Bitcanna Wallet password failed\nExiting${grey}...${bkwhite}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
 sleep 5
elif [ "$choiz" == "m" ] || [ "$choiz" == "M" ] ; then
 rundaemoncheck
 "$BCNACLI" masternode start-many || { echo -e "${grey}--> ${red}Bitcanna Masternode Failed\nExiting${grey}...${bkwhite}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
fi
sleep 2
}
walletposconf(){
syncr
echo -e "${grey}--> ${bkwhite}Lets Check again ${grey}...${bkwhite}"
sleep 1.5
syncr2
echo -e "${grey}--> ${green}YES${grey}!! ${green}REALLY${grey}!! ${green}Bitcanna Wallet Fully Syncronized ${grey}!!!${bkwhite}\n"
sleep 1.5
readonly WLTADRS=$("$BCNACLI" getaccountaddress wallet.dat)
cryptwallet
echo -e "\n${grey}--> ${green}CONGRATULATIONS ${grey}!! ${green}BitCanna POS ${grey}- ${green}Proof-Of-Stake Configurations COMPLETED ${grey}!!!${bkwhite}\n"
sleep 1.5
echo -e "${blk}${grey}--> ${bkwhite}TIME TO SEND SOME COINS TO YOUR wallet address\n      My Wallet Address Is: ${green}${sbl}${bld}$WLTADRS${bkwhite}\n\n"
sleep 1.5
}
walletmnconf(){
echo "staking=0" >> "$BCNACONF"/bitcanna.conf
echo -e "${grey}--> ${bkwhite}Set ID of this Masternode${grey}. Default${grey}: ${green}0 ${grey}(${bkwhite}Zer${green}0 ${grey}- ${bkwhite}To ${green}First ${bkwhite}Node${grey}, 1 ${grey}- ${bkwhite}To 2nd node${grey}, ...${bkwhite}"
read -r -p "" IDMN
readonly IDMN
echo -e "${grey}--> ${bkwhite}Set Your MasterNode wallet Alias ${grey}(default${grey}: ${green}MN0${grey}): ${bkwhite}"
read -r -p "" MNALIAS
readonly MNALIAS
syncr
echo -e "${grey}--> ${bkwhite}Lets Check again ....!!${bkwhite}"
sleep 1.5
syncr2
echo -e "${grey}--> ${green}YES!! REALLY! Bitcanna Wallet Fully Syncronized!!!${bkwhite}"
sleep 1.5
echo -e "${grey}--> ${bkwhite}Generate your MasterNode Private Key ${grey}...${bkwhite}"
readonly MNGENK=$("$BCNACLI" masternode genkey)
echo -e "${grey}--> ${bkwhite}Creating NEW Address to MASTERNODE ${grey}-> ${green}$MNALIAS ${bkwhite}"
readonly NEWWLTADRS=$("$BCNACLI" getnewaddress "$MNALIAS")
echo "$NEWWLTADRS"
readonly WLTADRS=$("$BCNACLI" getaccountaddress wallet.dat)
echo -e "${blk}${grey}--> ${bkwhite}     TIME TO SEND 100K COINS TO YOUR ${green}""$MNALIAS"" ${bkwhite}wallet address\n    My ${green}""$MNALIAS"" ${bkwhite}Wallet Address Is: ${green}${sbl}${bld}""$WLTADRS""${bkwhite}\n\n"
echo -e "${grey}--> ${bkwhite}IDENTIFY YOUR TRANSACTION ID ${grey}! \n${bkwhite}"
"$BCNACLI" listtransactions
read -n 1 -s -r -p "$(echo -e "${grey}--> ${bkwhite}Got it IDENTIFIED TxId ${grey}??!! \n${green}Press any key to continue ${grey}... \n\n${bkwhite}")"
read -n 1 -s -r -p "$(echo -e "${grey}--> ${bkwhite}Please wait at least 16+ confirmations of trasaction \n${green}Press any key to continue ${grey}... \n\n${bkwhite}")"
read -n 1 -s -r -p "$(echo -e "${grey}--> ${green}After 16+ confirmations${grey}, \n${green}Press any key to continue ${grey}... \n\n${bkwhite}")" 
read -n 1 -s -r -p "$(echo -e "${grey}--> ${yellow}Sure? ${yellow}16+ Confirmations${grey}? \n${yellow}Press any key to continue ${grey}...\n\n${bkwhite}")"
read -n 1 -s -r -p "$(echo -e "${grey}--> ${bkwhite}OK{bgrey}! ${bkwhite}OK{bgrey}! ${bkwhite}Anoying Right${grey}? ${bkwhite}Only SURE as OK${grey}!!!\n${green}Press any key to continue ${grey}... \n\n${bkwhite}")"
sleep 0.5
echo -e "${grey}--> ${bkwhite}Finding the Collateral Output ${green}TX ${bkwhite}and ${green}INDEX\n${bkwhite}"
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
sleep 5
echo -e "${bkwhite}${green}########################################################\n## ${grey}No Reference on Guides about Encrypt on MasterNode ${green}##\n######################################################## ${bkwhite}\n\n"
echo -e "${grey}--> ${bkwhite}You want Encrypt MasterNode Wallet${grey}? ${grey}(${green}Y${grey}/${red}NO${grey})\n${bkwhite}"
read -r -p "" CRYPSN
readonly CRYPSN
if [ "$CRYPSN" == "y" ]; then
 cryptwallet
else
 echo -e "${grey}--> ${red}                ATTENTION ${grey}!!!! \n${grey}--> ${yellow} YOUR WALLET IS ${red}NOT ${yellow}PROTECTED WITH PASSWORD ${grey}!!!!${bkwhite}"
sleep 1.5
fi
}
masternode(){
firstrun
walletmnconf
backup
}
stake(){
firstrun
walletposconf
backup
}
final(){
clear
"$BCNACLI" stop
echo
sleep 5
if [ "$choiz" == "p" ] || [ "$choiz" == "P" ] ; then
 rundaemoncheck
 echo
 "$BCNACLI" walletpassphrase "$WALLETPASS" 0 true 
 sleep 3
 echo 
 "$BCNACLI" getstakingstatus
 echo -e "\n${grey}--> ${green}Proof Of Stake Finished and Running ${grey}!! \n\n" 
elif [ "$choiz" == "m" ] || [ "$choiz" == "M" ] ; then
 rundaemoncheck
# "$BCNACLI" walletpassphrase "$WALLETPASS" 0 false
 sleep 0.5
 "$BCNACLI" masternode start-many || { echo -e "${grey}--> ${red}Bitcanna Masternode Failed\nExiting${grey}...${bkwhite}"; sleep 1; echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}"; "$BCNACLI" stop ; exit 1; }
 sleep 2
 echo -e "\n${grey}--> ${green}MasterNode Finished and Running ${grey}!!! \n\n"
else
 echo -e "\n${red}ERROR ${grey}!! ${red}Maybe someone has hacked this ${grey}:O${bkwhite}" && sleep 1 && echo -e "${red}ERROR ${grey}!! ${red}Power off Bitcanna Daemon ${grey}...${endc}" && "$BCNACLI" stop && exit 1
fi
}
backup(){
echo -e "\n${grey}--> ${bkwhite}Backup Wallet Info ${grey}:${bkwhite}\n"
mkdir "$BCNAHOME"/BCNABACKUP
chmod 700 "$BCNAHOME"/BCNABACKUP
"$BCNACLI" walletpassphrase "$WALLETPASS" 0 false
readonly BCNADUMP=$("$BCNACLI" dumpprivkey "$WLTADRS")
cat <<EOF > "$BCNAHOME"/BCNABACKUP/walletinfo.txt
Bitcanna Node Info

Host: $HOSTNAME
IP: $VPSIP
Address: $WLTADRS
Password: $WALLETPASS
Dump: $BCNADUMP
$RPCUSR
$RPCPWD
EOF
"$BCNACLI" backupwallet "$BCNAHOME"/BCNABACKUP/wallet.dat
if [ "$choiz" == "m" ] || [ "$choiz" == "M" ] ;  then cp -f "$BCNACONF"/masternode.conf "$BCNAHOME"/BCNABACKUP/masternode.conf; fi
echo -e "\n${grey}--> ${bkwhite}Compacting Files ${grey}...${bkwhite}\n"
tar -zcvf "$BCNAHOME"/WalletBackup.tar.gz "$BCNAHOME"/BCNABACKUP
chmod 500 "$BCNAHOME"/WalletBackup.tar.gz
echo -e "\n\n${grey}--> ${bkwhite}Info Wallet Backuped on${grey}:${green} $BCNAHOME/WalletBackup.tar.gz \n${yellow}                       ${grey}!!! ${yellow}PLEASE ${grey}!!!\n${red}       SAVE THIS FILE ON MANY DEVICES ON SECURE PLACE${bkwhite}\n"
sleep 2
}
checkin(){
sleep 0.5
echo -e "${grey}(${green}I${grey})${green}nstall ${grey}, (${yellow}U${grey})${yellow}pdate ${grey}, (${red}R${grey})${red}emove ${grey}:${bkwhite}\n"
read -r choix
if [ "$choix" == "i" ] || [ "$choix" == "I" ]; then 
 echo -e "${grey}--> ${bkwhite}New and Clean installation of Bitcanna wallet${bkwhite}"
 sleep 0.5
if [[ ! -a $(find "/usr/bin" -name "$BCNAD") ]] ; then
  choi
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
   echo -e "${grey}--> ${green}Bitcanna Wallet Updated to NEW version: $GETLAST ${bkwhite}\n To start wallet run: bitcannad -daemon" && sleep 0.5
  else
   echo -e "${grey}--> ${red}Can not find Bitcanna Wallet ${grey}!!!\n${green}Install It First ${grey}!!!\n${bkwhite}" && sleep 0.5
   checkin
  fi
elif [ "$choix" == "r" ] || [ "$choix" == "R" ]; then 
 if [[ -a $(find "/usr/bin" -name "$BCNAD") ]] ; then
   echo -e "${grey}--> ${yellow}Old Bitcanna version found!\n${grey}--> ${red}FULL REMOVING Bitcanna${bkwhite}" && sleep 0.5
   "$BCNACLI" stop > /dev/null 2>&1 || echo -e "${grey}--> ${yellow}Bitcanna Wallet is not Running${grey}...${bkwhite}"
   sleep 5
   cp -f -r --preserve "$BCNACONF" "$BCNACONF"."$DATENOW"
   mess
   rm -R "$BCNACONF"
   sudo rm -f /usr/bin/bitcanna*
   echo -e "${grey}--> ${red}Bitcanna Wallet ${green}FULLY ${red}Removed ${grey}!!!${bkwhite}"
  else
   echo -e "${grey}--> ${red}Bitcanna Wallet not exist!\n${green}Install it${grey}...\n${bkwhite}" && sleep 0.5 && checkin
  fi
 else
  echo -e "${grey}--> ${red}Choose a correct option${grey}!\n${red}Exiting${grey}...${endc}" && exit 1
fi
}
mess(){
echo -e "${grey}--> ${bkwhite}Cleaning the things ${grey}...${bkwhite}"
[ -d "$(find "$BCNAHOME" -name "*MACOSX" )" ] && rm -R -f ./*MACOSX*
[ -d "$(find "$BCNAHOME" -name "unix-" )" ] && rm -R -f unix-*
[ -d "$(find "$BCNAHOME" -name "unix_" )" ] && rm -R -f unix_*
[ -d "$(find "$BCNAHOME" -name "$BCNAPKG" )" ] && rm -R -f bcna-"$GETLAST"-unix*
[ -d "$(find "$BCNAHOME" -name "BCNABACKUP" )" ] && rm -R -f "$BCNAHOME"/BCNABACKUP
[[ "$choiz" == "b" || "$choiz" == "B" ]] && rm "$BCNACONF"/bootstrap.dat.old
echo "${grey}--> ${bkwhite}Cleaned unecessary storage ${grey}!!!${bkwhite}"
sleep 1.5
}
console(){
echo -e "\n\n${grey}--> ${bkwhite}You want get a Bitcanna Terminal on user login ${grey}??? (${green}Y${grey}/${red}N${grey})${bkwhite}\n"
read -r MYTERM
if [ "$MYTERM" = "Y" ] || [ "$MYTERM" = "y" ] ; then
 sed -i "s/BCNAMODE=\"NONE\"/BCNAMODE=\"$choiz\"/" "$BCNAHOME"/BCNA-Console.sh
 chown "$USER" "$BCNAHOME"/BCNA-Console.sh
 chmod +r "$BCNAHOME"/BCNA-Console.sh
 cat <<EOF >> ~/.bashrc
if [ -f ~/BCNA-Console.sh ]; then
 . BCNA-Console.sh
fi
EOF
 echo -e "${grey}--> ${bkwhite}Bitcanna Terminal set for user ${green}$USER ${grey}!!!${bkwhite}"
else
 echo -e "${grey}--> ${yellow}Will not get a Bitcanna Terminal ${grey}!!!\n${bkwhite}You can run${yellow} 'bash BCNA-ExtractPeerList.sh' ${bkwhite}script on future ${grey}!!!{bkwhite}" 
 sleep 1.5
fi 
}
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
  echo -e "${grey}--> ${green}You are in sudoers file ${grey}!!!${endc}" && sleep 0.2
 else
  echo -e "${red}ERROR${grey}!!! ${bkwhite}User:${yellow}$USER ${bkwhite}is not a sudoer user\nExiting...${endc}" && sleep 0.2 
  echo -e "${yellow}$USER user need sudoer privileges to set bitcannad and bitcanna-cli binaries !!!" && sleep 0.2
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
 bash "$BCNAHOME"/BCNA-Console.sh
fi
