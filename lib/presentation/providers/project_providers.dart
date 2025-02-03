import 'package:anyhow/anyhow.dart';
import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../../data/repositories/dio_remote_repository.dart';
import '../../domain/repositories/remote_repository.dart';
import '../../domain/usecases/get_tags_use_case.dart';
import '../../domain/value_objects/cat_tag.dart';

part 'project_providers.g.dart';

@riverpod
Dio _dio(Ref ref) {
  return Dio()
    ..interceptors.add(
      TalkerDioLogger(
        settings: TalkerDioLoggerSettings(
          responseFilter: (response) {
            return response.requestOptions.responseType != ResponseType.bytes;
          },
        ),
        talker: ref.watch(talkerProvider),
      ),
    );
}

@riverpod
RemoteRepository remoteRepository(Ref ref) {
  return DioRemoteRepository(ref.read(_dioProvider));
}

@riverpod
GetTagsUseCase getTagsUseCase(Ref ref) {
  return GetTagsUseCase(remoteRepository: ref.read(remoteRepositoryProvider));
}

@riverpod
Raw<Future<IList<CatTag>>> catTags(Ref ref) {
  final useCase = ref.watch(getTagsUseCaseProvider);

  return useCase().map((tags) => tags.toIList()).unwrapOr(const IListConst([]));
}

@riverpod
Talker talker(Ref ref) {
  return Talker();
}
