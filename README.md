# $PAC balance check

This utility script checks the balance of the configured $PAC addresses every 30 minutes
and, if the balance changes, sends an alert to the configured e-mail address or PushBullet service.

Best suited to run from a dedicated linux server. Tip: you can run this script on the same masternode instance.



## Getting Started

Notification are delivered by mail or [pushbullet application](https://www.pushbullet.com/apps)
For **non tech-savvy** the **best option is to use the pushbullet notification**, for others be free and configure postfix to deliver mail.



### Installing

* Install required Ubuntu packages
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
enter your pac addresses in ```pac_addresses=( PxxXXXXXYYYxxxx PxxXXXxxxx PxxXXXXxxxx )```

enter your mail address in ```email_address='your.email@domain.com```

**if you want pushullet notifications:**

comment the line 47 ``` mail -s "PAC Transaction Alert...```

and comment **out** line 48 ```#   /usr/local/bin/pb push "PAC ...```




### Mobile Push notifications with PushBullet
* register/login to (https://www.pushbullet.com/)
* install pushbullet app on your mobile
* get the API key from http://pushbullet.com  --> account settings -> Access Tokens --> Create Access Token
* enter the Access Token API key in the ubuntu instance
```
$ pb set-key
```


### Starting the app
* run the application in the virtual screen console
```
$ screen -S PAC
$ ./pac-balance-check.sh
```
* Detach from the virtual console
```
On your keyboard press and HODL:  <CTRL> a d
```
* Attach back to the virtual console
```
screen -x PAC
```




## News

```
Soon a native android application will be published...
```


## Authors

* **FoxD**


## License

This project is licensed under the MIT License 
