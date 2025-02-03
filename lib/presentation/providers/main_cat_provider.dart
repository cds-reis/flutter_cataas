import 'package:anyhow/anyhow.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/cat.dart';
import '../../domain/value_objects/cat_identifier.dart';
import '../../domain/value_objects/cat_request.dart';
import '../../domain/value_objects/cat_text.dart';
import 'cat_request_provider.dart';
import 'project_providers.dart';

part 'main_cat_provider.g.dart';

@riverpod
class MainCat extends _$MainCat {
  @override
  Raw<FutureResult<Cat?>> build() {
    final repository = ref.watch(remoteRepositoryProvider);

    return repository.getCat(
      const CatRequest(
        identifier: NoIdentifier(),
        text: CatText(
          text: 'Hello again!',
          fontColor: FontColor.white,
        ),
      ),
    );
  }

  void getCat() {
    final repository = ref.read(remoteRepositoryProvider);

    state = repository.getCat(ref.read(catRequestProvider));
  }
}
