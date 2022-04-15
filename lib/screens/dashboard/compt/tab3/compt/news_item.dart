import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:pet1/controllers/models/Newsmodel.dart';
import 'package:readmore/readmore.dart';

class NewsItem extends StatefulWidget {
  final NewsModel newsmodel;

  const NewsItem({
    Key? key,
    required this.newsmodel,
  }) : super(key: key);

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  bool isedit = false;
  bool isShadow = false;
  String date = '';
  @override
  void initState() {
    checkedit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.025),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.015,
                    right: size.width * 0.015,
                    top: size.height * 0.02,
                    bottom: size.height * 0.03),
                child: Text(
                  widget.newsmodel.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: size.width * 0.065,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                  // width: size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 0)),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.blueGrey.shade100,
                    //     blurRadius: 2.0,
                    //     spreadRadius: 2.0,
                    //     offset: Offset(
                    //       3.0,
                    //       3.0,
                    //     ),
                    //   )
                    // ],
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.width * 0.05)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.newsmodel.imageurl,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                        //  height: size.height * 0.01,
                        child: Center(
                          child: CircularProgressIndicator(
                              color: Colors.deepPurple.shade800,
                              value: downloadProgress.progress),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.023, bottom: size.height * 0.018),
                child: ReadMoreText(
                  widget.newsmodel.context,
                  trimLength: 250,
                  style: TextStyle(
                    fontSize: size.width * 0.043,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isedit
                      ? LineIcon.edit(color: Colors.black.withOpacity(0.6))
                      : LineIcon.pen(color: Colors.black.withOpacity(0.6)),
                  Text(
                    date,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  )
                ],
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  checkedit() {
    if (widget.newsmodel.editeddate == "") {
      print("not edit");
      isedit = false;
      date = widget.newsmodel.addeddate;
    } else {
      isedit = true;
      date = widget.newsmodel.editeddate;
    }
    setState(() {});
  }

  setshadow() {
    Future.delayed(const Duration(milliseconds: 3700), () {
      isShadow = true;
      setState(() {});
    });
  }
}
