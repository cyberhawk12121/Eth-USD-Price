const PriceContract= artifacts.require('PriceContract');

// YOU CAN WRITE THIS DIRECTLY IN TRUFFLE CONSOLE
module.exports= async function(deployer){
    await deployer.deploy(PriceContract);
}