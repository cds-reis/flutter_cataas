import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/value_objects/cat_filter.dart';
import 'project_providers.dart';

part 'cat_filter_providers.g.dart';

@riverpod
class CatFilterNotifier extends _$CatFilterNotifier {
  @override
  CatFilter? build() => null;

  void changeFilter(CatFilter? filter) {
    ref.read(talkerProvider).info('User submitted new cat filter: $filter');
    state = filter;
  }
}
