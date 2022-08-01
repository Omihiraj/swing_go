import 'package:flutter/material.dart';
import 'package:swim_app/api/timesetup_api.dart';
import 'package:swim_app/models/timesetup_model.dart';
import 'package:swim_app/pages/tdashboard/pages/edit_time_slot.dart';

class TimeSlotSetup extends StatefulWidget {
  const TimeSlotSetup({Key? key}) : super(key: key);

  @override
  State<TimeSlotSetup> createState() => _TimeSlotSetupState();
}

class _TimeSlotSetupState extends State<TimeSlotSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SizedBox(
          width: double.infinity,
          height: 600,
          child: FutureBuilder<List<TimeSetup>>(
            future: TimeSetupApi.timeSetupLocally(context),
            builder: (context, snapshot) {
              final timeItems = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return const Center(child: Text('Some error occurred!'));
                  } else {
                    return timeSlotItem(timeItems!);
                  }
              }
            },
          ),
        ));
  }
}

Widget timeSlotItem(List<TimeSetup> items) {
  return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.cyanAccent,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Text(item.day, style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                      itemCount: item.slots.length,
                      itemBuilder: (context, itemIndex) {
                        final slotItem = item.slots[itemIndex];
                        return ListTile(
                            leading: const Icon(
                              Icons.watch_later,
                              color: Colors.cyan,
                            ),
                            title: Text(slotItem),
                            trailing: IconButton(
                                onPressed: () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditTimeSlot(
                                        timeSlot: slotItem,
                                        timeItem: item,
                                      ),
                                    )),
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.cyan,
                                )));
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.greenAccent,
                    )
                  ],
                )
              ],
            ));
      });
}
