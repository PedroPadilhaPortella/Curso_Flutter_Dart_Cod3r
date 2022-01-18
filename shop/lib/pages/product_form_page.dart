import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  void submitForm() {
    _formKey.currentState?.save();
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      name: _formData['name'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Produto"),
        actions: [
          IconButton(onPressed: submitForm, icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: "Nome"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocus),
                onSaved: (name) => _formData['name'] = name ?? '',
              ),
              TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: "Preço"),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocus),
                onSaved: (price) =>
                    _formData['price'] = double.parse(price ?? '0'),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Descrição"),
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocus,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_imageUrlFocus),
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.url,
                      decoration:
                          const InputDecoration(labelText: "Url da Imagem"),
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocus,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => submitForm(),
                      onSaved: (imageUrl) =>
                          _formData['imageUrl'] = imageUrl ?? '',
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text("Informe a Url")
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(_imageUrlController.text),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
