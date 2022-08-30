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
      layoutBuilder: _layoutBuilder,
      useInShowDialog: true,
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
      child: Center(child:
          BlocBuilder<GradiantBloc, GradiantState>(builder: (context, state) {
        if (state is GradiantInitial) {
          return Column(
            children: [
              const SizedBox(height: 10),
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height * .4,
                  width: MediaQuery.of(context).size.width * .5,
                  child: const Center(
                      child: CircularProgressIndicator.adaptive())),
              const SizedBox(height: 10),
              selectColor()
            ],
          );
        } else if (state is GradiantLoaded) {
          return Column(
            children: [
              const SizedBox(height: 10),
              GestureDetector(
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
              ),
              const SizedBox(height: 10),
              selectColor()
            ],
          );
        } else {
          return Text(TextResources().noData);
        }
      })),
    );
  }
}

Widget _layoutBuilder(BuildContext context, List<Color> colors, PickerItem child) {
  Orientation orientation = MediaQuery.of(context).orientation;

  return SizedBox(
    width: 300,
    height: orientation == Orientation.portrait ? 360 :  200,
    child: GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: orientation == Orientation.portrait ? 4 : 6,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: [for (Color color in colors) child(color)],
    ),
  );
}
