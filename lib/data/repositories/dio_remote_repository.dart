import 'package:anyhow/base.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/cat.dart';
import '../../domain/failures/app_failure.dart';
import '../../domain/repositories/remote_repository.dart';
import '../../domain/value_objects/cat_amount.dart';
import '../../domain/value_objects/cat_request.dart';
import '../../domain/value_objects/cat_tag.dart';
import '../../domain/value_objects/positive_int.dart';

final class DioRemoteRepository implements RemoteRepository {
  const DioRemoteRepository(this._dio);

  final Dio _dio;

  @override
  FutureResult<Cat, AppFailure> getCat(CatRequest request) {
    throw UnimplementedError();
  }

  @override
  FutureResult<CatAmount, AppFailure> getCatAmount() async => Result.async(
        ($) async {
          final amountJson = await _getCatAmountJson()[$];
          return _parseCatJson(amountJson);
        },
      );

  FutureResult<Map<String, dynamic>?, AppFailure> _getCatAmountJson() async {
    try {
      final result = await _dio.get<Map<String, dynamic>>(
        'https://cataas.com/api/count',
      );

      return Ok(result.data);
    } catch (e) {
      return const Err(ApiCallFailure());
    }
  }

  Result<CatAmount, AppFailure> _parseCatJson(Map<String, dynamic>? json) {
    return Result(
      ($) {
        if (json case {'count': final int count}) {
          final positiveInt = PositiveInt.tryParse(count).map(CatAmount.new);
        }

        return const Err(ParseFailure());
      },
    );
  }

  @override
  FutureResult<Iterable<CatTag>, AppFailure> getTags() {
    throw UnimplementedError();
  }
}
