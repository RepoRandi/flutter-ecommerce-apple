import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_apple/data/datasources/product_remote_datasource.dart';
import 'package:ecommerce_apple/data/models/response/list_product_response_model.dart';

part 'get_products_event.dart';
part 'get_products_state.dart';

class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  final ProductDataRemoteDatasource datasource;

  GetProductsBloc(
    this.datasource,
  ) : super(GetProductsInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(GetProductsLoading());
      final result = await datasource.getAllProduct();
      result.fold(
        (l) => emit(GetProductsError()),
        (r) => emit(GetProductsLoaded(data: r)),
      );
    });
  }
}
