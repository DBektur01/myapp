// ignore_for_file: import_of_legacy_library_into_null_safe

import '../models/Cart.dart';
// ignore: unused_import
import '../widgets/cart_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  CartPage({Key ? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //final cartData = Provider.of<CartDataProvider>(context);
    final cartData = context.watch<CartDataProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзинка счастья'),
      ),
      body: cartData.cartItems.isEmpty
        ? Card(
          elevation: 5.0,
          margin: const EdgeInsets.all(30.0),
          child: Container(
            height: 100,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text('Корзинка пустая ;(', ),
          ),
        )
        : Column(
          children: <Widget>[
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Стоимость: ' + cartData.totalAmount.toStringAsFixed(2),
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize:20.0),
                ),
                MaterialButton(
                onPressed: () {
                  cartData.clear();
                },
                color: Theme.of(context).primaryColor,
                child: const Text('Купить'),
                ),
              ],
            ),
            const Divider(),

            Expanded(child: CartItemList(cartData: cartData)),

          ],
        )
    );
  }

  // ignore: non_constant_identifier_names
  CartItemList({required CartDataProvider cartData}) {}
}