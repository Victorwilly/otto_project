// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'dart:async';
import 'package:flutter/material.dart';

import '../shared/utils/dims.dart';
import '../shared/utils/themes/theme.dart';

class ModalShield extends StatefulWidget {
  const ModalShield({super.key});

  @override
  _ModalShieldState createState() {
    return _ModalShieldState();
  }
}

class _ModalShieldState extends State<ModalShield> {
  int _modalCount = 0;
  StreamSubscription<int>? _modal$;

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(
        top: Dims.dx(60),
      ),
      duration: const Duration(
        milliseconds: 100,
      ),
      color: pmTheme.black?.withOpacity(0.5),
      width: Dims.deviceSize?.width,
      height: _modalCount > 0 ? Dims.dx(16) : 0,
    );
  }

  @override
  void dispose() {
    _modal$!.cancel();

    super.dispose();
  }
}
