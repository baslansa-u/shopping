import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/scr/bloc/apple/apple_bloc.dart';
import 'package:shopping/scr/bloc/brands/brands_bloc.dart';
import 'package:shopping/scr/bloc/count/counter_bloc.dart';
import 'package:shopping/scr/bloc/samsung/samsung_bloc.dart';
import 'package:shopping/scr/bloc/select/select_bloc.dart';
import 'package:shopping/scr/pages/brand_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BrandsBloc()..add(BrandsInitialFetcth()),
        ),
        BlocProvider(
          create: (context) => AppleBloc()..add(AppleInitialFetch()),
        ),
        BlocProvider(
          create: (context) => SelectBloc(),
        ),
        BlocProvider(
          create: (context) => SamsungBloc()..add(SamsungInitialFetch()),
        ),
        BlocProvider(
          create: (context) => CounterBloc(),
        ),
      ],
      child: const MaterialApp(
        home: Brand(),
      ),
    );
  }
}
