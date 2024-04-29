import 'package:anyhow/base.dart';

import '../entities/cached_cat_amount.dart';
import '../entities/cached_cat_tags.dart';
import '../failures/api_call_failure.dart';
import '../value_objects/cat_amount.dart';
import '../value_objects/cat_tag.dart';

abstract interface class LocalRepository {
  FutureResult<CachedCatAmount, CacheFailure> getCatAmount();
  FutureResult<Unit, CacheFailure> updateCatAmount(CatAmount amount);

  FutureResult<CachedCatTags, CacheFailure> getCatTags();
  FutureResult<Unit, CacheFailure> updateCatTags(Iterable<CatTag> tags);
}
