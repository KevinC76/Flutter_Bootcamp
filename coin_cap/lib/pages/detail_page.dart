import "package:coin_cap/services/http_service.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";

class DetailsPage extends StatelessWidget {
  final Map rates;

  DetailsPage({required this.rates});

  @override
  Widget build(BuildContext context) {
    List _currencies = rates.keys.toList();
    List _exchangeRates = rates.values.toList();
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: _currencies.length,
          itemBuilder: (_context, _index) {
            String _currency = _currencies[_index].toString().toUpperCase();
            String _exchange = _exchangeRates[_index].toString();
            return ListTile(
              title: Text(
                "${_currency}: ${_exchange}",
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
