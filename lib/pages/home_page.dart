// ignore_for_file: prefer_const_constructors

import 'package:myapp/widgest/bottom_bar.dart';
import 'package:myapp/widgest/catolog.dart';
import 'package:myapp/widgest/item_card.dart';

import '../../models/Product.dart';
// ignore: unused_import
import '../../widgets/bottom_bar.dart';
// ignore: unused_import
import '../../widgets/catalog.dart';
// ignore: unused_import
import '../../widgets/item_card.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key ? key}) : super(key: key);

  get title => null;

  @override
  Widget build(BuildContext context) {

    // ignore: avoid_print
    print('build HomePage');

    // final productData = Provider.of<ProductDataProvider>(context);
    // *��� ������ > 4.1.0
    final productData = context.watch<ProductDataProvider>();

    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height - 85,
          decoration: const BoxDecoration(
            color: Colors.white,
            // ignore: unnecessary_const
            borderRadius: const BorderRadius.only(
              // ignore: unnecessary_const
              bottomLeft: const Radius.circular(35),
              bottomRight: Radius.circular(35),
            )
          ),
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[

              // ignore: avoid_unnecessary_containers
              Container(
                child: const ListTile(
                  title: Text(
                    '���������� �������',
                    // ignore: unnecessary_const
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // ignore: unnecessary_const
                  subtitle: const Text(
                    '������ ��� 100 ����� ��������',
                    style: TextStyle(fontSize: 16,)
                    ),
                  trailing: Icon(Icons.panorama_horizontal),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(5.0),
                height: 290,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productData.items.length,
                  itemBuilder: (context, int index) =>

                    ChangeNotifierProvider.value(
                      value: productData.items[index],
                      // ignore: unnecessary_this
                      child:   ItemCard( this.title, key: title, ),
                    )

                    //ItemCard(product: productData.items[index]),

                  ),
              ),

              ...productData.items.map((value) {
                return CatalogListTile(imgUrl: value.imgUrl);
              }).toList(),

            ],
          )
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}