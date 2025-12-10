import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/services.dart' show rootBundle;

class ContractLinking extends ChangeNotifier {
  // RPC and WS URLs. For Android emulator use 10.0.2.2, for real device use your machine IP.
  final String _rpcUrl = "HTTP://127.0.0.1:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _privateKey = "0x6e96ca14a30fc0eac55ff9a31acf02a5f5bfbf7ba280cd67a0d3b4bfad0126cc";

  late Web3Client _client;
  bool isLoading = true;

  late String _abiCode;
  late EthereumAddress _contractAddress;
  late Credentials _credentials;
  late DeployedContract _contract;
  late ContractFunction _yourName;
  late ContractFunction _setName;
  String deployedName = "Unknown";

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("src/artifacts/HelloWorld.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    // network id 5777 or 1337 depending on Ganache. We'll try both.
    var networks = jsonAbi["networks"];
    String addressHex = "";
    if (networks["5777"] != null && networks["5777"]["address"] != null) {
      addressHex = networks["5777"]["address"];
    } else {
      // try to pick first network entry
      var keys = networks.keys;
      if (keys.isNotEmpty) {
        var first = keys.first;
        addressHex = networks[first]["address"];
      }
    }
    _contractAddress = EthereumAddress.fromHex(addressHex);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(ContractAbi.fromJson(_abiCode, "HelloWorld"), _contractAddress);
    _yourName = _contract.function("yourName");
    _setName = _contract.function("setName");
    await getName();
  }

  Future<void> getName() async {
    try {
      var currentName = await _client.call(contract: _contract, function: _yourName, params: []);
      deployedName = currentName[0] as String;
    } catch (e) {
      deployedName = "Error";
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> setName(String nameToSet) async {
    isLoading = true;
    notifyListeners();
    try {
      await _client.sendTransaction(
        _credentials,
        Transaction.callContract(contract: _contract, function: _setName, parameters: [nameToSet]),
        chainId: null,
        fetchChainIdFromNetworkId: true,
      );
      await getName();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
