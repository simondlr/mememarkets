module.exports = function(deployer, network) {
  //choose network for migration by adding it as an option.
  //eg: truffle migrate --network testrpc
  deployer.deploy(MemeFactory);
}
