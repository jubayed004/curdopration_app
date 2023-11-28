import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({Key? key}) : super(key: key);

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {

  bool isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _productCodeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  void addProduct() async {
    isLoading = true;
    setState(() {
    });
    Response response = await post(
        Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct"),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          "Img": _imageController.text.trim(),
          "ProductCode": _productCodeController.text.trim(),
          "ProductName": _nameController.text.trim(),
          "Qty": _quantityController.text.trim(),
          "TotalPrice": _totalPriceController.text.trim(),
          "UnitPrice": _priceController.text.trim()
        }));
    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body);
      if (decodedBody['status'] == 'success') {
        isLoading = false;
        if (mounted) {
          setState(() {

          });
          _imageController.clear();
          _productCodeController.clear();
          _priceController.clear();
          _totalPriceController.clear();
          _quantityController.clear();
          _nameController.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("New Product Add Success"),
          ));
        }
      } else {
        if (mounted) {

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("New Product failed. Try Again!"),
          ));
        }
      }
    }
  }
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
                      return "Enter your Price";
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
                      return "Enter your Product Code";
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
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter your Quantity";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                    controller: _totalPriceController,
                    decoration: const InputDecoration(
                      labelText: ' Total Price',
                    ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter your Total Price ";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                    controller: _imageController,
                    decoration: const InputDecoration(
                      labelText: 'image',
                    ),
                  validator: (String? value){
                      if(value?.isEmpty?? true){
                      return ("Enter Your Image");
                      }
                      return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: isLoading?const Center(child: CircularProgressIndicator(),):ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async {
                        if (_formState.currentState!.validate()) {
                          addProduct();
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
