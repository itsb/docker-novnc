docker-novnc
============

This is a minimal image which will help you run a vnc server with lxde in a docker container and access it from ANY recent browser without requiring you to do any configuration on the client side.

## Use Cases

1. Provide system application accessible over the web easily. Lets say you want to demo software which runs on your pc over the internet without requiring the clients to install any software like Teamviewer, etc.

2. You can use this to create a simple use & throw linux envinronment with GUI over cloud or any VPS/Server or even on your laptop.

Especially useful if you have to give access to your friends who come over for facebook/twittering on your PC. :)

## How to use
```
docker run -td -p 6080:6080 itsb/docker-novnc

# Or if you want to build it yourself
git clone https://github.com/itsb/docker-novnc.git
cd docker-novnc
docker build -t novnc .
docker run --rm -d -p 80:6080 novnc
```

Now visit http://localhost in your browser for a resizable linux desktop

## Credits

* [NoVNC](http://kanaka.github.io/noVNC/)
* [Original docker-novnc project](https://github.com/paimpozhil/docker-novnc)
* [Docker-Ubuntu-Unity-noVNC](https://github.com/chenjr0719/Docker-Ubuntu-Unity-noVNC)
* [docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop)
