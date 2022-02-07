import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

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

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final argument = ModalRoute.of(context)?.settings.arguments;

      if (argument != null) {
        final product = argument as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;
        _imageUrlController.text = product.imageUrl;
      }
    }
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

  Future<void> submitForm() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<ProductList>(context, listen: false)
          .saveProduct(_formData);
      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Ocorreu um erro."),
                content: const Text("Ocorreu um erro ao salvar o produto."),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Ok"))
                ],
              ));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.webp') ||
        url.toLowerCase().endsWith('.svg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: _formData['name']?.toString(),
                      decoration: const InputDecoration(labelText: "Nome"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_priceFocus),
                      onSaved: (name) => _formData['name'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';
                        if (name.trim().isEmpty) return "Nome é obrigatório";
                        if (name.trim().length <= 3) {
                          return "Nome precisa ter no mínimo 3 caracteres";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      initialValue: _formData['price']?.toString(),
                      decoration: const InputDecoration(labelText: "Preço"),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_descriptionFocus),
                      validator: (_price) {
                        final price = double.tryParse(_price ?? '') ?? -1;
                        if (price <= 0) {
                          return "Informe um preço válido";
                        }
                        return null;
                      },
                      onSaved: (price) =>
                          _formData['price'] = double.parse(price ?? '0'),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      initialValue: _formData['description']?.toString(),
                      maxLines: 3,
                      decoration: const InputDecoration(labelText: "Descrição"),
                      textInputAction: TextInputAction.next,
                      focusNode: _descriptionFocus,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_imageUrlFocus),
                      validator: (_description) {
                        final description = _description ?? '';
                        if (description.trim().isEmpty) {
                          return "Descrição é obrigatório";
                        }
                        if (description.trim().length <= 8) {
                          return "Descrição precisa ter no mínimo 8 caracteres";
                        }
                        return null;
                      },
                      onSaved: (description) =>
                          _formData['description'] = description ?? '',
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.url,
                            decoration: const InputDecoration(
                                labelText: "Url da Imagem"),
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocus,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) => submitForm(),
                            validator: (_url) {
                              final url = _url ?? '';
                              if (!isValidImageUrl(url)) {
                                return "Informe uma url válida";
                              }
                              return null;
                            },
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
                              : Image.network(_imageUrlController.text),
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
