// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

import '../models/Cart.dart';
import '../models/Product.dart';
import '../pages/cart_page.dart';

class ItemPage extends StatelessWidget {

  final String productId;

  // ignore: prefer_const_constructors_in_immutables
  ItemPage({Key ? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final data = context.watch<ProductDataProvider>()
      .getElementById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(data.title, style: GoogleFonts.marmelad(),),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: ListView(
          children: <Widget>[
            Hero(
              tag: data.imgUrl, 
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data.imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Card(
              elevation: 5.0,
              margin: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
              child: Container(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    // ignore: prefer_const_constructors
                    Text(data.title, style: TextStyle(fontSize: 26.0),),
                    // ignore: prefer_const_constructors
                    Divider(),
                    Row(
                      children: <Widget>[
                        Text('Цена: ', style: TextStyle(fontSize: 24.0),),
                        Text('${data.price}', style: TextStyle(fontSize: 24.0),),
                      ],
                    ),
                    Divider(),
                    Text(data.description),

                    SizedBox(
                      height: 20.0,
                    ),

                    //Provider.of<CartDataProvider>(context)
                    context.watch<CartDataProvider>()
                      .cartItems
                      .containsKey(productId)
                    ? Column(
                      children: <Widget>[
                        MaterialButton(
                          color: Color(0xFFCCFF90),
                          child: Text('Перейти в корзину'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CartPage(),
                            ));
                          }
                        ),
                        Text(
                          'Товар уже добавлен в корзину',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.blueGrey,
                          ),
                        )
                      ],
                    )
                    : MaterialButton(
                        color: Theme.of(context).primaryColor,
                        child: Text('Добавить в корзину'),
                        onPressed: () {
                          context.read<CartDataProvider>().addItem(
                            productId: data.id,
                            imgUrl: data.imgUrl,
                            title: data.title,
                            price: data.price,
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}