import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/scr/bloc/brands/brands_bloc.dart';
import 'package:shopping/scr/pages/cart_page.dart';
import 'package:shopping/scr/pages/samsung_page.dart';

import 'apple_page.dart';

class Brand extends StatefulWidget {
  const Brand({Key? key}) : super(key: key);

  @override
  State<Brand> createState() => _BrandState();
}

class _BrandState extends State<Brand> {
  final BrandsBloc brandsBloc = BrandsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Brand'),
          ],
        ),
      ),
      body: BlocBuilder<BrandsBloc, BrandsState>(builder: (context, state) {
        if (state is BrandsLoadingState) {
          return Column(
            children: const [
              (LinearProgressIndicator()),
              Text(
                'Loading...',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          );
        } else if (state is BrnadsLoadingSuccessState) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.brands.length,
            itemBuilder: (context, index) {
              final brand = state.brands[index];
              return Center(
                child: Card(
                  color: Colors.blue,
                  margin: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 26),
                        leading: Image.network(brand.logo),
                        title: Text(
                          brand.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          if (brand.name == 'Apple') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ApplePage(),
                              ),
                            );
                          } else if (brand.name == 'Samsung') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SamsungPage(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartPage(
                productCounts: [],
                totalPrice: 0,
              ),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart_outlined),
      ),
    );
  }
}
