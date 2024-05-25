import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/apis/ApiStore.dart';
import 'package:snab_budget/apis/controller/transaction_controller.dart';
import 'package:snab_budget/apis/model/get_categories_model.dart';
import 'package:snab_budget/apis/model/user_category_model.dart';
import 'package:snab_budget/models/income_catagery._model.dart';
import 'package:snab_budget/static_data.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import 'package:snab_budget/utils/daimond_shape.dart';
import 'package:uuid/uuid.dart';

import '../../utils/apptheme.dart';

class AddBudget extends StatefulWidget {
  const AddBudget({super.key});

  @override
  State<AddBudget> createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  var height, width;
  bool isLoading = false;

  TextEditingController amountTextController = TextEditingController();
  String selectedDuration = '1 Week';

  final storage = FirebaseStorage.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  int? clicktile;
  List<SubCatagoriesModel> dummysubcatagorylist = [];
  List<SubCatagoriesModel> subcatagorylistview = [];
  String? getimage;
  String? selectedcatId;
  UserCategoryModel? selectedCatagorymodel;
  String? selectcatagorytital;
  String? selectcatagoryurl;
  String? selectedcat;
  bool opencatagoryclick = false;
  final TextEditingController subcatagorycontroller = TextEditingController();
  String? maingetimage;
  final TextEditingController controller = TextEditingController();
  // final String userId = FirebaseAuth.instance.currentUser!.uid;
  GetCategoriesModel? model;

  final List<String> dropdownItems = [
    '1 Week',
    '1 Month',
    '1 Year',
    'Other',
  ];

  @override
  void initState() {
    // adddCatagoriesdata();
    super.initState();
  }

