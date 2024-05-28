import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/scr/bloc/count/counter_bloc.dart';
import 'package:shopping/scr/bloc/samsung/samsung_bloc.dart';
import 'package:shopping/scr/models/brands_model.dart';
import 'package:shopping/scr/pages/cart_page.dart';

class SamsungPage extends StatefulWidget {
  const SamsungPage({Key? key}) : super(key: key);

  @override
  State<SamsungPage> createState() => _SamsungPageState();
}

class _SamsungPageState extends State<SamsungPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product : Samsung'),
        centerTitle: false,
      ),
      body: BlocBuilder<SamsungBloc, SamsungState>(
        builder: (context, state) {
          if (state is BrandsLoadingState) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          } else if (state is SamsungLoadingSuccessState) {
            return ListView.builder(
              itemCount: state.samsung.length,
              itemBuilder: (context, index) {
                final samsung = state.samsung[index];
                return Center(
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: SizedBox(
                      height: 90,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        // leading: Image.network(apple.image),
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BlocBuilder<CounterBloc, CounterState>(
                              builder: (context, state) {
                                final count = state.productCounts[samsung] ?? 0;
                                bool isSelected = count > 0;
                                return Visibility(
                                  visible: isSelected,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child:
                                        BlocBuilder<CounterBloc, CounterState>(
                                      builder: (context, state) {
                                        return Text(
                                          count.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        );
                                      },
                                    ),
                                  ),
                                  replacement: const SizedBox(
                                    width: 30,
                                    height: 30,
                                  ),
                                );
                              },
                            ),
                            Image.network(
                              samsung.image,
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                        title: Text(samsung.name),
                        subtitle: Text('ราคา : ${samsung.price.toString()}'),
                        trailing: GestureDetector(
                          onTap: () {
                            BlocProvider.of<CounterBloc>(context)
                                .add(AddProductEvent(samsung));
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                            ),
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomAppBar(
          child: Row(
            children: [
              Expanded(
                child: Center(child: BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, state) {
                    int totalItems = state.productCounts.values
                        .fold(0, (sum, count) => sum + (count as int));
                    return Text(
                      state.productCounts.isEmpty
                          ? "ไม่มีสินค้าในตระกร้า"
                          : "มีสินค้าในตระกร้า $totalItems ชิ้น",
                      style: TextStyle(
                        fontSize: 16,
                        color: state.productCounts.isEmpty
                            ? Colors.red
                            : Colors.green,
                      ),
                    );
                  },
                )),
              ),
              Container(
                color: Colors.orange,
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 46.0, top: 12, left: 50),
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                          size: 35.0,
                        ),
                        onPressed: () {
                          final Map<BrandDataModel, int>? productCounts =
                              BlocProvider.of<CounterBloc>(context)
                                  .state
                                  .productCounts;
                          if (productCounts != null) {
                            final List<BrandDataModel> brandDataModels =
                                productCounts.keys.toList();
                            int totalPrice = 0;
                            productCounts.forEach((product, count) {
                              totalPrice += product.price * count;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartPage(
                                  productCounts: brandDataModels,
                                  totalPrice: totalPrice,
                                ),
                              ),
                            );
                          } else {
                            // productCounts ต้องเป็นชนิดข้อมูลเดียวกัน brandDataModels
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
