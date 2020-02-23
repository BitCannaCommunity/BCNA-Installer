#!/bin/bash
### In dev..... ###
########################################
## RUN THIS ONLY AFTER A RUNNING NODE ##
########################################
BCNACONF="~/.bitcanna"
BCNADIR="~/Bitcanna"
BCNACLI=bitcanna-cli
BCNAD=bitcannad
currentscript="$0"

while true
do
cat<<EOF
##################################
##    BitCanna Terminal Prep    ##
##################################
## What Node type are RUNNING ? ##
##  P --> Full Node (P.O.Stake) ##
##  M --> MasterNode (MN)?      ##
##################################
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

cat<<EOF>BCNA-TERMINAL.sh
#!/bin/bash
#Peers: $BCNACLI getpeerinfo | Connections: $BCNACLI getconnectioncount | Block: $BCNACLI getblockcount | Ping: $BCNACLI ping
while :
do
clear
cat<<ETF
############################################################
##                                                        ##
##                     Bitcanna Console                   ##
##                                       by: hellresistor ##
############################################################
##____________________ Wallet Manager ____________________##
EOF
if [ "$choiz" == "p" ] || [ "$choiz" == "P" ];
then
echo "## U- Unlock to STAKE      ##  W- Get Wallet Address      ##" >> $BCNASCRIPTS/BCNA-TERMINAL.sh
else
echo "## U- Unlock to MasterNode ##  W- Get Wallet Address      ##" >> $BCNASCRIPTS/BCNA-TERMINAL.sh
fi
cat<<EOF>>BCNA-TERMINAL.sh
##                         ##  I- Get List Address        ##
## L- Lock Wallet          ##  B- Get Balance             ##
##                         ##                             ##
EOF
if [ "$choiz" == "p" ] || [ "$choiz" == "P" ];
then
cat<<EOF>>BCNA-TERMINAL.sh
## O- Get Blockchain Info  ##  D- Set Stake Threshold     ##
## N- Get Network Info	   ##  K- Get StakeSplito Info    ##
##                         ##                             ##
##                         ##                             ##
EOF
else
cat<<EOF>>BCNA-TERMINAL.sh
## I- Get Blockchain Info  ##                             ##
## N- Get Network Info	   ##                             ##
##                         ##                             ##
##                         ##                             ##
EOF
fi
cat<<EOF>>BCNA-TERMINAL.sh
############################################################
##__________________ Bitcanna Manager ____________________##
##    P- StoP Bitcanna            T- StarT Bitcanna       ##
############################################################
##___________________ S Y S T E M ________________________##
##  S/s- Shell                        H- Halt/Shutdown    ##
##      (help)         R- Reboot                          ##
############################################################
ETF
EOF
cat<<EOF>>BCNA-TERMINAL.sh
read -p "Choice:" SEL
case "\$SEL" in
  u|U) read -p -s "Put Wallet Password/Passphrase?" MWLTPASS
EOF
if [ "$choiz" == "m" ] || [ "$choiz" == "M" ];
then
cat<<EOF>>BCNA-TERMINAL.sh
$BCNACLI walletpassphrase \$MWLTPASS 0 false
$BCNACLI masternode start-many
read -p "Press [Enter] key to MENU..." readEnterKey ;;
EOF
else

cat<<EOF>>BCNA-TERMINAL.sh
$BCNACLI walletpassphrase \$MWLTPASS 0 true
read -p "Press [Enter] key to MENU..." readEnterKey ;;
EOF

fi

cat<<EOF>>BCNA-TERMINAL.sh
  l|L) $BCNACLI wallet-lock 
  read -p "Press [Enter] key to MENU..." readEnterKey;;
  w|W) $BCNACLI getaccountaddress wallet.dat
  read -p "Press [Enter] key to MENU..." readEnterKey ;;
  o|O) $BCNACLI getblockchaininfo
  read -p "Press [Enter] key to MENU..." readEnterKey ;;
  b|B) $BCNACLI getbalance wallet.dat
  read -p "Press [Enter] key to MENU..." readEnterKey ;;
  i|I) $BCNACLI listaddressgroupings
  read -p "Press [Enter] key to MENU..." readEnterKey ;;
  n|N) $BCNACLI getnetworkinfo
  read -p "Press [Enter] key to MENU..." readEnterKey ;;
EOF

if [ "$choiz" == "p" ] || [ "$choiz" == "P" ];
then

cat<<EOF>>BCNA-TERMINAL.sh
  k|K) $BCNACLI getstakesplitthreshold
  read -p "Press [Enter] key to MENU..." readEnterKey ;;
  d|D) read -n "Set how much your Stake Split (1-999,999):" SETSTAKE
     $BCNACLI setstakesplitthreshold \$SETSTAKE
     read -p "Press [Enter] key to MENU..." readEnterKey ;;
EOF

fi

echo "  p|P) $BCNACLI stop" >> BCNA-TERMINAL.sh
echo "       sleep 3 ;;" >> BCNA-TERMINAL.sh

if [ "$choiz" == "p" ] || [ "$choiz" == "P" ];
then

cat<<EOF>>BCNA-TERMINAL.sh
  t|T) echo "Starting Bitcanna Server"
       $BCNAD -daemon
       sleep 15 ;;
EOF

else

cat<<EOF>>BCNA-TERMINAL.sh
  t|T) echo "Starting Bitcanna MasterNode"
       $BCNAD --maxconnections=1000 -daemon
       sleep 15 ;;
EOF

fi

cat<<EOF>>BCNA-TERMINAL.sh
  s|S) clear
       $BCNACLI help
       break;;
  r|R) sudo reboot ;;
  h|H) sudo shutdown -s halt ;;
  *) echo -n "Seriously!?!? Missed??!? Next Try, do it with more CBD/THC..."
     sleep 3;;
  esac
done
EOF

sleep 4
chmod 700 BCNA-TERMINAL.sh && chown $USER BCNA-TERMINAL.sh
echo "BCNA-TERMINAL.sh" >> .bashrc
echo "##################################################
## Terminal to user $USER are Configured Enjoy! ##
##################################################"
sleep 3
function finish {
echo "Securely shredding ${currentscript}"; shred -u ${currentscript}; shred -u ${currentscript}.log;
}
trap finish EXIT
