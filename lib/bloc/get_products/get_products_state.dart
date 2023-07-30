part of 'get_products_bloc.dart';

abstract class GetProductsState {}

class GetProductsInitial extends GetProductsState {}

class GetProductsLoading extends GetProductsState {}

class GetProductsLoaded extends GetProductsState {
  ListProductResponseModel data;
  GetProductsLoaded({
    required this.data,
  });

  @override
  bool operator ==(covariant GetProductsLoaded other) {
    if (identical(this, other)) return true;

    return other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

class GetProductsError extends GetProductsState {}
