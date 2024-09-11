
import 'dart:io';

import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_editing_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klontong/domain/entities/products_entity.dart';
import 'package:klontong/domain/usecase/products/find_one_product_usecase.dart';
import 'package:klontong/domain/usecase/products/get_product_usecase.dart';
import 'package:klontong/domain/usecase/products/upsert_product_usecase.dart';
import 'package:klontong/presentation/pages/products/widgets/camera.dart';
import 'package:klontong/presentation/routes/routes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProductNotifier extends ChangeNotifier {
  final GetProductUseCase getProductUseCase;
  final UpsertProductUseCase upsertProductUseCase;
  final FindOneProductUseCase findOneProductUseCase;
  ProductNotifier({required this.getProductUseCase, required this.upsertProductUseCase, required this.findOneProductUseCase});
  GlobalKey<FormState> formProductInKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController btnSubmitController =
      RoundedLoadingButtonController();

  final TextEditingController textSearchController = TextEditingController();
  FocusNode focusSearch = FocusNode();
  bool _isloading = false;
  bool get isloading => _isloading;
  set isloading(bool val){
    _isloading = val;
    notifyListeners();
  }

  int _page = 1;
  int get page => _page;
  set page(int val){
    _page = val;
    notifyListeners();
  }

  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;
  set isLastPage(bool val){
    _isLastPage = val;
    notifyListeners();
  }

  bool _isloadmore = false;
  bool get isloadmore => _isloadmore;
  set isloadmore(bool val){
    _isloadmore = val;
    notifyListeners();
  }

  String _params = '';
  String get params => _params;
  set params(String val){
    _params = val;
    notifyListeners();
  }

  List<ResultProductsEntity> _products = [];
  List<ResultProductsEntity> get products => _products;
  set products(List<ResultProductsEntity> val) {
    _products = val;
    notifyListeners();
  }

  ResultProductsEntity? _product;
  ResultProductsEntity? get product => _product;
  set product(ResultProductsEntity? val) {
    _product = val;
    notifyListeners();
  }

  Future<void> getProducts() async {
    isloading = true;
    products.clear();
    try{
      var res = await getProductUseCase.call(params: params);
      if (res.error == null){
        for (var e in res.data??[]) {
          products.add(e);
        }
        isloading = false;
      }else{
        isloading = false;
      }
    }catch(_){
      isloading = false;
    }
  }

  Future<void> findOneProduct() async {
    isloading = true;
    try{
      var res = await findOneProductUseCase.call(params: product?.id??'');
      product = res;
      isloading = false;
    }catch(_){
      isloading = false;
    }
  }

  void getLoadMore(BuildContext context, mounted) async {
    try{
      var res = await getProductUseCase.call(params: params );
      if (res.error == null){
        if (res.data?.isNotEmpty??false){
          for (var e in res.data??[]) {
            products.add(e);
          }
          isLastPage = false;
        }else{
          isLastPage = true;
        }
      }
    }catch(_){
      isLastPage = true;
    }
  }

  String? _image = '';
  String? get image => _image;
  set image(String? val){
    _image = val;
    notifyListeners();
  }

  final ImagePicker picker = ImagePicker();

  void showDialogPost(BuildContext context, mounted) async {
    await showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <Widget>[
        Material(
            child: Column(
          children: [
            InkWell(
              onTap: () async {
                if (await Permission.camera.request().isGranted){
                  if (!mounted) return;
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> const CameraWidget(profile: false,)));
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Camera",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16),
                    ),
                    Icon(CupertinoIcons.photo_camera,),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                XFile? ximage = await picker.pickImage(source: ImageSource.gallery);
                if (ximage != null){
                  File file = File(ximage.path);
                  if (!mounted) return;
                  Navigator.pop(context);

                  image = file.path;

                  Navigator.pushNamed(
                    context,
                    Routes.productAddPage
                  );
                  
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Gallery",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Icon(CupertinoIcons.photo),
                  ],
                ),
              ),
            ),
          ],
        )),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          "Cancel",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 16),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    );
  }

  FocusNode captionFocus = FocusNode();

  final controller = DetectableTextEditingController(
      regExp: RegExp(
        "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
        multiLine: true,
      ),
      detectedStyle:
          const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold));

  final TextEditingController textNameController = TextEditingController();
  final TextEditingController textSkuController = TextEditingController();
  final TextEditingController textweightController = TextEditingController();
  final TextEditingController textwitdhController = TextEditingController();
  final TextEditingController textheightController = TextEditingController();
  final TextEditingController textlengthController = TextEditingController();
  final TextEditingController textpriceController = TextEditingController();

  Future<void> submited(BuildContext context, mounted,{String? category}) async{
    try{
      Map map = {
        'category': category,
        'sku': textSkuController.text,
        'name': textNameController.text,
        'description': controller.text,
        'weight': textweightController.text,
        'width': textwitdhController.text,
        'length': textlengthController.text,
        'height': textheightController.text,
        'price': textpriceController.text,
        'image': image
      };
      var res = await upsertProductUseCase.call(map: map);
      if (res.error == null){
        btnSubmitController.reset();
        if (!mounted) return;
        print(res);
        Navigator.pop(context);
        clearController();
        getProductFindOne(context, mounted, id: res.data);
      }else{
        btnSubmitController.reset();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 150,
            left: 10,
            right: 10),

            showCloseIcon: true,
            closeIconColor: Colors.white,
            backgroundColor: Colors.red.shade300,
            content: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.white,),
                const SizedBox(width: 12.0,),
                Text(res.message??''),
              ],
            ))
        );
      }
    }catch(_){
      btnSubmitController.reset();
    }
  }

  void clearController() {
    textSkuController.clear();
    textNameController.clear();
    controller.clear();
    textweightController.clear();
    textwitdhController.clear();
    textlengthController.clear();
    textpriceController.clear();
    textheightController.clear();
  }

  Future<void> getProductFindOne(BuildContext context, mounted, {String? id}) async {
    isloading = false;
    try{
      var res = await findOneProductUseCase.call(params: id);
      products.insert(0, res);
      isloading = false;
    }catch(_){
      isloading = false;
      debugPrint(_.toString());
    }
  }
}