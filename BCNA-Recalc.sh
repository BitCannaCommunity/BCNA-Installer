#!/bin/bash
##
## Hellresistor tool to Recalculate SplitStakeThreshold
## Ver: 19.12.21
##
## Formula math by @Johnny_X89 and banana1 THANK YOU!
##

cat<<EOF
##############################
##  THIS WILL RECALCULATE   ##
##   YOUR BALANCE TO BEST   ##
##   Stake Split Threshold  ##
##############################
EOF
read -p "YOU WANT CONTINUE? Press any key"
bitcanna-cli autocombinerewards false

MyBal=$(bitcanna-cli getbalance)
MyBalR=$(echo "$MyBal" | awk '{printf("%d\n",$1 + 0.5)}')

MYSTAKE=$(awk -v m=$MyBal 'BEGIN { print 1 + (((m / 1000) * 250) / 4.8) }') ## banana1 formula
# MYSTAKE=$(awk -v m=$MyBal 'BEGIN { print 1 + (((m / 1000) * 250) / 1.2) }') ## Johnny_X89 formula

MYSTAKER=$(echo "$MYSTAKE" | awk '{printf("%d\n",$1 + 0.5)}')
MYSPLIT=$(awk -v m=$MYSTAKE 'BEGIN { print 1 + (m / 2) }')
MYSPLITR=$(echo "$MYSPLIT" | awk '{printf("%d\n",$1 + 0.5)}')

bitcanna-cli setstakesplitthreshold $MYSTAKER
bitcanna-cli autocombinerewards true $MYSPLITR

cat<<EOF > Recalc.$(date +"%d_%m_%Y").log
#################################
##  Stakes ReCalculated DONE!  ##
##  $(date +"%d_%m_%Y")
#################################
                             
       Balance: $MyBal       
       Stake: $MYSTAKER       
       Split: $MYSPLITR       
                             
#################################
EOF
