#!/bin/bash

# This utility script checks the balance of the configured PAC addresses every 30 minutes
# if the balance changes in posotive, it sends out an mail alert of pushbulet notification.
# The notification is sent to a pushullet address, or mail (postfix needs to be configured)

set -x   #uncomment to debug..


#http://explorer.pachub.io/api/addr/PJ69r7p5TutUywudVV8oynPgJuGv6p9KQY/balance/

# Change with Coin addresses you want to monitor and the MN alias
mnAddress=( "PVDfk8QjTQ7vXQQtdZXQmcsUziyRipJztt" "PLGaQmvJm3C5c476Eeb73d4KQDcLpnXY8A" "PKQSbw8XS4RPjcAGBjAoouiVCD77d3xmkQ")
mnAlias=("mn-1" "mn-2" "mn-3")

# Change with your e-mail address
email_address='john.foo@myshillcoin.com'


# initialize balance

balance=()

for (( i = 0; i < ${#mnAddress[@]}; i++ )); do

     balance[i]=$(curl -s  http://explorer.pachub.io/api/addr/${mnAddress[$i]}/balance/)
   

    sleep 5 # respect API rate 

done


# start daemon

while [ true ]; do

    sleep 1800 # only check balance every 30 minutes


    # check the balance change of each address

    for (( i = 0; i < ${#mnAddress[@]}; i++ )); do

        new_balance=$(curl -s http://explorer.pachub.io/api/addr/${mnAddress[$i]}/balance/)
        stakeholder=${mnAlias[$i]}


        if [ $new_balance -gt ${balance[$i]} ]; then

            old_formatted=$((${balance[$i]} / 100000000))
            new_formatted=$(($new_balance / 100000000))
            diff=$(($new_formatted - $old_formatted))

            #Test echo output
            echo "$stakeholder address ${mnAddress[$i]} payment received $diff total $new_formatted "

            #Uncomment the line if you want to use e-mail
            #mail -s "PAC Transaction Alert" $email_address <<< "$stakeholder address ${mnAddress[$i]} payment received $diff total $new_formatted"
            
            # Uncomment the line if you want to use pushbullet
            #/usr/local/bin/pb push "$stakeholder address ${mnAddress[$i]} payment received $diff total $new_formatted"

            balance[i]=$new_balance
            
            

        fi

        sleep 5

    done

done
