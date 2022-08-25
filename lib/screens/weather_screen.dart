import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpy/controllers/weather_bloc/weather_bloc.dart';
import 'package:wallpy/resources/resources.dart';
import 'package:wallpy/widgets/network_image.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: networkImages(TextResources().weatherUrl, null),
      ),
      BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WeatherLoaded) {
          return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${state.data.sys?.country}',
                    // state.data.city!.country.toUpperCase(),
                    style: TextStyle(
                        fontSize: 30,
                        color: ColorResources().textColorWhite,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.data.name,
                    style: TextStyle(
                        fontSize: 20,
                        color: ColorResources().textColorWhite,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        '${state.data.main?.temp} C',
                        style: TextStyle(
                            fontSize: 30,
                            color: ColorResources().textColorWhite,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        state.data.weather[0].description,
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorResources().textColorWhite,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    TextResources().humidity,
                    style: TextStyle(color: ColorResources().textColorWhite),
                  ),
                  Text(
                    '${state.data.main?.humidity ?? ''}',
                    style: TextStyle(
                        color: ColorResources().textColorWhite, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    TextResources().swWind,
                    style: TextStyle(
                      color: ColorResources().textColorWhite,
                    ),
                  ),
                  Text(
                    '${state.data.wind?.speed}',
                    style: TextStyle(
                        color: ColorResources().textColorWhite, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    TextResources().visibility,
                    style: TextStyle(
                      color: ColorResources().textColorWhite,
                    ),
                  ),
                  Text(
                    '${state.data.visibility}',
                    style: TextStyle(
                        color: ColorResources().textColorWhite, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    TextResources().pressure,
                    style: TextStyle(
                      color: ColorResources().textColorWhite,
                    ),
                  ),
                  Text(
                    '${state.data.main?.pressure}',
                    style: TextStyle(
                        color: ColorResources().textColorWhite, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // SizedBox(
                  //   height: 200,
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: state.data.list.length,
                  //       itemBuilder: (BuildContext ctx, int i) {
                  //         return Padding(
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 5, vertical: 10),
                  //           child: Container(
                  //               height: 30,
                  //               width: 120,
                  //               child: Card(
                  //                   child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Text('Today'),
                  //                   IconButton(
                  //                       onPressed: () {},
                  //                       icon: Icon(Icons.cloud)),
                  //                   Text(
                  //                     (state.data.list[1].temp?.max ?? "")
                  //                         .toString(),
                  //                     style: TextStyle(fontSize: 20),
                  //                   )
                  //                 ],
                  //               ))),
                  //         );
                  //       }),
                  // )
                ],
              ));
        } else {
          if (state is WeatherError) {
            return Center(
                child: Text(
              state.error.toString(),
              style: TextStyle(color: ColorResources().textColorWhite),
            ));
          } else {
            return Center(child: Text(TextResources().noData));
          }
        }
      })
    ]);
  }
}
