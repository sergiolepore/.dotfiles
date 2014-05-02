# .dotfiles

These are my .dotfiles. There are many like them, but these ones are mine.

<p align="center">
   <img src="http://i5.minus.com/ic2mwZVtWxUgg.png">
</p>

<p align="center">
    <img src="http://i2.minus.com/iDUwD3xZdAUB5.png">
</p>

## Install guide

1. Clone it into `~`
2. Run `install.sh`
3. Wait

## FAQ

#### I have OSX, th...

Nope, my machine only runs Linux distributions. Currently, I'm using these 
dotfiles under Ubuntu 14.04 LTS. I'm not sure if these scripts will run in 
another OS. Sorry :(

#### Why have you numbered the folders?

There are scripts that MUST be executed before others. For example, I need `zsh` 
before installing `nvm`, because the latter appends a line on my `.zshrc` file.

#### Why have you numbered certain `.install` files?

Pretty much like the answer above. Take `node` as an example. First I need 
to install `nvm` (by running `1-nvm-app.install`). Once completed, running
`2-nvm-node-config.install` will download, compile and install an updated 
version of Node.js, using the `nvm` application installed before. If you don't 
know what `nvm` is, please refer to 
[https://github.com/creationix/nvm](https://github.com/creationix/nvm)

#### Do I need to execute all `.install` scripts manually?

Nope, you just have to run `./install.sh`. This script will do the magic.