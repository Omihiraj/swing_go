import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swim_app/models/timesetup_model.dart';
import '../../../utils/gen_times.dart';

class EditTimeSlot extends StatefulWidget {
  final TimeSetup timeItem;
  final String timeSlot;

  const EditTimeSlot({Key? key, required this.timeSlot, required this.timeItem})
      : super(key: key);

  @override
  State<EditTimeSlot> createState() => _EditTimeSlotState();
}

class _EditTimeSlotState extends State<EditTimeSlot> {
  TimeOfDay startTime = const TimeOfDay(hour: 09, minute: 30);
  TimeOfDay endTime = const TimeOfDay(hour: 12, minute: 30);
  String dropdownValue = '15 Minutes';
  @override
  Widget build(BuildContext context) {
    List<String> timeList = getTimesDur(startTime.hour, startTime.minute,
        endTime.hour, endTime.minute, dropdownValue);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('${widget.timeItem.day} (${widget.timeSlot}) '),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("Start Time", style: TextStyle(fontSize: 20)),
                Text("End Time", style: TextStyle(fontSize: 20))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    TimeOfDay? newTime = await showTimePicker(
                        context: context, initialTime: startTime);
                    if (newTime == null) return;
                    setState(() {
                      startTime = newTime;
                    });
                  },
                  child: Container(
                    child: Text(
                      startTime.hour.toString().padLeft(2, '0') +
                          ":" +
                          startTime.minute.toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 54),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    TimeOfDay? newTime = await showTimePicker(
                        context: context, initialTime: startTime);
                    if (newTime == null) return;
                    setState(() {
                      endTime = newTime;
                    });
                  },
                  child: Container(
                    child: Text(
                      endTime.hour.toString().padLeft(2, '0') +
                          ":" +
                          endTime.minute.toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 54),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Duration",
                  style: TextStyle(fontSize: 20),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>[
                    '15 Minutes',
                    '30 Minutes',
                    '45 Minutes',
                    '01 Hour',
                    '02 Hour'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 18)),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: GridView.builder(
                  itemCount: timeList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4),
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(15),
                        child: Text(timeList[index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18)),
                      ),
                    );
                  }),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
