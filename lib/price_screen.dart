import 'package:coin_ticker/coindata.dart';
import 'package:coin_ticker/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'dart:io' show Platform;

import 'package:flutter/widgets.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  double selectedCurrenyRate = 42913.161091;
  double selectedCurrenyRate2 = 2548.947412;
  double selectedCurrenyRate3 = 72.455523;

  getCurrencyExchnageRate(String base, String target) async {
    var response = await getCurrencyExchangeRate(base, target);
    if (base == 'ETH') {
      setState(() {
        selectedCurrenyRate2 = response['exchange_rates'][target];
        selectedCurrency = target;
      });
    }
    if (base == 'LTC') {
      setState(() {
        selectedCurrenyRate3 = response['exchange_rates'][target];
        selectedCurrency = target;
      });
    }
    if (base == 'BTC') {
      setState(() {
        selectedCurrenyRate = response['exchange_rates'][target];
        selectedCurrency = target;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getThreeTiles('BTC', selectedCurrenyRate, selectedCurrency),
          getThreeTiles('ETH', selectedCurrenyRate2, selectedCurrency),
          getThreeTiles('LTC', selectedCurrenyRate3, selectedCurrency),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getPicker()),
        ],
      ),
    );
  }

  Widget getThreeTiles(String i, selectedCurrenyRat, selectedCurrenc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $i = $selectedCurrenyRat  $selectedCurrenc',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return getIosPicker();
    }
    return getAndriodDropDownList();
  }

  Widget getIosPicker() {
    List<Text> pickerTiles = [];
    for (String currency in currenciesList) {
      pickerTiles.add(Text(currency));
    }
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (index) {
          print(index);
          getCurrencyExchnageRate('BTC', currenciesList[index]);
        },
        children: pickerTiles);
  }

  Widget getAndriodDropDownList() {
    List<DropdownMenuItem<String>> widgetList = [];
    for (var currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      print(newItem);
      widgetList.add(newItem);
    }
    return DropdownButton(
      value: selectedCurrency,
      items: widgetList,
      onChanged: (value) async {
        if (value != null) {
          await getCurrencyExchnageRate('BTC', value);
          await getCurrencyExchnageRate('ETH', value);
          await getCurrencyExchnageRate('LTC', value);
        }
      },
    );
  }
}
