import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

final Interceptor loggerInterceptor = TalkerDioLogger(
  settings: TalkerDioLoggerSettings(
    responseFilter: (Response<dynamic> response) {
      return response.requestOptions.responseType != ResponseType.bytes;
    },
  ),
);
