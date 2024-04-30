import 'package:anyhow/base.dart';

import '../entities/cat.dart';
import '../failures/app_failure.dart';
import '../repositories/remote_repository.dart';
import '../value_objects/cat_request.dart';

class GetCatUseCase {
  const GetCatUseCase({required RemoteRepository remoteRepository})
      : _remoteRepository = remoteRepository;

  final RemoteRepository _remoteRepository;

  FutureResult<Cat, AppFailure> call(CatRequest request) async {
    return _remoteRepository.getCat(request);
  }
}
