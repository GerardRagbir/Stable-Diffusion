import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DiffuseImage extends StatefulWidget {
  const DiffuseImage({Key? key, this.data}) : super(key: key);
  final dynamic data;

  @override
  State<DiffuseImage> createState() => _DiffuseImageState();
}

class _DiffuseImageState extends State<DiffuseImage> {
  late final decodedBytes;

  @override
  void initState() {
    decodedBytes = base64Decode(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(20)),
      child: widget.data != null
          ? Image.memory(decodedBytes!,
              fit: BoxFit.contain, alignment: Alignment.center)
          : const FlutterLogo(),
    );
  }
}
