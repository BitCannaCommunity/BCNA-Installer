#!/bin/bash
varys(){
STAKE="100"    ### Can ChangeIt!! Sure yourself You Know What Are You Doing!! ###
BCNAREP="https://github.com/BitCannaGlobal/BCNA/releases/download"
GETLAST=$(curl --silent "https://api.github.com/repos/BitCannaGlobal/BCNA/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
BCNABOOT="https://github.com/BitCannaCommunity/Bootstrap/releases/download/bootstrap/bootstrap.zip"
BCNAPKG="bcna-$GETLAST-unix"
BCNAHOME="/home/$USER"
BCNACONF=".bitcanna"
BCNADIR="Bitcanna"
BCNAPORT="12888"
BCNACLI="bitcanna-cli"
BCNAD="bitcannad"
VPSIP="$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')"
currentscript="$0"
}

intro(){
cat<< EOF
##################################################################################
##  bbc                              Script Contribution to BitCanna Community  ##
##  bbb                                     to Ubuntu 18.04 LTS Server          ##
##  bbbbb                            #############################################
##  bbbbb                               Executing this script you can Install   ##
##  bbbbb   cbcb          bbbbbb         Configure your Bitcanna Wallet to:     ##
##  bbbbb bbbbbbbbb     bbbbbbbbbb                                              ##
##  bbbcb bbbbbbbbbb   cbbbbbbcbbbb           - Stake (Proof-Of-Stake)          ##
##  bbbbbbbb    bbbbbibbbb      cbbb          - MN    (Master-Node)             ##
##  bbbbib        bbb bibbb                                                     ##
##  bbbbib         bbbbbb             ############################################
##  bbbbbb         bbbbbb                                                       ##
##  bbcbbb         bbbbcb                       Project Ver: V1.11.20           ##
##  bbbbbb         bbbbbcb                                                      ##
##  bbbbbbbb      bbbbbbbbbc     cbbb              by hellresistor              ##
##    bbbbbbbbbbbbbcbb bbbbbbbbbbbbb   Support donate seeds/CBD with Bitcanna   ##
##     bbbbbbbbbbb bbb cbbbbbbbbbib                                             ##
##       bbbbbbbbb       bbbbibbbb    BCNA: B73RRFVtndfPRNSgSQg34yqz4e9eWyKRSv  ##
##                                                                              ##
################################################################################## 
##################################################################################
##                                                                              ##
##  HAVE IN MIND!! EVERY TIME DO YOUR OWN BACKUPS BEFORE USING THIS SCRIPT      ##
##            I have NO responsability about system corruption!                 ##
##                     Use this Script at your own risk!                        ##
##                   (leave feedback, issues, suggestions)                      ##
##################################################################################

Continue this Script are Accepting you are the only responsible
EOF
echo && read -n 1 -s -r -p "Press any key to continue this Script..."
sleep 0.5 && cd $BCNAHOME
}

intro2(){
cat<<EOF

 ▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄   ▄▄        ▄   ▄▄        ▄  ▄▄▄▄▄▄▄▄▄▄▄  
▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌ ▐░░░░░░░░░░░▌ ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌ ▐░░▌      ▐░▌ ▐░░▌      ▐░▌▐░░░░░░░░░░░▌ 
▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀█░█▀▀▀▀   ▀▀▀▀█░█▀▀▀▀  ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌ ▐░▌░▌     ▐░▌ ▐░▌░▌     ▐░▌▐░█▀▀▀▀▀▀▀█░▌ 
▐░▌       ▐░▌     ▐░▌           ▐░▌      ▐░▌          ▐░▌       ▐░▌ ▐░▌▐░▌    ▐░▌ ▐░▌▐░▌    ▐░▌▐░▌       ▐░▌ 
▐░█▄▄▄▄▄▄▄█░▌     ▐░▌           ▐░▌      ▐░▌          ▐░█▄▄▄▄▄▄▄█░▌ ▐░▌ ▐░▌   ▐░▌ ▐░▌ ▐░▌   ▐░▌▐░█▄▄▄▄▄▄▄█░▌ 
▐░░░░░░░░░░▌      ▐░▌           ▐░▌      ▐░▌          ▐░░░░░░░░░░░▌ ▐░▌  ▐░▌  ▐░▌ ▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌ 
▐░█▀▀▀▀▀▀▀█░▌     ▐░▌           ▐░▌      ▐░▌          ▐░█▀▀▀▀▀▀▀█░▌ ▐░▌   ▐░▌ ▐░▌ ▐░▌   ▐░▌ ▐░▌▐░█▀▀▀▀▀▀▀█░▌ 
▐░▌       ▐░▌     ▐░▌           ▐░▌      ▐░▌          ▐░▌       ▐░▌ ▐░▌    ▐░▌▐░▌ ▐░▌    ▐░▌▐░▌▐░▌       ▐░▌ 
▐░█▄▄▄▄▄▄▄█░▌ ▄▄▄▄█░█▄▄▄▄       ▐░▌      ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌ ▐░▌     ▐░▐░▌ ▐░▌     ▐░▐░▌▐░▌       ▐░▌ 
▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌      ▐░▌      ▐░░░░░░░░░░░▌▐░▌       ▐░▌ ▐░▌      ▐░░▌ ▐░▌      ▐░░▌▐░▌       ▐░▌ 
 ▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀▀        ▀        ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀   ▀        ▀▀   ▀        ▀▀  ▀         ▀  

             ##################################################################################
             ##                                                                              ##
             ##                         Project Ver: V1.11.20                                ##
             ##                                                                              ##
             ##                            by hellresistor                                   ##
             ##                       Support donate seeds/CBD with Bitcanna                 ##
             ##  BCNA Address: B73RRFVtndfPRNSgSQg34yqz4e9eWyKRSv                            ##
             ##                                                                              ##
             ##################################################################################
EOF
read -n 1 -s -r -p "Press any key to Finish this Script!"
}

choi(){
while true
do
clear
cat<<EOF
#######################################
## BitCanna Wallet Installation Menu ##
#######################################
## Would you like Install/Configure) ##
##   P --> Full Node (P.O.Stake)     ##
##   M --> MasterNode (MN)?          ##
#######################################
EOF
read -p "(P/M): " choiz;
case $choiz in
    p|P) break ;;
    m|M) break ;;
    *) echo "########################
