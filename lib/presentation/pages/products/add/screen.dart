import 'dart:io';

import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:klontong/presentation/provider/category/notifier.dart';
import 'package:klontong/presentation/provider/product/notifier.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Add New Product'),
      ),
      body: Consumer2<ProductNotifier, CategoryNotifier>(
        builder: (context, value, cat, child) {
          return SingleChildScrollView(
            child: Form(
              key: value.formProductInKey,
              child: Column(
                children: [
                  Image.file(
                    File(value.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'SKU Product is required')
                      ]),
                      controller: value.textSkuController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Add SKU",
                        labelText: "SKU",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Product Name is required')
                      ]),
                      controller: value.textNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Add Product Name",
                        labelText: "Product Name",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: DetectableTextField(
                      controller: value.controller,
                      focusNode: value.captionFocus,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: 'Description',
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      maxLines: 5,
                      maxLength: 1000,
                    ),
                  ),
                  ListTile(
                    minLeadingWidth: 0,
                    visualDensity: const VisualDensity(vertical: -3),
                    title: Text(
                      cat.categorySelected == null
                          ? 'Select Category'
                          : 'Category',
                      style: const TextStyle(fontSize: 14),
                    ),
                    subtitle: cat.categorySelected == null
                        ? SizedBox.fromSize()
                        : Text(
                            cat.categorySelected?.name ?? ' -- ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                    trailing: cat.categorySelected == null
                        ? const Icon(Icons.arrow_forward_ios_rounded)
                        : IconButton(
                            onPressed: () {
                              cat.categorySelected = null;
                            },
                            icon: const Icon(Icons.close)),
                    onTap: () {
                      if (cat.categories.isEmpty) {
                        cat.getCategories();
                      }
                      cat.showButtomSheetCategories(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: SizedBox(
                      height: kToolbarHeight,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: kToolbarHeight,
                            width: MediaQuery.of(context).size.width * .4,
                            child: TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Weight Product is required')
                              ]),
                              controller: value.textweightController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Add Weight roduct",
                                labelText: "Weight product",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: kToolbarHeight,
                            width: MediaQuery.of(context).size.width * .4,
                            child: TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Width product is required')
                              ]),
                              controller: value.textwitdhController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Add Width",
                                labelText: "Width product",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: SizedBox(
                      height: kToolbarHeight,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: kToolbarHeight,
                            width: MediaQuery.of(context).size.width * .4,
                            child: TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Length Product is required')
                              ]),
                              controller: value.textlengthController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Add Length roduct",
                                labelText: "Length product",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: kToolbarHeight,
                            width: MediaQuery.of(context).size.width * .4,
                            child: TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Height product is required')
                              ]),
                              controller: value.textheightController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Add Height",
                                labelText: "Height product",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Price Product is required')
                      ]),
                      controller: value.textpriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Add Price",
                        labelText: "Price",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RoundedLoadingButton(
                      animateOnTap: true,
                      errorColor: Colors.red.shade200,
                      controller: value.btnSubmitController,
                      onPressed: () async {
                        if (!context.mounted) return;

                        FocusScope.of(context).unfocus();
                        if (value.formProductInKey.currentState!.validate()) {
                          if (cat.categorySelected == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                dismissDirection: DismissDirection.up,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).size.height - 150,
                                    left: 10,
                                    right: 10),
                                showCloseIcon: true,
                                closeIconColor: Colors.white,
                                backgroundColor: Colors.red.shade300,
                                content: const Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Text(
                                        'Selected Category Product'),
                                  ],
                                )));
                            value.btnSubmitController.reset();
                          } else if (value.controller.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                dismissDirection: DismissDirection.up,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).size.height - 150,
                                    left: 10,
                                    right: 10),
                                showCloseIcon: true,
                                closeIconColor: Colors.white,
                                backgroundColor: Colors.red.shade300,
                                content: const Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Text('Description product is required'),
                                  ],
                                ),),);
                            value.btnSubmitController.reset();
                          }else{
                            //ok
                            value.submited(context, mounted, category: cat.categorySelected?.id??'');
                          }
                        } else {
                          value.btnSubmitController.error();
                          Future.delayed(const Duration(milliseconds: 500), () {
                            value.btnSubmitController.reset();
                          });
                        }
                      },
                      borderRadius: 8,
                      elevation: 0,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue,
                      child: Text(
                        'Posting',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