  // void adddCatagoriesdata() async {
  //   for (var u in ExpenceDataCategory.expenceCategories) {
  //     await firebaseFirestore
  //         .collection("catagories")
  //         .doc(userId)
  //         .collection("addExpancecatagories")
  //         .doc(u.id)
  //         .set({
  //       "name": u.name,
  //       "image": u.image,
  //       "id": u.id,
  //       "subcatagories": null,
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Consumer<BrightnessProvider>(builder: (context, provider, _) {
          return SizedBox(
            height: height,
            width: width * 0.9,
            child: Column(
              children: [
                Container(
                  width: width * 0.9,
                  height: height * 0.13,
                  decoration: BoxDecoration(
                    color: AppTheme.colorPrimary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: width * 0.065,
                          )),
                      Text(
                        AppLocalizations.of(context)!.budget,
                        style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: width * 0.045,
                      )
                    ],
                  ),
                ),
                GetBuilder<TransactionController>(builder: (obj) {
                  return ListTile(
                    onTap: () {
                      clicktile = null;
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(builder: (context, state) {
                              return AlertDialog(
                                elevation: 10,
                                shadowColor: AppTheme.colorPrimary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .selectcategory,
                                      style: TextStyle(
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.bold,
                                        color: provider.brightness ==
                                                AppBrightness.dark
                                            ? AppTheme.colorWhite
                                            : AppTheme.colorPrimary,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: height * 0.04,
                                        width: width * 0.08,
                                        decoration: BoxDecoration(
                                            color: AppTheme.colorPrimary,
                                            shape: BoxShape.circle),
                                        child: const Center(
                                          child: Icon(
                                            Icons.clear,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                content: SizedBox(
                                  height: height * 0.8,
                                  width: width,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: obj.model == null
                                            ? Center(
                                                child: SpinKitCircle(
                                                  color: AppTheme.colorPrimary,
                                                  size: 50.0,
                                                ),
                                              )
                                            : ListView.builder(
                                                itemCount:
                                                    obj.model!.data!.length,
                                                itemBuilder: (context, index) {
                                                  return clicktile == index &&
                                                          clicktile != null &&
                                                          opencatagoryclick ==
                                                              true
                                                      ? Column(children: [
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                selectcatagorytital =
                                                                    obj
                                                                        .model!
                                                                        .data![
                                                                            index]
                                                                        .name;
                                                                selectedcatId = obj
                                                                    .model!
                                                                    .data![
                                                                        index]
                                                                    .categoryId;
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: ListTile(
                                                              trailing:
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        state(
                                                                            () {
                                                                          clicktile =
                                                                              index;
                                                                          opencatagoryclick =
                                                                              !opencatagoryclick;
                                                                        });
                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        clicktile == index &&
                                                                                clicktile != null
                                                                            ? Icons.arrow_drop_down_outlined
                                                                            : Icons.arrow_drop_up_outlined,
                                                                        color: AppTheme
                                                                            .colorPrimary,
                                                                      )),
                                                              leading:
                                                                  Container(
                                                                height: height *
                                                                    0.05,
                                                                width:
                                                                    width * 0.1,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Image(
                                                                    image: AssetImage(obj
                                                                        .model!
                                                                        .data![
                                                                            index]
                                                                        .imageUrl!),
                                                                  ),
                                                                ),
                                                              ),
                                                              title: Text(
                                                                obj
                                                                    .model!
                                                                    .data![
                                                                        index]
                                                                    .name!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.03,
                                                                    color: provider.brightness ==
                                                                            AppBrightness
                                                                                .dark
                                                                        ? AppTheme
                                                                            .colorWhite
                                                                        : AppTheme
                                                                            .colorPrimary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            obj
                                                                    .model!
                                                                    .data![
                                                                        index]
                                                                    .child!
                                                                    .isEmpty
                                                                ? AppLocalizations.of(
                                                                        context)!
                                                                    .nosubcategory
                                                                : "${AppLocalizations.of(context)!.subcatagoriesof}${obj.model!.data![index].name!}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: height *
                                                                0.1 *
                                                                obj
                                                                    .model!
                                                                    .data![
                                                                        index]
                                                                    .child!
                                                                    .length,
                                                            child: ListView
                                                                .builder(
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              itemCount: obj
                                                                  .model!
                                                                  .data![index]
                                                                  .child!
                                                                  .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int i) {
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      ListTile(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        selectcatagorytital = obj
                                                                            .model!
                                                                            .data![index]
                                                                            .child![i]
                                                                            .name;
                                                                        selectedcatId = obj
                                                                            .model!
                                                                            .data![index]
                                                                            .child![i]
                                                                            .categoryId;
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    leading:
                                                                        Container(
                                                                      height:
                                                                          height *
                                                                              0.05,
                                                                      width:
                                                                          width *
                                                                              0.1,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Image(
                                                                          image:
                                                                              AssetImage(
                                                                            obj.model!.data![index].child![i].imageUrl!,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    title: Text(
                                                                      obj
                                                                          .model!
                                                                          .data![
                                                                              index]
                                                                          .child![
                                                                              i]
                                                                          .name!,
                                                                      style: TextStyle(
                                                                          fontSize: width *
                                                                              0.03,
                                                                          color: provider.brightness == AppBrightness.dark
                                                                              ? AppTheme.colorWhite
                                                                              : AppTheme.colorPrimary,
                                                                          fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        ])
                                                      : ListTile(
                                                          onTap: () {
                                                            setState(() {
                                                              selectcatagorytital =
                                                                  obj
                                                                      .model!
                                                                      .data![
                                                                          index]
                                                                      .name;
                                                              selectedcatId = obj
                                                                  .model!
                                                                  .data![index]
                                                                  .categoryId;
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          trailing: IconButton(
                                                              onPressed: () {
                                                                state(() {
                                                                  clicktile =
                                                                      index;
                                                                  opencatagoryclick =
                                                                      !opencatagoryclick;
                                                                });
                                                                setState(() {});
                                                              },
                                                              icon: Icon(
                                                                clicktile ==
                                                                            index &&
                                                                        clicktile !=
                                                                            null
                                                                    ? Icons
                                                                        .arrow_drop_down_outlined
                                                                    : Icons
                                                                        .arrow_drop_up_outlined,
                                                                color: provider
                                                                            .brightness ==
                                                                        AppBrightness
                                                                            .dark
                                                                    ? AppTheme
                                                                        .colorWhite
                                                                    : AppTheme
                                                                        .colorPrimary,
                                                              )),
                                                          leading: Container(
                                                            height:
                                                                height * 0.05,
                                                            width: width * 0.1,
                                                            decoration:
                                                                const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Image(
                                                                image: AssetImage(obj
                                                                    .model!
                                                                    .data![
                                                                        index]
                                                                    .imageUrl!),
                                                              ),
                                                            ),
                                                          ),
                                                          title: Text(
                                                            obj
                                                                .model!
                                                                .data![index]
                                                                .name!,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.03,
                                                                color: provider
                                                                            .brightness ==
                                                                        AppBrightness
                                                                            .dark
                                                                    ? AppTheme
                                                                        .colorWhite
                                                                    : AppTheme
                                                                        .colorPrimary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        );
                                                },
                                              ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            getimage = null;
                                            isLoading = false;
                                            subcatagorycontroller.text = "";
                                          });

                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return StatefulBuilder(
                                                    builder: (context, set) {
                                                  return SingleChildScrollView(
                                                    child: AlertDialog(
                                                      elevation: 10,
                                                      shadowColor:
                                                          AppTheme.colorPrimary,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .newsubcategory,
                                                            style: TextStyle(
                                                              fontSize:
                                                                  width * 0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: provider
                                                                          .brightness ==
                                                                      AppBrightness
                                                                          .dark
                                                                  ? AppTheme
                                                                      .colorWhite
                                                                  : AppTheme
                                                                      .colorPrimary,
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Container(
                                                              height:
                                                                  height * 0.04,
                                                              width:
                                                                  width * 0.08,
                                                              decoration: BoxDecoration(
                                                                  color: AppTheme
                                                                      .colorPrimary,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                  Icons.clear,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      content: Stack(
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                height * 0.8,
                                                            width: width,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.08,
                                                                  width: width,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        '${AppLocalizations.of(context)!.name} :',
                                                                        style: TextStyle(
                                                                            fontSize: width *
                                                                                0.03,
                                                                            color: provider.brightness == AppBrightness.dark
                                                                                ? AppTheme.colorWhite
                                                                                : AppTheme.colorPrimary,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.3,
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              subcatagorycontroller,
                                                                          decoration:
                                                                              const InputDecoration(
                                                                            hintText:
                                                                                "...",
                                                                            hintStyle:
                                                                                TextStyle(color: Colors.black),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.08,
                                                                  width: width,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        AppLocalizations.of(context)!
                                                                            .maincategory,
                                                                        style: TextStyle(
                                                                            fontSize: width *
                                                                                0.03,
                                                                            color: provider.brightness == AppBrightness.dark
                                                                                ? AppTheme.colorWhite
                                                                                : AppTheme.colorPrimary,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          ////////// selection
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return StatefulBuilder(builder: (context, setstateee) {
                                                                                  return SingleChildScrollView(
                                                                                    child: AlertDialog(
                                                                                        elevation: 10,
                                                                                        shadowColor: AppTheme.colorPrimary,
                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                        title: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                                                            Text(
                                                                                              AppLocalizations.of(context)!.selectcategory,
                                                                                              style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                                            ),
                                                                                            InkWell(
                                                                                              onTap: () {
                                                                                                Navigator.pop(context);
                                                                                              },
                                                                                              child: Container(
                                                                                                height: height * 0.04,
                                                                                                width: width * 0.08,
                                                                                                decoration: BoxDecoration(color: AppTheme.colorPrimary, shape: BoxShape.circle),
                                                                                                child: const Center(
                                                                                                  child: Icon(
                                                                                                    Icons.clear,
                                                                                                    size: 15,
                                                                                                    color: Colors.white,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                        content: SizedBox(
                                                                                          height: height * 0.8,
                                                                                          width: width,
                                                                                          child: ListView.builder(
                                                                                              itemCount: obj.model!.data!.length,
                                                                                              itemBuilder: (context, index) {
                                                                                                return Padding(
                                                                                                  padding: EdgeInsets.symmetric(
                                                                                                    vertical: height * 0.01,
                                                                                                  ),
                                                                                                  child: InkWell(
                                                                                                    onTap: () {
                                                                                                      set(() {
                                                                                                        setstateee(() {
                                                                                                          selectedcat = obj.model!.data![index].name!;
                                                                                                          selectedcatId = obj.model!.data![index].categoryId!;
                                                                                                        });
                                                                                                      });

                                                                                                      Navigator.pop(context);
                                                                                                    },
                                                                                                    child: ListTile(
                                                                                                      leading: Container(
                                                                                                        height: height * 0.05,
                                                                                                        width: width * 0.1,
                                                                                                        decoration: const BoxDecoration(
                                                                                                          shape: BoxShape.circle,
                                                                                                        ),
                                                                                                        child: Padding(
                                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                                          child: Image(
                                                                                                            image: AssetImage(
                                                                                                              obj.model!.data![index].imageUrl!,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      title: Text(
                                                                                                        obj.model!.data![index].name!,
                                                                                                        style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                              }),
                                                                                        )),
                                                                                  );
                                                                                });
                                                                              });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.4),
                                                                          height:
                                                                              height * 0.05,
                                                                          width:
                                                                              width * 0.33,
                                                                          child: Center(
                                                                              child: Text(
                                                                            selectedcat == null
                                                                                ? AppLocalizations.of(context)!.selectcategory
                                                                                : selectedcat!,
                                                                            style: TextStyle(
                                                                                fontSize: width * 0.03,
                                                                                color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary,
                                                                                fontWeight: FontWeight.bold),
                                                                          )),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.02,
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.08,
                                                                  width: width,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        '${AppLocalizations.of(context)!.picture} :',
                                                                        style: TextStyle(
                                                                            fontSize: width *
                                                                                0.03,
                                                                            color: provider.brightness == AppBrightness.dark
                                                                                ? AppTheme.colorWhite
                                                                                : AppTheme.colorPrimary,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      getimage ==
                                                                              null
                                                                          ? const CircleAvatar(
                                                                              radius: 20,
                                                                              backgroundColor: Colors.grey,
                                                                            )
                                                                          : Container(
                                                                              height: height * 0.05,
                                                                              width: width * 0.1,
                                                                              decoration: const BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                color: Colors.grey,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Image(
                                                                                  image: AssetImage(getimage!),
                                                                                ),
                                                                              ),
                                                                            )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.02,
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      height *
                                                                          0.45,
                                                                  width: width,
                                                                  child: Center(
                                                                    child: GridView
                                                                        .builder(
                                                                      gridDelegate:
                                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                                        crossAxisCount:
                                                                            5,
                                                                        mainAxisSpacing:
                                                                            20.0,
                                                                        crossAxisSpacing:
                                                                            20.0,
                                                                      ),
                                                                      itemCount:
                                                                          iconList
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            set(() {
                                                                              getimage = iconList[index];
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                height * 0.05,
                                                                            width:
                                                                                width * 0.1,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Image(
                                                                                image: AssetImage(iconList[index]),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        set(() {
                                                                          getimage =
                                                                              null;
                                                                        });
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height: height *
                                                                            0.05,
                                                                        width: width *
                                                                            0.3,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                AppTheme.colorPrimary,
                                                                            borderRadius: BorderRadius.circular(7)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.cancel,
                                                                            style: TextStyle(
                                                                                fontSize: width * 0.03,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        if (getimage !=
                                                                                null &&
                                                                            subcatagorycontroller.text.isNotEmpty) {
                                                                          selectedCatagorymodel = UserCategoryModel(
                                                                              parentId: selectedcatId,
                                                                              imageUrl: getimage,
                                                                              name: subcatagorycontroller.text,
                                                                              type: "income");
                                                                          TransactionController
                                                                              .to
                                                                              .adddCatagoriesdata(selectedCatagorymodel!);

                                                                          Navigator.pop(
                                                                              context);
                                                                        } else {
                                                                          showtoast(
                                                                              "${AppLocalizations.of(context)!.pleasefullfillallfields}");
                                                                        }
                                                                        getimage =
                                                                            null;
                                                                        subcatagorycontroller.text =
                                                                            "";
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height: height *
                                                                            0.05,
                                                                        width: width *
                                                                            0.3,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                AppTheme.colorPrimary,
                                                                            borderRadius: BorderRadius.circular(7)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.save,
                                                                            style: TextStyle(
                                                                                fontSize: width * 0.03,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                              });
                                        },
                                        child: Container(
                                          height: height * 0.05,
                                          width: width * 0.4,
                                          decoration: BoxDecoration(
                                              color: AppTheme.colorPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .newsubcategory,
                                              style: TextStyle(
                                                  fontSize: width * 0.03,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(builder:
                                                  (context, setstateee) {
                                                return AlertDialog(
                                                  elevation: 10,
                                                  shadowColor:
                                                      AppTheme.colorPrimary,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .categorymanagement,
                                                        style: TextStyle(
                                                          fontSize:
                                                              width * 0.035,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: provider.brightness ==
                                                                  AppBrightness
                                                                      .dark
                                                              ? AppTheme
                                                                  .colorWhite
                                                              : AppTheme
                                                                  .colorPrimary,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: height * 0.04,
                                                          width: width * 0.08,
                                                          decoration: BoxDecoration(
                                                              color: AppTheme
                                                                  .colorPrimary,
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.clear,
                                                              size: 15,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  content: SizedBox(
                                                    height: height * 0.8,
                                                    width: width,
                                                    child: ListView.builder(
                                                        itemCount: obj.model!
                                                            .data!.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              vertical:
                                                                  height * 0.01,
                                                            ),
                                                            child: ListTile(
                                                              leading:
                                                                  Container(
                                                                height: height *
                                                                    0.05,
                                                                width:
                                                                    width * 0.1,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Image(
                                                                    image:
                                                                        AssetImage(
                                                                      obj
                                                                          .model!
                                                                          .data![
                                                                              index]
                                                                          .imageUrl!,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              title: Text(
                                                                obj
                                                                    .model!
                                                                    .data![
                                                                        index]
                                                                    .name!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.03,
                                                                    color: provider.brightness ==
                                                                            AppBrightness
                                                                                .dark
                                                                        ? AppTheme
                                                                            .colorWhite
                                                                        : AppTheme
                                                                            .colorPrimary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              trailing: InkWell(
                                                                  onTap: () {
                                                                    TransactionController.to.deleteCatagoriesdata(
                                                                        obj
                                                                            .model!
                                                                            .data![index]
                                                                            .categoryId!,
                                                                        "income");
                                                                  },
                                                                  child: const Icon(
                                                                      Icons
                                                                          .delete)),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                  actions: <Widget>[
                                                    FloatingActionButton(
                                                      shape:
                                                          const DiamondBorder(),
                                                      backgroundColor:
                                                          AppTheme.colorPrimary,
                                                      onPressed: () {
                                                        controller.text = '';
                                                        maingetimage == null;
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return StatefulBuilder(
                                                                  builder:
                                                                      (context,
                                                                          set) {
                                                                return SingleChildScrollView(
                                                                  child:
                                                                      AlertDialog(
                                                                    elevation:
                                                                        10,
                                                                    shadowColor:
                                                                        AppTheme
                                                                            .colorPrimary,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    title: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          AppLocalizations.of(context)!
                                                                              .addcatagory,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                width * 0.035,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: provider.brightness == AppBrightness.dark
                                                                                ? AppTheme.colorWhite
                                                                                : AppTheme.colorPrimary,
                                                                          ),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                height * 0.04,
                                                                            width:
                                                                                width * 0.08,
                                                                            decoration:
                                                                                BoxDecoration(color: AppTheme.colorPrimary, shape: BoxShape.circle),
                                                                            child:
                                                                                const Center(
                                                                              child: Icon(
                                                                                Icons.clear,
                                                                                size: 15,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    content:
                                                                        SizedBox(
                                                                      height:
                                                                          height *
                                                                              0.8,
                                                                      width:
                                                                          width,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                height * 0.08,
                                                                            width:
                                                                                width,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  '${AppLocalizations.of(context)!.name} :',
                                                                                  style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: width * 0.3,
                                                                                  child: TextFormField(
                                                                                    controller: controller,
                                                                                    decoration: const InputDecoration(
                                                                                      hintText: "...",
                                                                                      hintStyle: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                height * 0.08,
                                                                            width:
                                                                                width,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  '${AppLocalizations.of(context)!.picture} :',
                                                                                  style: TextStyle(fontSize: width * 0.03, color: provider.brightness == AppBrightness.dark ? AppTheme.colorWhite : AppTheme.colorPrimary, fontWeight: FontWeight.bold),
                                                                                ),
                                                                                maingetimage == null
                                                                                    ? const CircleAvatar(
                                                                                        radius: 50,
                                                                                        backgroundColor: Colors.grey,
                                                                                      )
                                                                                    : Container(
                                                                                        height: height * 0.08,
                                                                                        width: width * 0.16,
                                                                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Image(
                                                                                            image: AssetImage(maingetimage!),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                height * 0.02,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                height * 0.45,
                                                                            width:
                                                                                width,
                                                                            child:
                                                                                Center(
                                                                              child: GridView.builder(
                                                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                                  crossAxisCount: 5,
                                                                                  mainAxisSpacing: 20.0,
                                                                                  crossAxisSpacing: 20.0,
                                                                                ),
                                                                                itemCount: iconList.length, // Number of grid items
                                                                                itemBuilder: (context, index) {
                                                                                  return InkWell(
                                                                                      onTap: () {
                                                                                        set(() {
                                                                                          maingetimage = iconList[index];
                                                                                        });
                                                                                      },
                                                                                      child: Container(
                                                                                        height: height * 0.05,
                                                                                        width: width * 0.1,
                                                                                        decoration: const BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Image(
                                                                                            image: AssetImage(iconList[index]),
                                                                                          ),
                                                                                        ),
                                                                                      ));
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  set(() {
                                                                                    maingetimage = null;
                                                                                    Navigator.pop(context);
                                                                                  });
                                                                                },
                                                                                child: Container(
                                                                                  height: height * 0.05,
                                                                                  width: width * 0.3,
                                                                                  decoration: BoxDecoration(color: AppTheme.colorPrimary, borderRadius: BorderRadius.circular(7)),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      AppLocalizations.of(context)!.cancel,
                                                                                      style: TextStyle(fontSize: width * 0.03, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  UserCategoryModel model = UserCategoryModel(parentId: null, imageUrl: maingetimage, name: controller.text, type: "income");
                                                                                  TransactionController.to.adddCatagoriesdata(model);

                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Container(
                                                                                  height: height * 0.05,
                                                                                  width: width * 0.3,
                                                                                  decoration: BoxDecoration(color: AppTheme.colorPrimary, borderRadius: BorderRadius.circular(7)),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      AppLocalizations.of(context)!.save,
                                                                                      style: TextStyle(fontSize: width * 0.03, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                            });
                                                      },
                                                      child: const Text(
                                                        "+",
                                                        style: TextStyle(
                                                            fontSize: 40),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              });
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: height * 0.05,
                                          width: width * 0.5,
                                          decoration: BoxDecoration(
                                              color: AppTheme.colorPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .categorymanagement,
                                              style: TextStyle(
                                                  fontSize: width * 0.03,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          });
                    },
                    title: Text(
                      selectcatagorytital ??
                          AppLocalizations.of(context)!.selectcategory,
                      style: TextStyle(
                        fontSize: width * 0.035,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      color: provider.brightness == AppBrightness.dark
                          ? AppTheme.colorWhite
                          : AppTheme.colorPrimary,
                    ),
                  );
                }),
                Padding(
                  padding: EdgeInsets.all(width * 0.05),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        AppLocalizations.of(context)!.amount,
                        style: const TextStyle(fontSize: 16),
                      )),
                      Expanded(
                        child: SizedBox(
                          height: 35,
                          child: TextFormField(
                            controller: amountTextController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 0, 10, 10),
                              hintText: '0,000',
                              hintStyle: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(width * 0.05),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        AppLocalizations.of(context)!.duration,
                        style: TextStyle(fontSize: width * 0.03),
                      )),
                      Expanded(
                          child: DropdownButtonFormField<String>(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: provider.brightness == AppBrightness.dark
                                    ? Colors.white
                                    : AppTheme.colorPrimary,
                              ),
                              hint: Text(
                                AppLocalizations.of(context)!.select,
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: provider.brightness == AppBrightness.dark
                                    ? Colors.white
                                    : AppTheme.colorPrimary,
                              ),
                              isDense: true,
                              items: dropdownItems.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                selectedDuration = newValue!;
                              }))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.colorPrimary),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context)!.cancel)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.colorPrimary),
                          onPressed: () {
                            print("selectedcatId selectedcatId $selectedcatId");

                            saveBudget();
                          },
                          child:
                              Text(' ${AppLocalizations.of(context)!.save} '))
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  String dateString() {
    return '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  }

  // void postsubcatagories(List<SubCatagoriesModel> lissst) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   if (lissst.isNotEmpty) {
  //     SubCatagoriesModel? model;
  //     List<dynamic> dynamicList = [];
  //     for (int i = 0; i < lissst.length; i++) {
  //       model = lissst[i];
  //       var dynamicObj = {
  //         'name': model.name,
  //         'id': model.id,
  //         'image': model.image,
  //         'maincatagory': model.maincatagory,
  //         'maincatagoryId': model.maincatagoryId,
  //       };
  //       dynamicList.add(dynamicObj);
  //       setState(() {});
  //     }
  //     await firebaseFirestore
  //         .collection("catagories")
  //         .doc("userId")
  //         .collection("usercatagories")
  //         .doc(catagorymodel!.id)
  //         .update({'subcatagories': dynamicList});
  //     showtoast("added sucessfully");
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Navigator.pop(context);
  //   }
  // }

  Widget showspinkit(context) {
    var widget = Container(
      height: height,
      width: width,
      color: Colors.black.withOpacity(0.1),
      child: Center(
        child: SpinKitCircle(
          color: AppTheme.colorPrimary,
          size: 50.0,
        ),
      ),
    );
    return widget;
  }

  void showtoast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: AppTheme.colorPrimary,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: width * 0.03,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG);
  }

  void deletecatagory(String id) async {
    await firebaseFirestore
        .collection("catagories")
        .doc("userId")
        .collection("usercatagories")
        .doc(id)
        .delete();
    showtoast("delete sucessfully");
  }

  void postCatgoriestoDB() async {
    setState(() {
      isLoading = true;
    });
    if (controller.text.isNotEmpty && maingetimage != null) {
      String id = const Uuid().v4();

      ////// mainget image
      CatagoryModel model = CatagoryModel(
        id: id,
        name: controller.text,
        image: maingetimage,
        subcatagories: null,
      );
      await firebaseFirestore
          .collection("catagories")
          .doc("userId")
          .collection("usercatagories")
          .doc(id)
          .set(model.toMap());
      showtoast("Added succesfully");
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    } else {
      showtoast("give all fields");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future addbudget(
    Map<String, dynamic> data,
  ) async {
    var res = await httpClient().post(StaticValues.addBudgets, data: data);
    print("object  ${res.data}");
  }

  Future<void> saveBudget() async {
    // String id = const Uuid().v4();

    // BudgetModel model = BudgetModel(
    //   budgetID: id,
    //   ctagoryImage: selectcatagoryurl,
    //   ctagoryName: selectcatagorytital,
    //   budgetAmount: int.parse(amountTextController.text),
    //   duration: selectedDuration.toString(),
    //   date: dateString(),
    //   payableamount: 0,
    // );

    if (amountTextController.text.isNotEmpty && selectedcatId != null) {
      addbudget(
        {
          'amount': int.parse(amountTextController.text),
          'duration': selectedDuration.toString(),
          'categoryId': selectedcatId,
        },
      );
      showtoast("Added succesfully");
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    } else {
      showtoast("give all fields");
      setState(
        () {
          isLoading = false;
        },
      );
    }
  }

  List<String> iconList = [
    "assets/snabbicons/water  bill.png",
    "assets/snabbicons/shopping.png",
    "assets/snabbicons/tech.png",
    "assets/snabbicons/travel.png",
    "assets/snabbicons/rent.png",
    "assets/snabbicons/salary.png",
    "assets/snabbicons/rent.png",
    "assets/snabbicons/pet.png",
    "assets/snabbicons/personal savings.png",
    "assets/snabbicons/pension.png",
    "assets/snabbicons/others.png",
    "assets/snabbicons/clothing.png",
    "assets/snabbicons/children.png",
    "assets/snabbicons/others.png",
    "assets/snabbicons/entertainment.png",
    "assets/snabbicons/family.png",
    "assets/snabbicons/food drink.png",
    "assets/snabbicons/food drink(eating out).png",
    "assets/snabbicons/others.png",
    "assets/snabbicons/accomodation.png",
    "assets/snabbicons/others.png",
  ];
}
