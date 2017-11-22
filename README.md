# ContractGenerator

Deploying smart contract on the blockchain is quite annoyed for me because I didn't use any DApps framework such as truffle and embark. So, I created a bash script for generate a javascript file from solidity source code. But I didn't put selection for the account, only uses account[0] and gas cost is 10000 wei. You need to configure it manually.


## Running the script
```
bash ContractGenerator.sh file.sol
``` 
It will produce a ```.js``` and deploy it on your Ethereum Virtual Machine (EVM) by using this command
```
loadScript("path/to/your/jsfile")
```
