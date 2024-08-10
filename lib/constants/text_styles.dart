

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



TextStyle brand(double size, [FontWeight weight = FontWeight.normal]) => GoogleFonts.sourceSans3(color: Colors.amber.shade800, fontSize: size, fontWeight: weight, height: 1);
TextStyle black(double size, [FontWeight weight = FontWeight.normal]) => GoogleFonts.sourceSans3(color: Colors.black, fontSize: size, fontWeight: weight, height: 1);
TextStyle black54(double size, [FontWeight weight = FontWeight.normal]) => GoogleFonts.sourceSans3(color: Colors.black54, fontSize: size, fontWeight: weight, height: 1);
TextStyle black54Through(double size, [FontWeight weight = FontWeight.normal]) => GoogleFonts.sourceSans3(
  color: Colors.black54, 
  fontSize: size, 
  fontWeight: weight, 
  height: 1,
  decoration: TextDecoration.lineThrough,
  decorationColor: Colors.black54,
  decorationThickness: 1.0,
);
TextStyle red(double size, [FontWeight weight = FontWeight.normal]) => GoogleFonts.sourceSans3(color: Colors.red, fontSize: size, fontWeight: weight, height: 1);
TextStyle grey(double size, [FontWeight weight = FontWeight.normal]) => GoogleFonts.sourceSans3(color: Colors.grey, fontSize: size, fontWeight: weight, height: 1);
TextStyle white(double size, [FontWeight weight = FontWeight.normal]) => GoogleFonts.sourceSans3(color: Colors.white, fontSize: size, fontWeight: weight, height: 1);