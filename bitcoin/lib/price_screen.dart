// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'constants.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? dropdownValue;
  String coin = '?';

  List<String> price = ['0.0', '0.0', '0.0'];
  void updateCoinData({String requiredCoin = 'AUD'}) async {
    for (int i = 0; i < cryptoList.length; i++) {
      http.Response coinData = await http.get(
        Uri.parse(
            'https://rest.coinapi.io/v1/exchangerate/${cryptoList[i]}/$requiredCoin?apikey=$kApiKey#'),
      );

      if (coinData.statusCode == 200) {
        var data = jsonDecode(coinData.body);
        int rate = data['rate'].round();
        setState(() {
          price[i] = rate.toString();
          price[i] += requiredCoin;
        });
      } else {
        setState(() {
          price[i] = 'Error';
        });
      }
    }
  }

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> list = [];
    for (String currency in currenciesList) {
      var newList = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      list.add(newList);
    }

    return DropdownButton<String>(
      hint: Text('Select Currency'),
      icon: Icon(Icons.arrow_downward),
      value: dropdownValue,
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list,
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> newList = [];
    for (String currency in currenciesList) {
      newList.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (value) {
        updateCoinData(requiredCoin: currenciesList[value]);
      },
      children: newList,
    );
  }

  List<Widget> getCoinBox() {
    List<Widget> newList = [];
    for (int i = 0; i < cryptoList.length; i++) {
      newList.add(Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 ${cryptoList[i]} = ${price[i]}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
    }
    newList.add(Container(
      height: 150.0,
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 30.0),
      color: Colors.lightBlue,
      child: Platform.isIOS ? iosPicker() : androidDropDown(),
    ));
    return newList;
  }

  @override
  void initState() {
    updateCoinData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: getCoinBox(),
      ),
    );
  }
}
