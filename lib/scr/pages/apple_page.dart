import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/scr/bloc/apple/apple_bloc.dart';
import 'package:shopping/scr/bloc/count/counter_bloc.dart';
import 'package:shopping/scr/models/brands_model.dart';
import 'package:shopping/scr/pages/cart_page.dart';

class ApplePage extends StatefulWidget {
  const ApplePage({Key? key}) : super(key: key);

  @override
  State<ApplePage> createState() => _ApplePageState();
}

class _ApplePageState extends State<ApplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product : Apple'),
        centerTitle: false,
      ),
      body: BlocBuilder<AppleBloc, AppleState>(
        builder: (context, state) {
          if (state is BrandsLoadingState) {
            //loding
            return const Center(
              child: LinearProgressIndicator(),
            );
            //showData
          } else if (state is AppleLoadingSuccessState) {
            return ListView.builder(
              itemCount: state.apple.length,
              itemBuilder: (context, index) {
                final apple = state.apple[index];
                return Center(
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      height: 90,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 26),
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BlocBuilder<CounterBloc, CounterState>(
                              builder: (context, state) {
                                final count = state.productCounts[apple] ?? 0;
                                //condition of Visibility
                                bool isSelected = count > 0;
                                return Visibility(
                                  visible: isSelected,
                                  //hide box
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child:
                                        //count number
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
                              apple.image,
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                        title: Text(apple.name),
                        subtitle: Text('ราคา : ${apple.price.toString()}'),
                        // add buttom
                        trailing: GestureDetector(
                          onTap: () {
                            BlocProvider.of<CounterBloc>(context)
                                .add(AddProductEvent(apple));
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
                    //sum of count number
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
              //cart
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
                          //แก้ productCounts เป็น null
                          //ใช้ Map<BrandDataModel, int>? ในการประกาศ productCounts เพื่อรองรับค่า null
                          final Map<BrandDataModel, int>? productCounts =
                              BlocProvider.of<CounterBloc>(context)
                                  .state
                                  .productCounts;
                          if (productCounts != null) {
                            final List<BrandDataModel> brandDataModels =
                                productCounts.keys.toList();
                            //total
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
