import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/brighness_provider.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomBar({
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Consumer<BrightnessProvider>(builder: (context, provider, bv) {
      return Container(
        height: height / 15,
        decoration: const BoxDecoration(
            //color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const ImageIcon(
                AssetImage("assets/images/home-icon.png"),
                size: 50,
              ),
              onPressed: () => onTabSelected(0),
              color: selectedIndex == 0
                  ? provider.brightness == AppBrightness.dark
                      ? AppTheme.colorWhite
                      : AppTheme.colorPrimary
                  : provider.brightness == AppBrightness.dark
                      ? AppTheme.colorPrimary
                      : Colors.grey,
            ),
            IconButton(
              icon: const ImageIcon(
                AssetImage("assets/images/bar-chart.png"),
                size: 50,
              ),
              onPressed: () => onTabSelected(1),
              color: selectedIndex == 1
                  ? provider.brightness == AppBrightness.dark
                      ? AppTheme.colorWhite
                      : AppTheme.colorPrimary
                  : provider.brightness == AppBrightness.dark
                      ? AppTheme.colorPrimary
                      : Colors.grey,
            ),
            IconButton(
              icon: const ImageIcon(
                AssetImage("assets/images/user.png"),
                size: 50,
              ),
              onPressed: () => onTabSelected(2),
              color: selectedIndex == 2
                  ? provider.brightness == AppBrightness.dark
                      ? AppTheme.colorWhite
                      : AppTheme.colorPrimary
                  : provider.brightness == AppBrightness.dark
                      ? AppTheme.colorPrimary
                      : Colors.grey,
            ),
          ],
        ),
      );
    });
  }
}
