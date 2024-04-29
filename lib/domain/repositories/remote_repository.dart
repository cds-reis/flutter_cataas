import 'package:anyhow/base.dart';

import '../entities/cat.dart';
import '../failures/api_call_failure.dart';
import '../value_objects/cat_amount.dart';
import '../value_objects/cat_request.dart';
import '../value_objects/cat_tag.dart';

abstract interface class RemoteRepository {
  FutureResult<Cat, AppFailure> getCat(CatRequest request);
  FutureResult<Iterable<CatTag>, AppFailure> getTags();
  FutureResult<CatAmount, AppFailure> getCatAmount();
}
