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
  List<Color> myColor = ColorResources().pickerGradiant;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<GradiantBloc, GradiantState>(builder: (context, state) {
          if (state is GradiantInitial) {
            return const CircularProgressIndicator.adaptive();
          } else if (state is GradiantLoaded) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                  context, TextResources().detailGradiantScreenRoute,
                  arguments: DetailGradiantScreenArgument(
                      myColor: (state.myColor.length < 2)
                          ? (state.myColor.isEmpty)
                              ? [Colors.white, Colors.white]
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
                                  ? [Colors.white, Colors.white]
                                  : [state.myColor[0], state.myColor[0]]
                              : state.myColor)),
                  height: MediaQuery.of(context).size.height * .4,
                  width: MediaQuery.of(context).size.width * .5,
                ),
              ),
            );
          } else {
            return const Text("Not Working");
          }
        }),
        MaterialButton(
            onPressed: () {
              // List<Color>? selectedColor;
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: BlocBuilder<GradiantBloc, GradiantState>(
                            builder: (context, state) {
                          return (state is GradiantLoaded)
                              ? MultipleChoiceBlockPicker(
                                  pickerColors: state.myColor,
                                  onColorsChanged: (List<Color> colors) {
                                    BlocProvider.of<GradiantBloc>(context)
                                        .add(SelectedColor(myColor: colors));
                                  },
                                )
                              : const Text("Apply");
                        }),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('DONE'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            // BlocProvider.of<GradiantBloc>(context).add(
                            //     SelectedColor(myColor: selectedColor ?? []));
                          },
                        ),
                      ],
                    );
                  });
            },
            child: const Text("change color"))
      ],
    ));
  }
}
