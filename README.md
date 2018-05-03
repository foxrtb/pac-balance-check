# pac-balance-check
This utility script checks the balance of the configured $PAC addresses every 30 minutes
and, if the balance changes, sends an alert email to the configured address


* Install and configure postfix
* Install screen  (apt-get install screen)
* Install bc  (apt-get install bc)

* screen -S PAC
....


## push notifications with pushbullet
* install pushbullet  ($ pip install pushbullet-cli)   
* enter your pushulet api key ($ pb set-key)
* comment out mail and uncomment pushbulet option in the script

