import 'package:anyhow/anyhow.dart';
import 'package:collection/collection.dart';

import '../repositories/remote_repository.dart';
import '../value_objects/cat_tag.dart';

class GetTagsUseCase {
  const GetTagsUseCase({
    required RemoteRepository remoteRepository,
  }) : _remoteRepository = remoteRepository;

  final RemoteRepository _remoteRepository;

  FutureResult<CatTags> call() {
    return Result.async(($) async {
      final tags = await _remoteRepository.getTags()[$];

      final filtered = tags
          .map((tag) => tag.toLowerCase())
          .toSet()
          .sorted((a, b) => a.$1.compareTo(b.$1));

      return Ok(filtered);
    });
  }
}
