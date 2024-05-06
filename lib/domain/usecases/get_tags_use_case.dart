import 'package:anyhow/base.dart';

import '../../data/dtos/cached_cat_tags.dart';
import '../failures/app_failure.dart';
import '../repositories/local_repository.dart';
import '../repositories/remote_repository.dart';
import '../value_objects/cat_tag.dart';

typedef CatTags = Iterable<CatTag>;

class GetTagsUseCase {
  const GetTagsUseCase({
    required LocalRepository localRepository,
    required RemoteRepository remoteRepository,
  })  : _localRepository = localRepository,
        _remoteRepository = remoteRepository;

  final LocalRepository _localRepository;
  final RemoteRepository _remoteRepository;

  FutureResult<CatTags, AppFailure> call(DateTime now) =>
      _getTagsFromCache(now).orElse(
        (_) => Result.async(
          ($) async {
            final tags = await _remoteRepository.getTags()[$];

            await _localRepository.updateCatTags(tags);

            return Ok(tags);
          },
        ),
      );

  FutureResult<CatTags, CacheFailure> _getTagsFromCache(DateTime now) {
    return Result.async(
      ($) async {
        final cache = await _getLocalTags()[$];
        final isCacheExpired = now.difference(cache.cachedTime).inDays > 1;
        if (isCacheExpired) {
          return const Err(ExpiredCacheFailure());
        }

        return Ok(cache.tags.iter());
      },
    );
  }

  FutureResult<CachedCatTags, AppFailure> _getLocalTags() =>
      _localRepository.getCatTags();
}
