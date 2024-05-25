import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/apis/controller/user_drawer_controller.dart';
import 'package:snab_budget/apis/model/get_user_all_transaction.dart';
import 'package:snab_budget/static_data.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/brighness_provider.dart';
import '../models/transaction.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class TransactionCard extends StatefulWidget {
  final Data transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  Future<void> showImageDialog(
      BuildContext context, Data obj, var height, var width) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Consumer<BrightnessProvider>(builder: (context, provider, v) {
          return AlertDialog(
            elevation: 10,
            shadowColor: AppTheme.colorPrimary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Center(
                              child: Text(
                            AppLocalizations.of(context)!.transactiondetails,
                            style: TextStyle(
                                color: provider.brightness == AppBrightness.dark
                                    ? AppTheme.colorWhite
                                    : AppTheme.colorPrimary,
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        SizedBox(
                          height: height * 0.06,
                          width: width * 0.9,
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: height,
                                  width: width,
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.name,
                                        style: TextStyle(
                                            color: provider.brightness ==
                                                    AppBrightness.dark
                                                ? AppTheme.colorWhite
                                                : AppTheme.colorPrimary,
                                            fontSize: width * 0.03,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        obj.name!,
                                        style: TextStyle(
                                          fontSize: width * 0.03,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.amount,
                                        style: TextStyle(
                                            color: provider.brightness ==
                                                    AppBrightness.dark
                                                ? AppTheme.colorWhite
                                                : AppTheme.colorPrimary,
                                            fontSize: width * 0.03,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        obj.amount.toString(),
                                        style: TextStyle(
                                          fontSize: width * 0.03,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.cname,
                                        style: TextStyle(
                                            color: provider.brightness ==
                                                    AppBrightness.dark
                                                ? AppTheme.colorWhite
                                                : AppTheme.colorPrimary,
                                            fontSize: width * 0.03,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        obj.category!,
                                        style: TextStyle(
                                          fontSize: width * 0.03,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.date,
                                        style: TextStyle(
                                            color: provider.brightness ==
                                                    AppBrightness.dark
                                                ? AppTheme.colorWhite
                                                : AppTheme.colorPrimary,
                                            fontSize: width * 0.03,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        obj.dateTime.toString(),
                                        style: TextStyle(
                                          fontSize: width * 0.03,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  AppLocalizations.of(context)!.noteoptional,
                                  style: TextStyle(
                                      color: provider.brightness ==
                                              AppBrightness.dark
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorPrimary,
                                      fontSize: width * 0.035,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    obj.note!,
                                    style: TextStyle(
                                      fontSize: width * 0.03,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100]),
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: obj.file != null && obj.file != ""
                                  ? Hero(
                                      tag: obj.file!,
                                      child: FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        placeholder: 'assets/images/bell.png',
                                        image:
                                            "${StaticValues.imageUrl}${obj.file!}",
                                        placeholderErrorBuilder:
                                            (context, error, stackTrace) {
                                          return const CircularProgressIndicator();
                                        },
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!
                                          .notransactions,
                                      style: TextStyle(
                                          fontSize: width * 0.03,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.08,
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
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          width: MediaQuery.of(context).size.width * 0.08,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(obj.imageUrl!)),
                              shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppTheme.colorPrimary,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: () {
          showImageDialog(
              context,
              widget.transaction,
              MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.width);
        },
        leading: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                widget.transaction.imageUrl!,
              ),
            )),
        title: Text(
          widget.transaction.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(widget.transaction.dateTime!),
        // .substring(0, 10)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
                // ignore: unrelated_type_equality_checks
                widget.transaction.type == 1
                    ? "+ ${widget.transaction.amount}"
                    : "-${widget.transaction.amount}",
                style: TextStyle(
                    // ignore: unrelated_type_equality_checks
                    color: widget.transaction.type == 1
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold)),
            Text(
                // ignore: unrelated_type_equality_checks
                widget.transaction.type == 1
                    ? DashBoardController.to.curency
                    : DashBoardController.to.curency,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color:
                      widget.transaction.type == 1 ? Colors.green : Colors.red,
                )),
          ],
        ),
      ),
    );
  }
}

class TransactionImageScreen extends StatelessWidget {
  final String imageUrl;

  const TransactionImageScreen({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        AppLocalizations.of(context)!.loadingfile,
      )),
      body: Center(
        // ignore: unnecessary_null_comparison
        child: imageUrl != null
            ? Hero(
                tag: imageUrl,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/bell.png',
                  image: imageUrl,
                  placeholderErrorBuilder: (context, error, stackTrace) {
                    return const CircularProgressIndicator();
                  },
                ),
              )
            : Text(
                AppLocalizations.of(context)!.transactions,
              ),
      ),
    );
  }
}
