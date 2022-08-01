import 'package:flutter/material.dart';
import 'package:swim_app/api/getslot_api.dart';
import 'package:swim_app/api/gettime_api.dart';
import 'package:swim_app/api/sendbook_api.dart';
import 'package:swim_app/models/getslots.dart';
import 'package:swim_app/models/gettime.dart';
import '../utils/date_utils.dart' as date_util;
import '../utils/date_time.dart';
import 'package:provider/provider.dart';

class BookNow extends StatefulWidget {
  final String trainerId;
  final String? traineeId;
  const BookNow({
    required this.traineeId,
    required this.trainerId,
    Key? key,
  }) : super(key: key);

  @override
  State<BookNow> createState() => _BookNowState();
}

class _BookNowState extends State<BookNow> {
  DateTime currentDate = DateTime.now();
  String selectDate = "";
  String time = "";
  List<int> datesNo = getDate()[0];
  List<String> datesName = getDate()[1];
  List<String> monthNames = getDate()[2];

  String slotDay = getDate()[1][0];
  String monthName = getDate()[2][0];
  List<int> monthNo = getDate()[3];
  String timeSlot = "";
  int dateItemIndex = 0;
  int? slotItemIndex;
  int? timeItemIndex;

  DateTime? nowDate;
  int dateNo = DateTime.now().weekday;
  bool isChecked = false;
  @override
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.amber;
      }
      return Colors.amber;
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: const Text("Book Now")),
      body: ListView(children: [
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: datesNo.length,
              itemBuilder: (context, index) {
                return InkWell(
                  highlightColor: Colors.amber.withOpacity(0.3),
                  splashColor: Colors.amber.withOpacity(0.3),
                  onTap: () {
                    setState(() {
                      nowDate = DateTime.utc(
                          currentDate.year, monthNo[index], datesNo[index]);
                      slotDay = datesName[index];
                      dateItemIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: dateItemIndex == index
                            ? Colors.amber
                            : Colors.white),
                    margin: const EdgeInsets.only(left: 10.0),
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          "${datesNo[index]}",
                          style: TextStyle(
                              fontSize: 24,
                              color: dateItemIndex == index
                                  ? Colors.white
                                  : Colors.grey),
                        )),
                        Center(
                            child: Text(datesName[index],
                                style: TextStyle(
                                    fontSize: 22,
                                    color: dateItemIndex == index
                                        ? Colors.white
                                        : Colors.grey))),
                        Center(
                            child: Text(
                                '${currentDate.year}|' + monthNames[index],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: dateItemIndex == index
                                        ? Colors.white
                                        : Colors.grey))),
                      ],
                    ),
                  ),
                );
              }),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10.0),
          child: slotCard(context, widget.trainerId, slotDay),
          height: 50,
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          height: 160.0,
          child: timeCard(
              context, widget.trainerId, nowDate.toString(), slotDay, timeSlot),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "I have My Own Pool",
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              "(If you like to train your own pool please put a tick)",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.redAccent),
            )),
        const SizedBox(
          height: 40.0,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: const BorderSide(color: Colors.amber)),
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.all(20),
              textStyle: const TextStyle(fontSize: 24),
            ),
            onPressed: () {
              SendBookApi.sendBook(
                  trainerId: widget.trainerId,
                  traineeId: "ojiwdfr@gmail.com",
                  poolId: 1,
                  ownPool: isChecked,
                  lessonId: 1,
                  date: nowDate!,
                  timSlot: timeSlot,
                  time: time);
            },
            child: const Text(
              'Make an Appointment',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }

  Widget slotCard(context, String id, String day) {
    return FutureBuilder<TimeSlot>(
        future: TimeSlotApi.getSlots(id, day),
        builder: (context, snapshot) {
          final tSlot = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Time Slot is Not Setup",
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              } else {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tSlot!.timeslots.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            timeSlot = tSlot.timeslots[index];
                            slotItemIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.only(right: 20.0),
                          decoration: BoxDecoration(
                              color: slotItemIndex == index
                                  ? Colors.amber
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Row(
                            children: [
                              Icon(Icons.access_alarm,
                                  color: slotItemIndex == index
                                      ? Colors.white
                                      : Colors.black),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                tSlot.timeslots[index],
                                style: TextStyle(
                                    color: slotItemIndex == index
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ],
                          )),
                        ),
                      );
                    });
              }
          }
        });
  }

  Widget timeCard(context, String id, String date, String day, String slot) {
    return FutureBuilder<GetTime>(
        future: GetTimeApi.getTimes(id, date, day, slot),
        builder: (context, snapshot) {
          final timeItem = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Time is Not Available",
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              } else {
                return GridView.builder(
                    itemCount: timeItem!.items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            time = timeItem.items[index];
                            timeItemIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: timeItemIndex == index
                                  ? Colors.amber
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                              child: Text(timeItem.items[index],
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: timeItemIndex == index
                                          ? Colors.white
                                          : Colors.black))),
                        ),
                      );
                    });
              }
          }
        });
  }
}

class OwnPool extends ChangeNotifier {
  bool _isChecked = false;
  void update(bool val) {
    _isChecked = val;
    notifyListeners();
  }

  bool get isChecked => _isChecked;
}
