import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class IconDropdownList {
  final String name;
  final IconData icon;

  IconDropdownList({required this.name, required this.icon});
}

class IconsHandler {
  Map<String, IconDropdownList> mapicon = {
    "Casa": IconDropdownList(name: "Casa", icon: FlutterRemix.home_2_line),
    "Casa amor":
        IconDropdownList(name: "Casa amor", icon: FlutterRemix.home_heart_line),
    "Oficina":
        IconDropdownList(name: "Oficina", icon: FlutterRemix.building_2_line),
    "Fabrica":
        IconDropdownList(name: "Fabrica", icon: FlutterRemix.building_3_line),
    "Edificio":
        IconDropdownList(name: "Edificio", icon: FlutterRemix.building_4_line),
    "Hotel": IconDropdownList(name: "Hotel", icon: FlutterRemix.hotel_line),
    "Comunidad":
        IconDropdownList(name: "Comunidad", icon: FlutterRemix.community_line),
//"Escuela": //IconDropdownList(name: "Escuela", icon: FlutterRemix.),
    "Gobierno":
        IconDropdownList(name: "Gobierno", icon: FlutterRemix.government_line),
    "Banco": IconDropdownList(name: "Banco", icon: FlutterRemix.bank_line),
    "Tienda": IconDropdownList(name: "Tienda", icon: FlutterRemix.store_2_line),
    "Hospital":
        IconDropdownList(name: "Hospital", icon: FlutterRemix.hospital_line),
    "Orar":
        IconDropdownList(name: "Orar", icon: FlutterRemix.ancient_gate_line),

    "Adjuntar":
        IconDropdownList(name: "Adjuntar", icon: FlutterRemix.attachment_line),
    "Investigar":
        IconDropdownList(name: "Investigar", icon: FlutterRemix.profile_line),
    "Archivo": IconDropdownList(
        name: "Archivo", icon: FlutterRemix.archive_drawer_line),
    "Para": IconDropdownList(name: "Para", icon: FlutterRemix.at_line),
    "Medalla":
        IconDropdownList(name: "Medalla", icon: FlutterRemix.medal_2_line),
    "Global": IconDropdownList(name: "Global", icon: FlutterRemix.global_line),
    "Chat": IconDropdownList(name: "Chat", icon: FlutterRemix.chat_3_line),
    "Escribir":
        IconDropdownList(name: "Escribir", icon: FlutterRemix.quill_pen_line),
    "Jugar": IconDropdownList(name: "Jugar", icon: FlutterRemix.gamepad_line),
    "leer": IconDropdownList(name: "leer", icon: FlutterRemix.book_open_line),
    "Medicamento":
        IconDropdownList(name: "Medicamento", icon: FlutterRemix.capsule_fill)
  };
}
