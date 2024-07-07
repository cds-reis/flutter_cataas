import 'package:anyhow/base.dart';

import '../entities/cat.dart';
import '../failures/app_failure.dart';
import '../value_objects/cat_amount.dart';
import '../value_objects/cat_request.dart';
import '../value_objects/cat_tag.dart';

abstract interface class RemoteRepository {
  FutureResult<Cat, AppFailure> getCat(CatRequest request);
  FutureResult<CatTags, AppFailure> getTags();
  FutureResult<CatAmount, AppFailure> getCatAmount();
}