## Really??? Missed!? ##
########################"
       sleep 3 ;;
esac
done
}

bcnadown(){
clear
echo "###############################################################
## Lets Download and Extract the Bitcanna Wallet from GitHub ##
###############################################################"
cd $BCNAHOME
sleep 2
wget $BCNAREP/$GETLAST/$BCNAPKG.zip
mkdir $BCNADIR
unzip $BCNAPKG.zip
cp bcna-$GETLAST-unix/* $BCNADIR
sudo cp $BCNADIR/* /usr/local/bin
sudo chmod +x /usr/local/bin/bitcanna*
echo "###########################################
## Downloaded and Extracted to: $BCNADIR ##
###########################################"
sleep 3
}

choice(){
clear
if [ "$choiz" == "m" ] || [ "$choiz" == "M" ]
then 
 echo "######################################################
## Have been Selected MasterNode - MN Configuration ##
######################################################"
sleep 2
masternode
else
 echo "#####################################################
## Have been Selected FullNode - POS Configuration ##
#####################################################"
 sleep 2
 stake
fi
}

syncr2(){
echo "#########################
## Getting by Sync ... ##
#########################"
diff_t=420 ; while [ $diff_t -gt 5 ]
do 
 clear
 cat<<OFT
##############################################
##      __   __     _____   ______          ##
##     /__/\/__/\  /_____/\/_____/\         ##
##     \  \ \: \ \_\:::_:\ \:::_ \ \        ##
##      \::\_\::\/_/\  _\:\|\:\ \ \ \       ##
##       \_:::   __\/ /::_/__\:\ \ \ \      ##
##            \::\ \  \:\____/\:\_\ \ \     ##
##             \__\/   \_____\/\_____\/     ##
##   T I M E                                ##
##############################################
## !!!PLEASE WAIT TO FULL SYNCRONIZATION!!! ##
##############################################
OFT
BLKCNT=$($BCNACLI getblockcount)
BLKHSH=$($BCNACLI getblockhash $BLKCNT)
t=$($BCNACLI getblock "$BLKHSH" | grep '"time"' | awk -F ":" '{print $2}' | sed -e 's/,$//g')
cur_t=$(date +%s)
diff_t=$[$cur_t - $t]
echo -n "#############################################
Syncing... Wait more: "
echo $diff_t | awk '{printf "%d days, %d:%d:%d\n",$1/(60*60*24),$1/(60*60)%24,$1%(60*60)/60,$1%60}'
sleep 5
done
}

syncr(){
clear
cat<<EOF
#####################################
## Which mode do you want to sync? ##
##   B --> By Bootstrap            ##
##   S --> By Normal Sync          ##
#####################################
EOF
read -p "(B/S): " choicc;
case $choicc in
    b|B) echo "##############################
## Getting by Bootstrap ... ##
##############################"
   wget $BCNABOOT 
   unzip bootstrap.zip -d $BCNACONF
$BCNACLI stop
sleep 1
$BCNAD -daemon
sleep 10
syncr2
break ;;
    s|S) $BCNACLI stop
sleep 1
$BCNAD -daemon
sleep 10
syncr2 
break ;;
    *) echo "########################
## Really??? Missed!? ##
########################"
       sleep 3 ;;
esac
}

firstrun(){
clear
echo "##############################################
## Lets Generate a RPC User and Password... ##
##############################################"
mkdir $BCNACONF >/dev/null 2>&1
RPCUSR=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
RPCPWD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
echo "rpcuser=$RPCUSR" >> $BCNACONF/bitcanna.conf
echo "rpcpassword=$RPCPWD" >> $BCNACONF/bitcanna.conf
echo "#################################
## Initial Configurations Done ##
#################################"
}

cryptwallet(){
WALLETPASS=0
WALLETPASSS=1
while [ $WALLETPASS != $WALLETPASSS ]
do
echo && read -s -p "Set PassPhrase to wallet.dat: " WALLETPASS
echo && read -s -p "Repeat PassPhrase again: " WALLETPASSS
done
echo "################################
##Please Wait a little bit... ##
################################"
read -n 1 -s -r -p "Press any key to Finish this Script!"
echo "######################################################
## Restarting BitCanna Wallet with Wallet Encrypted ##
######################################################"
$BCNAD -daemon
sleep 15
WLTUNLOCK=$"$BCNACLI walletpassphrase $WALLETPASS 0 false"
$WLTUNLOCK

if [ "$choiz" == "p" ] || [ "$choiz" == "P" ]
 then
 clear
 echo "############################"
 echo "## Set to Staking forever ##"
 echo "############################"
 
 sleep 0.5
  WLTUNLOCK=$"$BCNACLI walletpassphrase $WALLETPASS 0 true"
  $WLTUNLOCK
  sleep 2
  echo "########################
## Unlocked to Stake! ##
########################"
  sleep 2 
  WLTSTAKE=$"$BCNACLI setstakesplitthreshold $STAKE"
  $WLTSTAKE
  sleep 2
  
  echo "###########################

## Staking with $STAKE ! ##
###########################"
  sleep 2
 fi
}

walletposconf(){
echo "staking=1" >> $BCNACONF/bitcanna.conf
clear
syncr
echo "#############################"
echo "## Lets Check again ....!! ##"
echo "#############################"
sleep 15
syncr2
echo "#########################################################
## YES!! REALLY! Bitcanna Wallet Fully Syncronized!!!  ##
#########################################################"
sleep 2
clear
echo "###########################
## My Wallet Address Is: ##"
WLTADRS=$($BCNACLI getaccountaddress wallet.dat)
echo $WLTADRS
cryptwallet

echo "################################################################################
## CONGRATULATIONS!! BitCanna POS - Proof-Of-Stake Configurations COMPLETED!  ##
################################################################################"
sleep 3

cat<<EOF
####################################################
## TIME TO SEND SOME COINS TO YOUR wallet address ##
##    (check Official Bitcanna.io Claim Guide)    ##
####################################################
## My Wallet Address Is:                          ##
$WLTADRS
####################################################
EOF
read -n 1 -s -r -p "Press any key to Continue..."
}

walletmnconf(){
echo "staking=0" >> $BCNACONF/bitcanna.conf
echo "#########################################################################################"
read -p "## Set ID of this Masternode. Default: 0 (Zer0 - To First Node, 1 - To 2nd node, .....): " IDMN
echo "#########################################################################################"
read -p "## Set Your MasterNode wallet Alias (usually: MN0): " MNALIAS
echo "#########################################################################################"
clear
syncr
echo "#############################
## Lets Check again ....!! ##
#############################"
sleep 5
syncr2
echo "#########################################################
## YES!! REALLY! Bitcanna Wallet Fully Syncronized!!!  ##
#########################################################"
sleep 2
echo "##########################################
## Generate your MasterNode Private Key ##
##########################################"

MNGENK=$($BCNACLI masternode genkey)
echo $MNGENK
echo "####################################################
## Creating NEW Address to MASTERNODE -> \$MNALIAS 
####################################################"

NEWWLTADRS=$($BCNACLI getnewaddress $MNALIAS)
echo $NEWWLTADRS
WLTADRS=$($BCNACLI getaccountaddress wallet.dat)

cat<<EOF
######################################################################
## TIME TO SEND YOUR 100K COINS TO YOUR "$MNALIAS" wallet address ##
##            (check Official Bitcanna.io Claim Guide)              ##
######################################################################
## My $MNALIAS Wallet Address Is:                                   ##
$WLTADRS
######################################################################
EOF

read -n 1 -s -r -p "`echo -e '##########################################################\n## Please wait at least 16+ confirmations of trasaction ##\n##########################################################\n '`"
read -n 1 -s -r -p "`echo -e '########################################################\n## After 16+ confirmations, Press any key to continue ##\n########################################################\n '`" 
read -n 1 -s -r -p "`echo -e '###############################################\n## Sure? 16 Conf.? Press any key to continue ##\n############################################### \n'`"
read -n 1 -s -r -p "`echo -e '###############################################\n## OK! OK! Anoying Right? Only SURE as OK!!! ##\n############################################### \n'`"
clear

echo "#############################################
## IDENTIFY YOUR TRANSACTION ID - TxID !!! ##
#############################################"

$BCNACLI listtransactions
read -p "`echo -e '\n##############################\n## Copy IDENTIFIED TxId !!! ##\n##############################\n: '`" TXID
sleep 0.5
clear
echo "##################################################
## Lets Find the collateral Output TX and INDEX ##
##################################################"

$BCNACLI masternode outputs

echo "######################################
## Copy/Paste the Requested Info!!! ##
######################################"

read -p "`echo -e '\n###################################\n## Set the Long part (Tx) string ##\n###################################\n: '`" MNTX
read -p "`echo -e '\n####################################\n## Set the Short part (Id) string ##\n####################################\n: '`" MNID

$BCNACLI stop

sleep 10

echo "externalip=$VPSIP" >> $BCNACONF/bitcanna.conf
echo "port=$BCNAPORT" >> $BCNACONF/bitcanna.conf
echo "$IDMN $MNALIAS $VPSIP:$BCNAPORT $MNGENK $MNTX $MNID" > $BCNACONF/masternode.conf
cat $BCNACONF/masternode.conf
read -n 1 -s -r -p "`echo -e '\n#############################################################\n## Are you Verified The Results? Press any key to continue ##\n#############################################################\n '`" 

echo "#########################
## Run Bitcanna Wallet ##
#########################"

$BCNAD --maxconnections=1000 -daemon
sleep 10

echo "###############################
## Activating MasterNode ... ##
###############################"

$BCNACLI masternode start-many
sleep 2 

cat<<EOF
########################################################
## No Reference on Guides about Encrypt on MasterNode ##
##              Maybe cause problems?                 ##
##      PROTECT YOUR Server (see ReadMe file)         ##
########################################################
EOF

read -p "You want Encrypt MasterNode Wallet? (y/n)" CRYPSN
if [ "$CRYPSN" == "y" ]
then
cryptwallet
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
$BCNACLI stop
sleep 5
if [ "$choiz" == "p" ] || [ "$choiz" == "P" ]
then
$BCNAD -daemon
sleep 10
$BCNACLI walletpassphrase $WALLETPASS 0 true 
sleep 3 
$BCNACLI getstakingstatus
echo "#############################################################
## Proof Of Stake Finished and Running!! Now Can LogOut! ####
#############################################################"
else
$BCNAD --maxconnections=1000 -daemon
sleep 10
$BCNACLI walletpassphrase $WALLETPASS 0 false
sleep 10
$BCNACLI masternode start-many
sleep 2
echo "#########################################################
## MasterNode Finished and Running!! Now Can LogOut... ##
#########################################################"
fi
sleep 5
}

backup(){
clear
echo "###########################
## Backuping Wallet Info ## 
###########################"
mkdir $BCNAHOME/BACKUP
chmod 700 $BCNAHOME/BACKUP
cat<<EOF 
#########################################################
## To Do This you need set Unlock wallet and NOT stake ##
##                                                     ##
##            Write your wallet password               ##
#########################################################
EOF
WLTUNLOCK=$"$BCNACLI walletpassphrase $WALLETPASS 0 false"
$WLTUNLOCK
BCNADUMP=$($BCNACLI dumpprivkey "$WLTADRS")
cat <<EOF > $BCNAHOME/BACKUP/walletinfo.txt
Server Info:
Host: $HOSTNAME
IP: $VPSIP
Wallet Info:
Address: $WLTADRS
Password: $WALLETPASS
Dump: $BCNADUMP
$RPCUSR
$RPCPWD
EOF

BCKWLT=$(bitcanna-cli backupwallet $BCNAHOME/BACKUP/wallet.dat)
$BCKWLT
if [ "$choiz" == "m" ] || [ "$choiz" == "M" ]
 then
  cp $BCNACONF/masternode.conf $BCNAHOME/BACKUP/masternode.conf
fi
echo "#########################
## Compacting Files .. ##
#########################"
## Compressed and Permissions set ##
tar -zcvf $BCNAHOME/WalletBackup.tar.gz $BCNAHOME/BACKUP
chmod 500 $BCNAHOME/WalletBackup.tar.gz
echo "#################################################################
## Info Wallet Backuped in: $BCNAHOME/WalletBackup.tar.gz 
##                        !!!PLEASE!!                          ##
##        SAVE THIS FILE ON MANY DEVICES ON SECURE             ##
#################################################################"
echo && read -n 1 -s -r -p "Press any key to continue"
}

mess(){
clear
echo "#########################
## Cleaning the things ##
#########################"
rm bcna-$GETLAST-unix.zip
rm -R -f $BCNAHOME/BACKUP
rm -r __MACOSX
rm -r bcna-$GETLAST-unix 
ln -s $BCNADIR bcna-$GETLAST-unix #### Compatibility to TelegramBot BitcannaCommunity script
rm bootstrap.zip
history -cw
echo "######################################
## Cleaned garbage packages temp... ##
######################################"
function finish {
shred -u ${currentscript};
}
trap finish EXIT
}

intro
varys
choi
bcnadown
choice
final
intro2
mess
