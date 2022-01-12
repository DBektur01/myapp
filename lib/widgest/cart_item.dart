// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Cart.dart';
import '../pages/item_page.dart';

class CartItem extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final cartData;
  // ignore: prefer_typing_uninitialized_variables
  final index;

  const CartItem({Key ? key, this.cartData, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: ListTile(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ItemPage(
                  productId: cartData.cartItems.keys.toList()[index],
                ),
              ),
            );
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(
                    cartData.cartItems.values.toList()[index].imgUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Text(cartData.cartItems.values.toList()[index].title),
        subtitle:
            Text('Цена: ${cartData.cartItems.values.toList()[index].price}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
                // ignore: prefer_const_constructors
                icon: Icon(Icons.remove_circle_outline),
                onPressed: () {
                  Provider.of<CartDataProvider>(context, listen: false)
                      .updateItemsSubOne(
                          cartData.cartItems.keys.toList()[index]);
                }),
            Text('x${cartData.cartItems.values.toList()[index].number}'),
            IconButton(
                // ignore: prefer_const_constructors
                icon: Icon(Icons.add_circle_outline),
                onPressed: () {
                  Provider.of<CartDataProvider>(context, listen: false)
                      .updateItemsAddOne(
                          cartData.cartItems.keys.toList()[index]);
                }),
          ],
        ),
      ),
    );
  }
}