# $PAC balance check

This utility script checks the balance of the configured $PAC addresses every 30 minutes
and, if the balance changes, sends an alert to the configured e-mail address or PushBullet service.

Best suited to run from a dedicated linux server like one masternode instance.



## Getting Started

Notification are delivered by mail or [pushbullet application](https://www.pushbullet.com/apps)
For **non tech-savvy** the **best option is to use the pushbullet notification**, for others be free and configure postfix to deliver mail.



### Installing

* Install requited ubuntu packages
```
$ sudo apt-get update && sudo apt-get install screen bc postfix python-pip -y
$ sudo pip install pushbullet-cli
```
* Download the bash script, and make it executable
```
$ wget https://raw.githubusercontent.com/foxrtb/pac-balance-check/master/pac-balance-check.sh
$ chmod +x pac-balance-check.sh
```



### Configuring

* edit the script
```
$ nano pac-balance-check.sh
```
enter your pac addresses in ```pac_addresses=( xxxx xx xxx xxx )```

enter your mail address in ```email_address='your.email@domain.com```

**if you want pushullet notifications:**

comment the line 47 ``` mail -s "PAC Transaction Alert...```

and comment **out** line 48 ```#   /usr/local/bin/pb push "PAC ...```




### push notifications with PushBullet
* install pushbullet  ($ pip install pushbullet-cli)   
* enter your pushulet api key ($ pb set-key)
* comment out mail and uncomment pushbulet option in the script



## News

```
Soon a native android application will be published...
```


## Authors

* **FoxD**


## License

This project is licensed under the MIT License 
