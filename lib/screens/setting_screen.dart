import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/admin_visible_bloc/admin_visible_bloc.dart';
import '../controllers/dark_mode_bloc/dark_mode_bloc.dart';
import '../controllers/service_bloc/service_bloc.dart';
import '../resources/resources.dart';
import '../widgets/dialog_box.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int? time;
  int? screen;
  String? collection;

  void _onClickEnable(enabled) => BlocProvider.of<ServiceBloc>(context)
      .add(OnChange(isOn: enabled, screen: screen ?? 3, interval: time ?? 15));

  ListTile listsTiles(String title, String? dec) =>
      ListTile(title: Text(title), subtitle: Text(dec ?? "", maxLines: 5));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          ListTile(
              title: Text(TextResources().changeWallpaperTitle),
              subtitle: Text(TextResources().changeWallpaperDec, maxLines: 5),
              trailing: BlocBuilder<ServiceBloc, ServiceState>(
                builder: (_, state) {
                  if (state is ServiceLoading) {
                    return const CircularProgressIndicator.adaptive();
                  } else if (state is ServiceLoaded) {
                    return Switch.adaptive(
                        value: state.isOn,
                        onChanged: _onClickEnable,
                        activeColor: ColorResources().activeSwitch);
                  } else if (state is ServiceError) {
                    return Text(TextResources().blocError);
                  } else {
                    return Text(TextResources().noData);
                  }
                },
              )),
          const Divider(thickness: 2),
          GestureDetector(
              onTap: () async => time = await dialog(context,
                  TextResources().intervalTitle, dialogDataForTimeLine),
              child: listsTiles(
                  TextResources().intervalTitle, TextResources().intervalDec)),
          GestureDetector(
            onTap: () async => screen = await dialog(
                context, TextResources().screenTitle, bottomSheetScreenData),
            child: listsTiles(
                TextResources().screenTitle, TextResources().screenDec),
          ),
          GestureDetector(
            onTap: () async => collection = await dialog(context,
                TextResources().collectionTitle, dialogDataForCollection),
            child: listsTiles(
              TextResources().collectionTitle,
              TextResources().collectionDec,
            ),
          ),
          const Divider(thickness: 2),
          ListTile(
              title: Text(TextResources().darkModeTitle),
              trailing: BlocBuilder<DarkModeBloc, DarkModeState>(
                  builder: (context, state) {
                if (state is DarkModeLoaded) {
                  return Switch.adaptive(
                      value: state.isDark,
                      onChanged: (value) =>
                          BlocProvider.of<DarkModeBloc>(context)
                              .add(OnChangeMode(isDark: value)),
                      activeColor: ColorResources().activeSwitch);
                } else {
                  return Switch.adaptive(
                      value: false,
                      onChanged: (value) {},
                      activeColor: ColorResources().activeSwitch);
                }
              })),
          const Divider(thickness: 2),
          BlocBuilder<AdminVisibleBloc, AdminVisibleState>(builder: (_, state) {
            if (state is AdminVisibleLoading || state is AdminVisibleFalse) {
              return const SizedBox();
            } else if (state is AdminVisibleTrue) {
              return GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, TextResources().adminRoute),
                  child: listsTiles(
                      TextResources().adminTitle, TextResources().adminDec));
            } else {
              return Text(TextResources().noData);
            }
          })
        ],
      ),
    );
  }
}
