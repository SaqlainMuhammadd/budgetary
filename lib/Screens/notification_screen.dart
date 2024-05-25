import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
                child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_rounded)),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.notification,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: size.width - 370,
                  )
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: ImageIcon(
                  //         const AssetImage("assets/images/search.png"),
                  //         size: 40,
                  //         color: Theme.of(context).primaryColor))
                ],
              ),
            )),
            SizedBox(
              height: size.height / 4,
            ),
            Image.asset(
              "assets/images/icon.jpg",
              width: size.width - 200,
              height: size.height / 3,
            ),
            Text(AppLocalizations.of(context)!.nonotificationyet)
          ],
        ),
      )),
    );
  }
}
