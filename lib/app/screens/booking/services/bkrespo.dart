import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truff_majestic/app/core/services/api_endpoints.dart';
import 'package:truff_majestic/app/core/services/dio_error_exce.dart';
import 'package:truff_majestic/app/screens/booking/model/allreadybboked.dart';
import 'package:truff_majestic/app/screens/booking/model/bkmodel.dart';

class BookTurfService {
  static final Dio dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));
  Future<AlreadyBookedResponse?> getBookingList({required String id}) async {
    try {
      Response response = await dio.get(EndPoints.bookingDetail + id.trim());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return AlreadyBookedResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      final errorMsg = DioException.fromDioError(e).toString();
      Fluttertoast.showToast(msg: errorMsg);
    }

    return null;
  }

  static Future<BookedResponse?> bookTurf(
      {required BookedRequest model}) async {
    try {
      final Response response =
          await dio.post(EndPoints.bookTurf, data: model.toJson());
      log(response.data.toString());
      if (response.statusCode == 200) {
        return BookedResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      final errorMsg = DioException.fromDioError(e).toString();
      Fluttertoast.showToast(msg: errorMsg);
    }
    return null;
  }
}
