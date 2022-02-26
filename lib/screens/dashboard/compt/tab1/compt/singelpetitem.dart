import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/dashboard/compt/tab1/compt/singelpetscreen.dart';

class SingelPetItem extends StatefulWidget {
  final Pet pet;
  const SingelPetItem({
    Key? key,
    required this.pet,
  }) : super(key: key);

  @override
  _SingelPetItemState createState() => _SingelPetItemState();
}

class _SingelPetItemState extends State<SingelPetItem> {
  bool isShadow = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        color: Colors.white,
        child: GestureDetector(
            onTap: () {
              // Image.network(
              //   fiximagelink + data[index].image,
              // ),

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SingelPetScreen(
                            pet: widget.pet,
                          )));
            },
            child: Container(
              // color: Colors.amber,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 0.05)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.shade100,
                            blurRadius:
                                2.0, // has the effect of softening the shadow
                            spreadRadius:
                                2.0, // has the effect of extending the shadow
                            offset: Offset(
                              3.0, // horizontal, move right 10
                              3.0, // vertical, move down 10
                            ),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 0.05)),
                        child: widget.pet.imgurl != ""
                            ? CachedNetworkImage(
                                imageUrl: widget.pet.imgurl,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Container(
                                  //  height: size.height * 0.01,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.deepPurple.shade800,
                                        value: downloadProgress.progress),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )
                            : Image.asset("assets/images/previewdog1.jpg"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.01),
                    child: Text(
                      widget.pet.name,
                      style: TextStyle(
                          fontSize: size.width * 0.07,
                          color: kprimaryColor.withOpacity(0.8),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            )));
  }
}
