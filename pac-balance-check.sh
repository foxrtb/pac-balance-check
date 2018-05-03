#!/bin/bash

# This utility script checks the balance of the configured PAC addresses every 30 minutes

# and, if the balance changes, sends an alert email to the configured address

set -x

pac_addresses=( PxxXXXXXXXxxxXXXYYYxxxx PxxXXXXXXXxxxXXXYYYxxxx PxxXXXXXXXxxxXXXYYYxxxx )

email_address='your.email@domain.com'


# initialize balances

pac_balances=()

for (( i = 0; i < ${#pac_addresses[@]}; i++ )); do

     pac_balances[i]=$(curl -s  http://explorer.paccoin.io/api/addr/${pac_addresses[$i]}/balance/)

    sleep 10 # respect API rate 

done


# daemon

while [ true ]; do

    sleep 1800 # only check addresses balances every 30 minutes


    # check the balance of each address

    for (( i = 0; i < ${#pac_addresses[@]}; i++ )); do

        new_balance=$(curl -s http://explorer.paccoin.io/api/addr/${pac_addresses[$i]}/balance/)


        if [ $new_balance -ne ${pac_balances[$i]} ]; then

            old_formatted=$(echo "${pac_balances[$i]}/100000000" | bc -l | sed 's/0*$//')

            new_formatted=$(echo "$new_balance/100000000" | bc -l | sed 's/0*$//')

            mail -s "PAC Transaction Alert" $email_address <<< "The balance of ${pac_addresses[$i]} has changed from $old_formatted to $new_formatted PAC!"

            pac_balances[i]=$new_balance

        fi

        sleep 10

    done

done
