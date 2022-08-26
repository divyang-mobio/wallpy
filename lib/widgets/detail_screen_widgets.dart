import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
import '../resources/resources.dart';

Visibility backIcon(context, bool isVis) {
  return Visibility(
    maintainState: true,
    visible: isVis,
    child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(IconsResources().back,
                  color: BlocProvider.of<DarkModeBloc>(context).isDark
                      ? ColorResources().appBarTextIconDark
                      : ColorResources().appBarTextIcon)),
        )),
  );
}

Icon icons(context, IconData iconData) {
  return Icon(
    size: 30,
    iconData,
    color: BlocProvider.of<DarkModeBloc>(context).isDark
        ? ColorResources().detailScreenIconsDark
        : ColorResources().detailScreenIcons,
  );
}

Visibility allIcons(context, bool isVis, Widget child) {
  return Visibility(
    maintainState: true,
    visible: isVis,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          decoration: BoxDecoration(
              color: BlocProvider.of<DarkModeBloc>(context).isDark
                  ? ColorResources().detailScreenContainerDark
                  : ColorResources().detailScreenContainer,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
          height: 80,
          width: MediaQuery.of(context).size.width * .8,
          child: child),
    ),
  );
}

void snackBar(String data, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
}
