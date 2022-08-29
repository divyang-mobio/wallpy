import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../models/navigation_model.dart';
import '../resources/resources.dart';
import '../controllers/gradiant_bloc/gradiant_bloc.dart';

class GradiantScreen extends StatefulWidget {
  const GradiantScreen({Key? key}) : super(key: key);

  @override
  State<GradiantScreen> createState() => _GradiantScreenState();
}

class _GradiantScreenState extends State<GradiantScreen> {
  List<Color> selectedColor = ColorResources().pickerGradiantDefault;

  MultipleChoiceBlockPicker selectColor() {
    return MultipleChoiceBlockPicker(
      useInShowDialog: false,
      pickerColors: selectedColor,
      onColorsChanged: (List<Color> colors) {
        selectedColor = colors;
        BlocProvider.of<GradiantBloc>(context)
            .add(SelectedColor(myColor: selectedColor));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          BlocBuilder<GradiantBloc, GradiantState>(builder: (context, state) {
            if (state is GradiantInitial) {
              return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height * .4,
                  width: MediaQuery.of(context).size.width * .5,
                  child: Center(child: Text(TextResources().applyNew)));
            } else if (state is GradiantLoaded) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, TextResources().detailGradiantScreenRoute,
                    arguments: DetailGradiantScreenArgument(
                        myColor: (state.myColor.length < 2)
                            ? (state.myColor.isEmpty)
                                ? ColorResources().pickerGradiantEmpty
                                : [state.myColor[0], state.myColor[0]]
                            : state.myColor)),
                child: Hero(
                  tag: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: (state.myColor.length < 2)
                                ? (state.myColor.isEmpty)
                                    ? ColorResources().pickerGradiantEmpty
                                    : [state.myColor[0], state.myColor[0]]
                                : state.myColor)),
                    height: MediaQuery.of(context).size.height * .4,
                    width: MediaQuery.of(context).size.width * .5,
                  ),
                ),
              );
            } else {
              return Text(TextResources().noData);
            }
          }),
          const SizedBox(height: 10),
          BlocBuilder<GradiantBloc, GradiantState>(builder: (context, state) {
            if (state is GradiantInitial) {
              return selectColor();
            } else if (state is GradiantLoaded) {
              selectedColor = state.myColor;
              return selectColor();
            } else {
              return Text(TextResources().noData);
            }
          }),
        ],
      )),
    );
  }
}
