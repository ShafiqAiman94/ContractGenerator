#!/bin/sh

#test for the args
if [ "$#" -ne 1 ];then
  exit 0
fi

#compiling the code and take name from the solidity file
suffix=".sol"
file=$1
name=${file%$suffix}
solc_command=$(solc --optimize --combined-json abi,bin,interface $1)

#Output from the compiled code pass to the Output format
out="Output"
equal="="
var="var "
jsfile=$name".js"
#output for the output lel
nameOutput=$var$name$out$equal$solc_command
echo $nameOutput > $jsfile

#Contract ABI
abi="Abi"
nameAbi=$var$name$abi$equal$name$out".contracts['"$1":"$name"'].abi;"
echo $nameAbi >> $jsfile

#Real contract deployment
contract="Contract"
contractvar=$var$name$contract$equal"eth.contract(JSON.parse($name$abi));"
echo $contractvar >> $jsfile

#for bin code deployment
bincode="BinCode"
namebincode=$var$name$bincode$equal"'0x'+"$name$out".contracts['$1:$name'].bin;"
echo $namebincode >> $jsfile

#unlock the account
unlockaccount="personal.unlockAccount(eth.accounts[0])"
echo $unlockaccount >> $jsfile

#deploy the object
deployname=$var"deployTransationObject = { from: eth.accounts[0], data:$name$bincode, gas: 1000000};"
echo $deployname >> $jsfile

#object instance
instance="Instance"
deploymentdone=$var$name$instance$equal$name$contract".new(deployTransationObject,function(e,contract){if(!e){if(!contract.address){console.log('Contract Transaction send: TransactionHash :'+contract.transactionHash+' waiting to be mined..');}else{console.log('Contract mined! Address: '+ contract.address);console.log(contract);}}});"
echo $deploymentdone >> $jsfile

#getting the trasaction hash
address=$var$name"Address = eth.getTransactionReceipt($name$instance.transactionHash).contractAddress;"
#echo $address >> $jsfile
