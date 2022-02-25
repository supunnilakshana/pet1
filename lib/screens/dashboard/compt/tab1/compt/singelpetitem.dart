import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/screens/components/constansts.dart';

class SingelPetItem extends StatelessWidget {
  final Pet pet;
  const SingelPetItem({
    Key? key,
    required this.pet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        child: GestureDetector(
            onTap: () {
              // Image.network(
              //   fiximagelink + data[index].image,
              // ),

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => Singelitemfull(
              //               imglist: imglist,
              //               product: data[index],
              //             )));
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
                            color: Colors.blueGrey.shade100,
                            blurRadius:
                                2.0, // has the effect of softening the shadow
                            spreadRadius:
                                2.0, // has the effect of extending the shadow
                            offset: Offset(
                              3.0, // horizontal, move right 10
                              3.0, // vertical, move down 10
                            ),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.width * 0.05)),
                        child: pet.imgurl != ""
                            ? CachedNetworkImage(
                                imageUrl: pet.imgurl,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Container(
                                  //  height: size.height * 0.01,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.blueGrey,
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
                      pet.name,
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
