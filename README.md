# pac-balance-check
This utility script checks the balance of the configured $PAC addresses every 30 minutes
and, if the balance changes, sends an alert email to the configured address


* Install and configure postfix
* Install screen  (apt-get install screen)
* Install bc  (apt-get install bc)

* screen -S PAC
....

