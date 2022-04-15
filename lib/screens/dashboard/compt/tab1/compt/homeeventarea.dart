import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pet1/controllers/firedbhandeler/firedbhandel.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/validators/date.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/components/errorpage.dart';

class HomeEventItem extends StatefulWidget {
  const HomeEventItem({
    Key? key,
  }) : super(key: key);

  @override
  _HomeEventItemState createState() => _HomeEventItemState();
}

class _HomeEventItemState extends State<HomeEventItem> {
  late Future<List<EventModel>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = FireDBHandeler.getallEvents();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: FutureBuilder(
        future: futureData,
        builder: (context, snapshot) {
          print(snapshot.hasData);
          if (snapshot.hasData) {
            List<EventModel> data = snapshot.data as List<EventModel>;
            print(data);
            if (data.isNotEmpty) {
              EventModel eventModel = data.first;
              String d = "";
              String h = "";
              String m = "";
              RemainingTime remainingTime;
              remainingTime = Date.datetimeBetween(
                  eventModel.eventDate, eventModel.eventtime);

              if (remainingTime.days != 0) {
                d = remainingTime.days.toString() + "days ";
              }
              if (remainingTime.hours != 0) {
                h = remainingTime.hours.toString() + " hours ";
              }
              if (remainingTime.minits != 0) {
                m = remainingTime.minits.toString() + "minitus ";
              }

              String remainintext = d + h + m;

              return Card(
                shadowColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: eventModel.status == 0
                    ? remainingTime.isoverdue
                        ? Colors.red.shade400
                        : kmenucolor
                    : Colors.green.shade400,
                child: ListTile(
                  leading: Container(
                    child: Image.asset(
                      "assets/icons/eventicon1.png",
                    ),
                  ),
                  title: Row(
                    children: [
                      Flexible(
                        child: Text(
                          eventModel.title,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Icon(Icons.timer, color: Colors.yellowAccent),
                        Text(
                            eventModel.status == 0
                                ? remainingTime.isoverdue
                                    ? "Overdue " + remainintext
                                    : "Remaining " + remainintext
                                : "Done",
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                  child: Lottie.asset("assets/animations/peteventhome.json",
                      width: size.width * 0.5));
            }
          } else if (snapshot.hasError) {
            return Errorpage(size: size.width * 0.56);
          }
          // By default show a loading spinner.
          return Center(
              child: Lottie.asset("assets/animations/loadingdots.json",
                  width: size.width * 0.5));
        },
      ),
    );
  }

  loaddata() async {
    futureData = FireDBHandeler.getallEvents();
    setState(() {});
  }
}
