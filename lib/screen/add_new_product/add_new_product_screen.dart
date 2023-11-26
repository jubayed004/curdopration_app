import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({Key? key}) : super(key: key);

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _productCodeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formState,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter your valid Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter your valid Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _productCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Product Code',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter your valid Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                    controller: _totalPriceController,
                    decoration: const InputDecoration(
                      labelText: ' Total Price',
                    )),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                    controller: _imageController,
                    decoration: const InputDecoration(
                      labelText: 'image',
                    )),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async{
                        if (_formState.currentState!.validate()) {
                         Response response = await post(
                              Uri.parse(
                                  "https://crud.teamrabbil.com/api/v1/CreateProduct"),
                              headers: {
                                'Content-type' : 'application/json'
                              },
                             body: {
                               "Img":"test",
                               "ProductCode":"2345",
                               "ProductName":"molbon",
                               "Qty":"5655",
                               "TotalPrice":"56789",
                               "UnitPrice":"445"
                             });
                         print(response.statusCode);
                         print(response.body);
                        }
                      },
                      child: const Text("Add")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
