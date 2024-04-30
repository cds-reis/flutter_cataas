import 'package:anyhow/base.dart';

import '../../data/dtos/cached_cat_amount.dart';
import '../failures/app_failure.dart';
import '../repositories/local_repository.dart';
import '../repositories/remote_repository.dart';
import '../value_objects/cat_amount.dart';

class GetCatAmountUseCase {
  const GetCatAmountUseCase({
    required LocalRepository localRepository,
    required RemoteRepository remoteRepository,
  })  : _localRepository = localRepository,
        _remoteRepository = remoteRepository;

  final LocalRepository _localRepository;
  final RemoteRepository _remoteRepository;

  FutureResult<CatAmount, AppFailure> call(DateTime now) async => Result.async(
        ($) async {
          final amount = await _getAmount(now)[$];

          await _localRepository.updateCatAmount(amount);

          return Ok(amount);
        },
      );

  FutureResult<CatAmount, AppFailure> _getAmount(DateTime now) {
    return _getCatAmountFromCache(now)
        .orElse((_) => _remoteRepository.getCatAmount());
  }

  FutureResult<CatAmount, AppFailure> _getCatAmountFromCache(DateTime now) {
    return Result.async(
      ($) async {
        final cache = await _getLocalCatAmount()[$];
        final isCacheExpired = now.difference(cache.cachedTime).inDays > 1;
        if (isCacheExpired) {
          return const Err(ExpiredCacheFailure());
        }

        return Ok(cache.amount);
      },
    );
  }

  FutureResult<CachedCatAmount, AppFailure> _getLocalCatAmount() =>
      _localRepository.getCatAmount();
}
