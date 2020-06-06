#!/bin/bash
# ------------------------------------------------------
# Bitcanna Community - Recalculate SplitStakeThreshold
# Ver: 1.18
# ------------------------------------------------------
# Formula math by: @Johnny_X89
# ------------------------------------------------------

echo -e "$'\e[0m'$'\e[48;5;250m'$'\e[90m'"
clear
echo -e "$'\e[38;5;34m'    THIS WILL RECALCULATE\\n    YOUR BALANCE TO BEST\\n    Stake Split Threshold\\n\\n$'\e[0m'$'\e[48;5;250m'$'\e[90m$'\e[38;5;214m''in 3 seconds ..."
sleep 3
MyBal=$(bitcanna-cli getbalance)
MyBalR=$(echo "$MyBal" | awk '{printf("%d\n",$1 + 0.5)}')
MYSTAKE=$(awk -v m="$MyBalR" 'BEGIN { print 1 + (((m / 1000) * 250) / 1.2) }')
MYSTAKER=$(echo "$MYSTAKE" | awk '{printf("%d\n",$1 + 0.5)}')
MYSPLIT=$(awk -v m="$MYSTAKE" 'BEGIN { print 1 + (m / 2) }')
MYSPLITR=$(echo "$MYSPLIT" | awk '{printf("%d\n",$1 + 0.5)}')

echo -e "  Stakes ReCalculated!\\n  ""$(date +"%d_%m_%Y")""\\n\\n       Balance: ""$MyBal""\\n       Stake: ""$MYSTAKER""\\n       Split: ""$MYSPLITR""\\n\\n"
echo -e "\\nSure you want DEFINE this Stake Split Threshold? (Y/N)"
read -r choiz
if [ "$choiz" == "y" ] || [ "$choiz" == "Y" ]; then
  bitcanna-cli autocombinerewards false
  bitcanna-cli setstakesplitthreshold "$MYSTAKER"
  #bitcanna-cli autocombinerewards true "$MYSPLITR"  # Remove comment on this line to Enable auto combine rewards
  echo -e "  Stakes ReCalculated!\\n  ""$(date +"%d_%m_%Y")""\\n\\n       Balance: ""$MyBal""\\n       Stake: ""$MYSTAKER""\\n       Split: ""$MYSPLITR""\\n" > Recalc."$(date +"%Y%m%d%H%M%S")".log
elif [ "$choiz" == "n" ] || [ "$choiz" == "N" ]; then 
 echo -e "Bye $'\e[0m'" && sleep 0.3  && exit 1
else
 echo -e "SERIOUSLY!? Missed.. Bye! $'\e[0m'" && sleep 0.3 && exit 1
fi

echo -e "DONE! $'\e[0m'"
exit 0
