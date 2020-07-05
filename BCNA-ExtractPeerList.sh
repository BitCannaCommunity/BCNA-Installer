#!/bin/bash
# --------------------------------------------------------
# Bitcanna Community - Extracting connected peers IP/Port 
# Ver: 1.75
# by: hellresistor
# --------------------------------------------------------

bitcanna-cli getpeerinfo > ips.txt
sed -i '/id/d' ips.txt
sed -i '/addrlocal/d' ips.txt
sed -i '/services/d' ips.txt
sed -i '/lastsend/d' ips.txt
sed -i '/lastrecv/d' ips.txt
sed -i '/bytessent/d' ips.txt
sed -i '/bytesrecv/d' ips.txt
sed -i '/conntime/d' ips.txt
sed -i '/pingtime/d' ips.txt
sed -i '/version/d' ips.txt
sed -i '/subver/d' ips.txt
sed -i '/inbound/d' ips.txt
sed -i '/startingheight/d' ips.txt
sed -i '/banscore/d' ips.txt
sed -i '/synced_headers/d' ips.txt
sed -i '/\"synced_blocks\" : /d' ips.txt
sed -i '/inflight/d' ips.txt
sed -i '/whitelisted/d' ips.txt
sed -i '/pingwait/d' ips.txt
sed -i '/{/d' ips.txt
sed -i '/}/d' ips.txt
sed -i "/\[/d" ips.txt
sed -i '/]/d' ips.txt
sed -i "s/\"addr\" : //g" ips.txt
sed -i "s/\"//g" ips.txt
sed -i "s/,//g" ips.txt
sed -i "s/        //g" ips.txt

echo "-------------------------------------------------------------------
- BCNA-ExtractPeerList.sh - Output in $(date +"%Y-%m-%d %I:%M%p") -
-------------------------------------------------------------------" >> ExtractPeerList.txt
sort -n ips.txt >> ExtractPeerList.txt
rm ips.txt
