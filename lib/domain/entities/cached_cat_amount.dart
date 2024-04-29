import 'package:equatable/equatable.dart';

import '../value_objects/cached_time.dart';
import '../value_objects/cat_amount.dart';

final class CachedCatAmount extends Equatable {
  const CachedCatAmount({required this.amount, required this.cachedTime});

  final CatAmount amount;
  final CachedTime cachedTime;

  @override
  List<Object?> get props => [amount, cachedTime];
}
