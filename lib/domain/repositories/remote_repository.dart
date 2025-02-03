import 'package:anyhow/anyhow.dart';

import '../entities/cat.dart';
import '../value_objects/cat_amount.dart';
import '../value_objects/cat_request.dart';
import '../value_objects/cat_tag.dart';

abstract interface class RemoteRepository {
  FutureResult<Cat?> getCat(CatRequest request);
  FutureResult<CatTags> getTags();
  FutureResult<CatAmount> getCatAmount();
}
