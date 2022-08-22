import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpy/widgets/theme.dart';
import '../resources/resources.dart';

TextStyle appBarTextStyle(context) => TextStyle(
    fontWeight: FontWeight.bold,
    color: Provider.of<ThemeProvider>(context).isDarkMode
        ? ColorResources().appBarTextIconDark
        : ColorResources().appBarTextIcon);
