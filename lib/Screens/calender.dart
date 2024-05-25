import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:snab_budget/utils/apptheme.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CalenderScreen extends StatefulWidget {
  static const routeName = "Calender-Screen";

  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    final cellCalendarPageController = CellCalendarPageController();
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            height: height * 0.13,
            width: width * 0.9,
            decoration: BoxDecoration(
                color: AppTheme.colorPrimary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: width * 0.065,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.1,
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.calendar}",
                    style: TextStyle(
                        fontSize: width * 0.04,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: width * 0.21,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
            child: CellCalendar(
              todayMarkColor: AppTheme.colorPrimary,
              cellCalendarPageController: cellCalendarPageController,
              daysOfTheWeekBuilder: (dayIndex) {
                final labels = ["S", "M", "T", "W", "T", "F", "S"];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    labels[dayIndex],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
              monthYearLabelBuilder: (datetime) {
                final year = datetime!.year.toString();
                final month = datetime.month.monthName;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Text(
                        "$month  $year",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () {
                          cellCalendarPageController.animateToDate(
                            DateTime.now(),
                            curve: Curves.linear,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
              onCellTapped: (date) {},
              onPageChanged: (firstDate, lastDate) {
                /// Called when the page was changed
                /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
              },
            ),
          ),
        ],
      )),
    );
  }
}
