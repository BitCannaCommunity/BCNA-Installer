#!/bin/bash
# ------------------------------------------------------
# Bitcanna Community - Recalculate SplitStakeThreshold
# Ver: 1.75
# by: hellresistor
# ------------------------------------------------------
# Formula math by: @Johnny_X89
# ------------------------------------------------------

AUTOCOMBINE="0" # 0(disable-default) or 1 (enable)

export endc=$'\e[0m'
export sbl=$'\e[4m'
export bld=$'\e[1m'
export white=$'\e[97m'
export background=${endc}$'\e[48;5;235m'${white}
export red=${background}$'\e[38;5;196m'
export green=${background}$'\e[38;5;34m'
export yellow=${background}$'\e[38;5;172m'
export grey=${background}$'\e[1;38;5;252m'

echo -e "${grey}${yellow}\tTHIS WILL RECALCULATE\n\tYOUR BALANCE TO A NICE\n\tStake Split Threshold${grey}\n\n"
while true
do
 MyBal=$(bitcanna-cli getbalance)
 MyBalR=$(echo "$MyBal" | awk '{printf("%d\n",$1 + 0.5)}')
 MYSTAKE=$(awk -v m="$MyBalR" 'BEGIN { print 1 + (((m / 1000) * 250) / 1.2) }')
 MYSTAKER=$(echo "$MYSTAKE" | awk '{printf("%d\n",$1 + 0.5)}')
 MYSPLIT=$(awk -v m="$MYSTAKE" 'BEGIN { print 1 + (m / 2) }')
 MYSPLITR=$(echo "$MYSPLIT" | awk '{printf("%d\n",$1 + 0.5)}')
 echo -e "${grey}--> ${green}Stakes ReCalculated on Date${grey}: ${yellow}$(date +"%d-%m-%Y") ${grey}!!!\n\n\t${grey}\tBalance: ${green}$MyBal\n\t${grey}Stake: ${green}$MYSTAKER\n\t${grey}Split: ${green}$MYSPLITR\n\n"
 echo -e "${grey}${yellow}Sure you want DEFINE this Stake Split Threshold? (Y/N)"
 read -r splitchoic
 case "$splitchoic" in
  y|Y) bitcanna-cli autocombinerewards false
       bitcanna-cli setstakesplitthreshold "$MYSTAKER"
	   if [ "$AUTOCOMBINE" -eq 1 ] ; then
	    bitcanna-cli autocombinerewards true "$MYSPLITR"
	   else
	    echo -e "${red}NO AutoCombine selected ${grey}!!!" && sleep 0.5
       fi
	   echo -e "Stakes ReCalculated on Date: $(date +"%d-%m-%Y")\nBalance: $MyBal\nStake: $MYSTAKER\nSplit: $MYSPLITR\n---------------------------------------" >> Recalc.log
	   sleep 1 && break ;;
  n|N) echo -e "${yellow}Nothing changed${grey}!!! ${red}Bye${grey}...${endc}"
       sleep 1 && break ;;
    *) echo -e "${red}ByeSERIOUSLY${grey}?!?!? ${red}Missed ${grey}... ${red}Bye ${grey}...${endc}" && sleep 1 ;;
 esac
 echo -e "${green}DONE${grey}!!!${endc}"
done
