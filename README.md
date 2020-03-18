# BCNA Install Script

This is a Contribuition Script! It is not official or developed by the Bitcanna.io Team!

NOTE: we are working in a upgrade script also

All configurations are following the official Bitcanna Guides <https://www.bitcanna.io/guides/> 

This script is prepared to install and configure a Bitcanna Masternode or Bitcanna Fullnode Wallet for stake (PoS) on a Linux Virtual Private Server (VPS) with Ubuntu 18.04 LTS Server.

This is one file script BCNA-Script.sh and ONLY run one time on the server!

# !!!!ATTENTION!!!!!
To Run the Masternode YOU NEED AT LEAST 100K (100.000) of BCNA (BitCanna Coins)!!

Please, Read the BitCanna WhitePaper at https://www.bitcanna.io/whitepaper/


# STATUS: *V1.9.11.20*

*BCNA-Script.sh Container:*
 - Download Lastest BCNA Unix version
 - Choose Syncing by Network or Bootstrap
 - Configuration Bitcanna FullNode to Proof-of-Stake (see BCNA FullNode Guide)
 - Configuration Bitcanna MasterNode (see BCNA MasterNode Guide)
 - Adding bitcanna AS BINary (just type: $ bitcannd OR $ bitcanna-cli )
 - Encrypt wallets with password/passphrase
 - Backup (wallet.dat + wallet address + dumpprivkey + wallet pass = WalletBackup.tar.gz)
 - Final Cleaning and Fresh Running

*BCNA-Terminal-prep.sh Container:*
  - Menu with some useful commands shortcuts (In dev..)

*BCNA-Recalc.sh Container:*
 - Get Balance
 - Calculate and Set SpliStakeThreshold
 - Calculate and Set AutoCombine

# Requirements: 

For the best experience of this script, Recommended settins of the Putty Console Window should be: 
Columns:90 Rows:35 (check in screenshots/0-PuttyConf.png)

$ apt update && apt upgrade -y && apt install -y git unzip 


# Run:
$ git clone https://github.com/hellresistor/BitCanna-Installer.git && chmod 770 -R BitCanna-Installer && ./BitCanna-Installer/BCNA-Install.sh


# $ Please, Check all code! Don't judge me before you have read it! So much work done here, some respect would be nice $
 
 
# Support donating:
If you like this script and/or it saved you a lot of time
feel free do give tips to get some seeds or CBD with Bitcanna Coins.
BCNA Address:  B73RRFVtndfPRNSgSQg34yqz4e9eWyKRSv

# 420 Time
With many 420 times and dedication
I hope all Bitcanna Team members-Devs-Supporters-Investors-Consumers-Community members enjoy this script. And have a good reduction on THC use :P
I am grateful to/get help/ed with knowledgement contribution and re-distribution!

# Contributions
If you have any wishes for new features, please let me know or add them yourself. 
(Thank you ALL to help to do this better)

# Contact on
Official Bitcanna Telegram Channel (https://t.me/joinchat/F4JfThITJB3cU-uaCwtKlQ)

# Extra
 Need a VPS to run your FullNode or MasterNode? (affiliate links below)

Time4VPS: https://www.time4vps.com/?affid=4335

 Need Get Some BitCanna To Staking or MasterNode?

CoinDeal: https://coindeal.com/ref/AV4X

Stex: https://app.stex.com/?ref=75177165
