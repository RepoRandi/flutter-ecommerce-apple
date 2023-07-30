import 'package:ecommerce_apple/bloc/checkout/checkout_bloc.dart';
import 'package:ecommerce_apple/bloc/get_products/get_products_bloc.dart';
import 'package:ecommerce_apple/data/datasources/product_remote_datasource.dart';
import 'package:ecommerce_apple/presentation/home/home_page.dart';
import 'package:ecommerce_apple/shared/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProductsBloc(ProductDataRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Apple E-Commerce',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
