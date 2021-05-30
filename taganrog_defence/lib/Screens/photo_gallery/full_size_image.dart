import 'package:flutter/material.dart';
import 'package:taganrog_defence/Images/images.dart';

class FullSizeImage extends StatefulWidget {
  final index;

  FullSizeImage(this.index);

  @override
  _FullSizeImageState createState() => new _FullSizeImageState();
}

class _FullSizeImageState extends State<FullSizeImage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFeaecc6),
          iconTheme: IconThemeData(color: Color(0xFF2bc0e4)),
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Color(0xFF2bc0e4), Color(0xFFeaecc6)],
            )),
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: ApplicationImages.photoGalleryLinks().length,
                  controller: PageController(
                    initialPage: widget.index,
                    keepPage: true,
                    viewportFraction: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Hero(
                          tag: "$index",
                          child: Center(
                            child: Container(
                              child: Image(
                                image: AssetImage(ApplicationImages
                                    .photoGalleryLinks()[index]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            )),
      ),
    );
  }
}
