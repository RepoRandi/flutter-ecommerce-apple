import 'package:ecommerce_apple/bloc/checkout/checkout_bloc.dart';
import 'package:ecommerce_apple/bloc/get_products/get_products_bloc.dart';
import 'package:ecommerce_apple/data/models/response/list_product_response_model.dart';
import 'package:ecommerce_apple/shared/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListProductWidget extends StatefulWidget {
  const ListProductWidget({super.key});

  @override
  State<ListProductWidget> createState() => _ListProductWidgetState();
}

class _ListProductWidgetState extends State<ListProductWidget> {
  @override
  void initState() {
    context.read<GetProductsBloc>().add(DoGetProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsBloc, GetProductsState>(
      builder: (context, state) {
        if (state is GetProductsError) {
          return const Center(child: Text('Data Error - 502'));
        }
        if (state is GetProductsLoaded) {
          if (state.data.data!.isEmpty) {
            return const Center(
              child: Text('Data Is Empty - 404'),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.60,
            ),
            itemCount: state.data.data!.length,
            itemBuilder: (context, index) {
              final Product product = state.data.data![index];
              return Card(
                elevation: 2,
                shadowColor: primaryColor,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: product.attributes!.image ?? 'image.jpg',
                      child: SizedBox(
                        width: 150,
                        height: 120,
                        child: Image.network(product.attributes!.image ?? ''),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Rp ${product.attributes!.price ?? 0}',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        product.attributes!.name ?? '',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.add_shopping_cart,
                                  size: 20,
                                  color: primaryColor,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Beli",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    size: 18,
                                    color: primaryColor,
                                  ),
                                  onPressed: () {
                                    context.read<CheckoutBloc>().add(
                                        RemoveFromCartEvent(product: product));
                                  },
                                ),
                                BlocBuilder<CheckoutBloc, CheckoutState>(
                                  builder: (context, state) {
                                    if (state is CheckoutLoaded) {
                                      final countItem = state.items
                                          .where((element) =>
                                              element.id == product.id)
                                          .length;
                                      return Text('$countItem');
                                    }
                                    return const Text('0');
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: 18,
                                    color: primaryColor,
                                  ),
                                  onPressed: () {
                                    context
                                        .read<CheckoutBloc>()
                                        .add(AddToCartEvent(product: product));
                                  },
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
