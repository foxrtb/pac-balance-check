#!/bin/bash

# This utility script checks the balance of the configured PAC addresses every 30 minutes
# and, if the balance changes, sends out an mail alert of pushbulet notification.

#set -x   #uncomment to debug..

# Change with PAC addresses you want to monitor
pac_addresses=( PxxXXXXXXXxxxXXXYYYxxxx PxxXXXXXXXxxxXXXYYYxxxx PxxXXXXXXXxxxXXXYYYxxxx )

# Change with your e-mail address
email_address='john.foo@pacmail.com'


# initialize balances

pac_balances=()

for (( i = 0; i < ${#pac_addresses[@]}; i++ )); do

     pac_balances[i]=$(curl -s  http://explorer.paccoin.io/api/addr/${pac_addresses[$i]}/balance/)

    sleep 10 # respect API rate 

done


# start daemon

while [ true ]; do

    sleep 1800 # only check addresses balances every 30 minutes


    # check the balance of each address

    for (( i = 0; i < ${#pac_addresses[@]}; i++ )); do

        new_balance=$(curl -s http://explorer.paccoin.io/api/addr/${pac_addresses[$i]}/balance/)


        if [ $new_balance -ne ${pac_balances[$i]} ]; then

            old_formatted=$(echo "${pac_balances[$i]}/100000000" | bc -l | sed 's/0*$//')

            new_formatted=$(echo "$new_balance/100000000" | bc -l | sed 's/0*$//')

            #Comment with '#' if you want to disable e-mail
            mail -s "PAC Transaction Alert" $email_address <<< "The balance of ${pac_addresses[$i]} has changed from $old_formatted to $new_formatted PAC!"
           
            # Uncomment the line if you want to use pushbullet
#           /usr/local/bin/pb push "PAC balance of ${pac_addresses[$i]} has changed from $old_formatted to $new_formatted PAC!"

            pac_balances[i]=$new_balance

        fi

        sleep 10

    done

done
