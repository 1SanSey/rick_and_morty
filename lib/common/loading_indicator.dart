import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loadingIndicator() {
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: Center(
      child: SpinKitDualRing(
        color: Colors.white,
        size: 60.0,
      ),
    ),
  );
}
