import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpy/controllers/weather_bloc/weather_bloc.dart';
import 'package:wallpy/resources/resources.dart';

import '../widgets/shimmer_loading.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToY5hNtemPEvOyyPKrWdVOZWR-gQBRI-ThmA&usqp=CAU',
                ))),
        child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherLoading) {
            return categoryshimmer(context);
          } else if (state is WeatherLoaded) {
            return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latitiude  ${state.data.coord?.lat}',
                      style: TextStyle(
                          fontSize: 30,
                          color: ColorResources().textColorwhite,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Longitude ${state.data.coord?.lon}',
                      style: TextStyle(
                          fontSize: 30,
                          color: ColorResources().textColorwhite,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      state.data.sys!.country.toString(),
                      style: TextStyle(
                          fontSize: 30,
                          color: ColorResources().textColorwhite,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      state.data.name,
                      style: TextStyle(
                          fontSize: 20,
                          color: ColorResources().textColorwhite,
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
                              color: ColorResources().textColorwhite,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          state.data.weather.first.description,
                          style: TextStyle(
                              fontSize: 20,
                              color: ColorResources().textColorwhite,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Humididty',
                      style: TextStyle(color: ColorResources().textColorwhite),
                    ),
                    Text(
                      '${state.data.main?.humidity}',
                      style: TextStyle(
                          color: ColorResources().textColorwhite, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'SW Wind',
                      style: TextStyle(
                        color: ColorResources().textColorwhite,
                      ),
                    ),
                    Text(
                      '${state.data.wind?.speed}',
                      style: TextStyle(
                          color: ColorResources().textColorwhite, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Visibility',
                      style: TextStyle(
                        color: ColorResources().textColorwhite,
                      ),
                    ),
                    Text(
                      '${state.data.visibility}',
                      style: TextStyle(
                          color: ColorResources().textColorwhite, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Air Pressure',
                      style: TextStyle(
                        color: ColorResources().textColorwhite,
                      ),
                    ),
                    Text(
                      '${state.data.main?.pressure}',
                      style: TextStyle(
                          color: ColorResources().textColorwhite, fontSize: 20),
                    )
                  ],
                ));
          } else if (state is WeatherError) {
            return Center(
                child: Text(
              state.error.toString(),
              style: TextStyle(color: ColorResources().textColorwhite),
            ));
          } else {
            return const Center(child: Text("Error No Data :("));
          }
        }));
  }
}
