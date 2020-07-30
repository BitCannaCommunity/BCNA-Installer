[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
![LintCheck](https://github.com/hellresistor/BCNA-Installer/workflows/LintCheck/badge.svg?branch=master)
[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)

# BCNA Install Script

This is a Contribuition Script! It is not official or developed by the Bitcanna.io Team!

All configurations are following the official [Bitcanna Guides](https://www.bitcanna.io/guides) 

This script is prepared to install and configure a Bitcanna Masternode or Bitcanna Fullnode Wallet for stake (PoS) on a Linux Virtual Private Server (VPS) with Ubuntu or Debian.

This script "BCNA-Script.sh" Can be executed 'N' times what you want to same user!

# !!!!ATTENTION!!!!!
To Run the Masternode YOU NEED AT LEAST 100K (100.000) of BCNA (BitCanna Coins)!!

Please, Read the [BitCanna Whitepaper](https://www.bitcanna.io/whitepaper)


# STATUS: *V2.00*

*New:*
 - Add "Detect/Import wallet.dat/Private Key" options on BCNA-Script.sh  

*BCNA-Script.sh Container:*
 - Install / Upgrade / Remove Lastest BCNA Unix version
 - Create a new wallet.dat and BitCanna address
 - Choose Syncing by Network or Bootstrap
 - Choose Bitcanna Wallet has Full-Node to Proof-of-Stake (see BCNA FullNode Guide)
 - Choose Bitcanna Wallet has MasterNode (see BCNA MasterNode Guide)
 - Adding bitcanna AS BINary (just type: $ bitcannd OR $ bitcanna-cli )
 - Import wallet/address using wallet.dat
 - Import a Private key
 - Encrypt wallet.dat with password/passphrase
 - Backup (wallet.dat + wallet address + dumpprivkey + wallet passphrase = WalletBackup.tar.gz) - SAVE THIS FILE WITH YOUR OWN LIFE :)
 - If you liked, Donate !!! :)

*BCNA-Recalc.sh Container:*
 - Get Balance
 - Calculate and Set SpliStakeThreshold
 - Calculate and Set AutoCombine (default: 0 - disable)
 
*BCNA-ExtractPeerList.sh Container:*
 - Get List of Ip and Port of Connected nodes.
 - Export and Sort into 'ExtractPeerList.txt' file.
 
*BCNA-Console.sh Container:
 - Get Wallet Address
 - Check Masternode/POS status
 - Stop/start Bitcanna
 - Set Stake value
 - Extract IP Peer List
 - Get Blockchain and network information

# Requirements: 

For the best experience, Should Set the Putty Console Window To: (check on screenshots)
 - Columns:90
 - Rows:35 

# Tested On:
 - Debian 10.4
 - Ubuntu Server 18.04 LTS
 - Ubuntu Server 20.04

# Run as normal User (NOT ROOT):
 ### You can upload your "wallet.dat" file into $PWD directory (NOT RECOMMENDED THIS METHOD, Import Private Key!). Example: /home/bitcannauser/wallet.dat on same dir as /home/bitcannauser/*
    git clone https://github.com/BitCannaCommunity/BCNA-Installer.git
    chmod -R 700 BCNA-Installer && bash "$PWD"/BCNA-Installer/BCNA-Script.sh


# Support donating:
If you like this script and/or it saved you a lot of time
feel free do give tips to get some seeds or CBD with Bitcanna Coins.
BCNA Address:  B73RRFVtndfPRNSgSQg34yqz4e9eWyKRSv

# 420 Time
With many 420 times and dedication
I hope all Bitcanna Team members-Devs-Supporters-Investors-Consumers-Community members enjoy this script. And have a good reduction on THC use :P
I am grateful to/get help/ed with knowledgement contribution and re-distribution!

# Contributions
If you have any wishes for new features, please let Community knows or add them yourself. 
(Thank you ALL to help to do this better)

# Contact on
Official Bitcanna Channel on [Telegram](https://t.me/joinchat/F4JfThITJB3cU-uaCwtKlQ)

# Extra
 Need a VPS to run your FullNode or MasterNode?

  - [Time4VPS](https://www.time4vps.com/?affid=4335)

 Need Get Some BitCanna To Staking or MasterNode?

 - [CoinDeal](https://coindeal.com/ref/AV4X)
 - [Stex](https://app.stex.com/?ref=75177165)
