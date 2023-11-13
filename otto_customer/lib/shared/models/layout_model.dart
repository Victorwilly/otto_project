// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum AppLayoutTypes {
  NONE,
  DASHBOARD,
}

class NoteItem {
  NoteItem({
    this.noteContent,
    this.btnDisabled,
    this.actionBtnText,
    this.btnWidth,
  });

  NoteItemNoteContent? noteContent;
  String? actionBtnText;
  bool? btnDisabled;
  double? btnWidth;
}

class NoteItemNoteContent {
  const NoteItemNoteContent({
    this.notes,
    this.description,
    this.createdAt,
    this.sctid,
    this.status,
    this.visitId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'notes': notes,
      'description': description,
      'created_at': createdAt,
      'sctid': sctid,
      'visit_id': visitId,
      'status': status,
    };
  }

  final String? notes;
  final String? description;
  final DateTime? createdAt;
  final int? status;
  final int? sctid;
  final int? visitId;
}

class DropdownOpt {
  DropdownOpt({
    this.title,
    this.id,
  });

  String? title;
  String? id;
}

class DashboardStickerItem {
  DashboardStickerItem({
    required this.id,
    required this.content,
    required this.handle,
    this.width,
  });

  String id;
  Widget handle; // the handle that's clicked to show the main content
  Widget content; // the main child widget to be displayed
  double? width;
}

class ProfileLayoutConfig {
  const ProfileLayoutConfig({
    required this.menuItems,
    required this.patientId,
    this.basePath,
    this.stickers,
    this.activeMenu,
  });

  final List<PatientProfileMenuItem>? menuItems;
  final PatientProfileMenuItem? activeMenu;
  final String? patientId;
  final String? basePath;
  final List<DashboardStickerItem>? stickers;
}

class LayoutConfig {
  LayoutConfig({
    this.type = AppLayoutTypes.NONE,
  });

  AppLayoutTypes type;
}

class DashboardOverlayConfig {
  DashboardOverlayConfig({
    required this.child,
    required this.id,
    this.duration,
    this.finalBottom,
    this.finalLeft,
    this.finalRight,
    this.finalTop,
    this.initialBottom,
    this.initialLeft,
    this.initialRight,
    this.initialTop,
  });

  Widget Function()? child;
  String? id;
  Duration? duration;
  bool? active;
  double? initialTop;
  double? initialLeft;
  double? initialRight;
  double? initialBottom;
  double? finalTop;
  double? finalLeft;
  double? finalRight;
  double? finalBottom;
}

class PatientProfileMenuItem {
  PatientProfileMenuItem({
    required this.id,
    required this.title,
    required this.path,
  });

  String? id;
  String? title;
  String? path;
}

abstract class PatientProfileMenu {
  List<PatientProfileMenuItem> items();
  ProfileLayoutConfig config(String patientId);
}
