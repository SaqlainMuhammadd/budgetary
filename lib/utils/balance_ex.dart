// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:snab_budget/Screens/debit_credit/add_debit_credit.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:snab_budget/utils/daimond_shape.dart';

class BlanceExpandableFloating extends StatefulWidget {
  const BlanceExpandableFloating({super.key});

  @override
  _BlanceExpandableFloatingState createState() =>
      _BlanceExpandableFloatingState();
}

class _BlanceExpandableFloatingState extends State<BlanceExpandableFloating>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // void _openAddBalanceDialog(BuildContext context, String balanceType) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AddBalanceDialog(balanceType: balanceType);
  //     },
  //   );
  // }

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;

      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_isExpanded)
          // FloatingActionButton(
          //   onPressed: () {
          //     // Handle first action
          //   },
          //   backgroundColor: const Color.fromRGBO(86, 111, 245, 1),
          //   heroTag: null,
          //   child: const ImageIcon(AssetImage("assets/images/transfer.png")),
          // ),
          if (_isExpanded) const SizedBox(height: 16),
        if (_isExpanded)
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddCreditDebitScreen(balanceType: "Debit"),
                  ));
            },
            heroTag: null,
            backgroundColor: Colors.red,
            child: const ImageIcon(AssetImage("assets/images/minus.png")),
          ),
        if (_isExpanded) const SizedBox(height: 16),
        if (_isExpanded)
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddCreditDebitScreen(balanceType: "Credit"),
                  ));
            },
            heroTag: null,
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
          ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: SizedBox(
              height: 60,
              width: 60,
              child: FittedBox(
                  child: FloatingActionButton(
                shape: const DiamondBorder(),
                backgroundColor: AppTheme.colorPrimary,
                onPressed: _toggleExpanded,

                //  heroTag: null,
                child: AnimatedIcon(
                  icon: AnimatedIcons.add_event,
                  progress: _animation,
                ),
              ))),
        ),
      ],
    );
  }
}
