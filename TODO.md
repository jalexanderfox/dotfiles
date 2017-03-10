# TODO:

## Test install_all.sh in vagrant

## Test terminal colors install
<!--
# set terminal colors
  # "Default Window Settings" = "Solarized Dark ansi";
  # "Startup Window Settings" = "Solarized Dark ansi";
# read
defaults read com.apple.Terminal "Default Window Settings"
defaults read com.apple.Terminal "Startup Window Settings"

# write
defaults write com.apple.Terminal "Default Window Settings" -string "Solarized Dark ansi"
defaults write com.apple.Terminal "Startup Window Settings" -string "Solarized Dark ansi"

# restart terminal
open ./restart-terminal.app
 -->
## netloc to change network location (Office/Public)

Set Public npm registry to: https://registry.npmjs.org/
Set Office npm registry to: http://npm.kroger.com/

## Add change network location on proxy init if location is not set

<!--
Usage: networksetup -getcurrentlocation
	Display the name of the current location.
Usage: networksetup -listlocations
	List all of the locations.
Usage: networksetup -createlocation <location name> [populate]
	Create a new network location with the spcified name.
	If the optional term "populate" is included, the location will be populated with the default services.
Usage: networksetup -deletelocation <location name>
	Delete the location.
Usage: networksetup -switchtolocation <location name>
	Make the specified location the current location.
-->

```bash
switch_network_location() {
  current_network_location=$(networksetup -getcurrentlocation)
  if [[ "$current_network_location" != "$1" ]]
  then
    networksetup -switchtolocation $1
  fi
}

switch_network_location $proxy_network_location
```


## Add bash completion to aws cli if installed
```bash
if [[ -n $(which aws) ]]
then
  complete -C aws_completer aws
fi
```


# Add store/use keychain for ssh

Below did not seem to work:
```
Host *
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa
```

```bash
storm add * --o "UseKeychain yes" --o "AddKeysToAgent yes" --o "IdentityFile ~/.ssh/id_rsa"
```

Try this in .bash_profile next:
```bash
if [[ -e "$HOME/.ssh/id_rsa" ]]
then
  ssh-add -K "$HOME/.ssh/id_rsa"
fi
```
