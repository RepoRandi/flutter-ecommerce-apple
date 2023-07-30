import 'package:dartz/dartz.dart';
import 'package:ecommerce_apple/common/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_apple/data/models/response/list_product_response_model.dart';

class ProductDataRemoteDatasource {
  Future<Either<String, ListProductResponseModel>> getAllProduct() async {
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/products'),
    );

    if (response.statusCode == 200) {
      return Right(ListProductResponseModel.fromRawJson(response.body));
    } else {
      return const Left('Proses Get All Product Gagal!');
    }
  }
}
