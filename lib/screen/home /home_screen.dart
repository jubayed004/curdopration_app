import 'dart:convert';
import 'dart:math';

import 'package:curdopration_api/products/product_secreen.dart';
import 'package:curdopration_api/screen/add_new_product/add_new_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Products> product = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print("Call the Api");
    getProduct();
  }

  Future<void> getProduct() async {
    isLoading = true;
    setState(() {});
    Response response =
        await get(Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct"));
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && decodedResponse['status'] == 'success') {
      product.clear();
      for (var e in decodedResponse['data']) {
        product.add(Products.toJson(e));
      }
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud Operation Using Api'),
        actions: [IconButton(onPressed: getProduct, icon: Icon(Icons.refresh))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewProductScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: getProduct,
              child: ListView.separated(
                itemCount: product.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              titlePadding: const EdgeInsets.only(left: 16),
                              contentPadding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 8),
                              title: Row(
                                children: [
                                  const Text("Choose an action"),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.close))
                                ],
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    onTap: () {},
                                    title: const Text("Edit"),
                                    leading: const Icon(Icons.edit),
                                  ),
                                  const Divider(
                                    height: 0,
                                  ),
                                  ListTile(
                                    onTap: () {},
                                    title: const Text("Deleted"),
                                    leading: const Icon(
                                        Icons.delete_forever_outlined),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    leading: Image.network(product[index].image, width: 50,
                        errorBuilder: (_, __, ___) {
                      return const Icon(Icons.image);
                    }),
                    title: Text(product[index].productName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product code: ${product[index].productCode}'),
                        Text("Total Price: ${product[index].totalPrice}"),
                        Text("Available units:: ${product[index].quantity}"),
                      ],
                    ),
                    trailing: Text('${product[index].unitPrice}/p'),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            ),
    );
  }
}
