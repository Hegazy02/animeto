import 'package:animeto/constants/strings.dart';
import 'package:dio/dio.dart';

class DioApi {
  late Dio dio;
  int a = 2;
  DioApi() {
    //مينفعش حاجه لسه معرفها في الكلاس استخدمها جوا الكلاس
    //لازم اعرف الحاجه دي جوا الكونتسراكتور عشان هو اول حاجه بتتبني فبالتالي هقدر استخدم الحاجه دي جوا الكلاس عشان هي اول حاجه هتتعرف
    BaseOptions options = BaseOptions(
      baseUrl: baseurl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }
  Future<dynamic> get(String endPoint) async {
    try {
      Response response = await dio.get(endPoint);
      dio.interceptors.add(LogInterceptor(
          error: true,
          request: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true));

      return response.data['data'];
    } catch (e) {
      return [];
    }
  }
}
