import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../controllers/gradiant_bloc/gradiant_bloc.dart';

class GradiantScreen extends StatefulWidget {
  const GradiantScreen({Key? key}) : super(key: key);

  @override
  State<GradiantScreen> createState() => _GradiantScreenState();
}

class _GradiantScreenState extends State<GradiantScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:BlocBuilder<GradiantBloc, GradiantState>(builder: (context, state) {
        if (state is GradiantLoaded) { return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

              // print("test");
              // print(state.myColor);
               Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: state.myColor)),
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width * .5,
              ),

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
                                      // selectedColor = colors;
                                      BlocProvider.of<GradiantBloc>(context).add(
                                          SelectedColor(myColor: colors));
                                    },
                                  )
                                : Text("data");
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
      );
        } else {
        return const Text("Not Working");
        }
      }),
    );
  }
}
