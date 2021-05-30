import 'package:flutter/material.dart';
import 'package:taganrog_defence/Images/images.dart';
import 'package:taganrog_defence/bloc/bloc_provider.dart';

import 'full_size_image.dart';

class PhotoGalleryItem extends StatefulWidget {
  final int _index;

  PhotoGalleryItem(this._index);

  @override
  _PhotoGalleryItemState createState() => _PhotoGalleryItemState();
}

class _PhotoGalleryItemState extends State<PhotoGalleryItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 200.0,
        width: 200.0,
        child: Center(
            child: Image(
          image:
              AssetImage(ApplicationImages.photoGalleryLinks()[widget._index]),
          fit: BoxFit.cover,
        )),
      ),
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              FullSizeImage(widget._index),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              alignment: Alignment.center,
              child: child,
            );
          },
        ));
      },
    );
  }
}