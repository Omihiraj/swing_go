import 'package:flutter/material.dart';
import 'package:swim_app/api/trainer_booking_api.dart';
import 'package:swim_app/models/trainer_booking.dart';
import 'package:swim_app/pages/tdashboard/pages/book_trainer.dart';

class Appoiment extends StatefulWidget {
  const Appoiment({Key? key}) : super(key: key);

  @override
  State<Appoiment> createState() => _AppoimentState();
}

class _AppoimentState extends State<Appoiment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TrainerBook>>(
          future: TrainerBookApi.getBooking(1),
          builder: (context, snapshot) {
            final bookItem = snapshot.data;

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return const Center(child: Text('Some error occurred!'));
                } else {
                  return bookingItem(bookItem!);
                }
            }
          }),
    );
  }
}

Widget bookingItem(List<TrainerBook> items) {
  const List monthsName = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => BookTrainer(
              trainee: item,
            ),
          )),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            margin: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(item.traineeImg,
                          width: 100, height: 100, fit: BoxFit.cover)),
                ),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.traineeName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    item.status == 1
                        ? const Text(
                            "Accept",
                            style: TextStyle(
                                backgroundColor: Colors.greenAccent,
                                color: Colors.white),
                          )
                        : const Text(
                            "Reject",
                            style: TextStyle(
                                backgroundColor: Colors.redAccent,
                                color: Colors.white),
                          )
                  ],
                )),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.calendar_today_outlined),
                    Text('${monthsName[item.date.month]}-' +
                        item.date.day.toString().padLeft(2, '0')),
                    Text(
                      item.time,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
                    )
                  ],
                )),
              ],
            ),
          ),
        );
      });
}
