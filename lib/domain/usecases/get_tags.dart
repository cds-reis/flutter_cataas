import 'package:anyhow/base.dart';

import '../entities/cached_cat_tags.dart';
import '../failures/api_call_failure.dart';
import '../repositories/local_repository.dart';
import '../repositories/remote_repository.dart';
import '../value_objects/cat_tag.dart';

class GetTags {
  const GetTags({
    required LocalRepository localRepository,
    required RemoteRepository remoteRepository,
  })  : _localRepository = localRepository,
        _remoteRepository = remoteRepository;

  final LocalRepository _localRepository;
  final RemoteRepository _remoteRepository;

  FutureResult<Iterable<CatTag>, AppFailure> call(DateTime now) async =>
      Result.async(
        ($) async {
          final tags = await _getTags(now)[$];

          await _localRepository.updateCatTags(tags);

          return Ok(tags);
        },
      );

  FutureResult<Iterable<CatTag>, AppFailure> _getTags(DateTime now) {
    return _getTagsFromCache(now).orElse((_) => _remoteRepository.getTags());
  }

  FutureResult<Iterable<CatTag>, AppFailure> _getTagsFromCache(DateTime now) {
    return Result.async(
      ($) async {
        final cache = await _getLocalTags()[$];
        final isCacheExpired = now.difference(cache.cachedTime).inDays > 1;
        if (isCacheExpired) {
          return const Err(CacheFailure());
        }

        return Ok(cache.tags.iter());
      },
    );
  }

  FutureResult<CachedCatTags, AppFailure> _getLocalTags() =>
      _localRepository.getCatTags();
}
