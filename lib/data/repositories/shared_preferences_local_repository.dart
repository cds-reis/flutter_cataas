import 'package:anyhow/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/failures/app_failure.dart';
import '../../domain/repositories/local_repository.dart';
import '../../domain/value_objects/cached_time.dart';
import '../../domain/value_objects/cat_amount.dart';
import '../../domain/value_objects/cat_tag.dart';
import '../../domain/value_objects/non_empty_list.dart';
import '../../domain/value_objects/non_empty_string.dart';
import '../../domain/value_objects/positive_int.dart';
import '../dtos/cached_cat_amount.dart';
import '../dtos/cached_cat_tags.dart';

final class SharedPreferencesLocalRepository implements LocalRepository {
  static const String _amountKey = 'cat_amount';
  static const String _amountUpdatedAtKey = 'cat_amount_updated_at';

  static const String _tagsKey = 'cat_tags';
  static const String _tagsUpdatedAtKey = 'cat_tags_updated_at';

  @override
  FutureResult<CachedCatAmount, CacheFailure> getCatAmount() {
    return Result.async(
      ($) async {
        final cachedAmount =
            await _getFromCache((prefs) => prefs.getInt(_amountKey))[$];

        final positive = PositiveInt.tryParse(cachedAmount)
            .mapErr<CacheFailure>((_) => const InvalidCacheFailure())[$];

        final amount = CatAmount(positive);

        final updatedAt = await _getFromCache(
          (prefs) => prefs.getString(_amountUpdatedAtKey),
        ).andThen(_toDateTime).map(CachedTime.new)[$];

        return Ok(
          CachedCatAmount(
            amount: amount,
            cachedTime: updatedAt,
          ),
        );
      },
    );
  }

  @override
  FutureResult<CachedCatTags, CacheFailure> getCatTags() {
    return Result.async(
      ($) async {
        final cachedTags =
            await _getFromCache((prefs) => prefs.getStringList(_tagsKey))[$];

        final nonEmptyTags =
            cachedTags.map(NonEmptyString.tryParse).nonNulls.map(CatTag.new);

        final tags = NonEmptyList.fromIterable(nonEmptyTags)
            .mapErr<CacheFailure>((_) => const EmptyCacheFailure())[$];

        final updatedAt = await _getFromCache(
          (prefs) => prefs.getString(_tagsUpdatedAtKey),
        ).andThen(_toDateTime).map(CachedTime.new)[$];

        return Ok(
          CachedCatTags(
            tags: tags,
            cachedTime: updatedAt,
          ),
        );
      },
    );
  }

  @override
  FutureResult<Unit, CacheFailure> updateCatAmount(CatAmount amount) {
    return Result.async(
      ($) async {
        final prefs = await _instance[$];
        await prefs.setInt(_amountKey, amount.$1);
        await prefs.setString(_amountUpdatedAtKey, DateTime.now().toString());

        return const Ok(());
      },
    );
  }

  @override
  FutureResult<Unit, CacheFailure> updateCatTags(Iterable<CatTag> tags) {
    return Result.async(
      ($) async {
        final prefs = await _instance[$];
        final cacheTags = tags.map((tag) => tag.$1).toList();
        await prefs.setStringList(_tagsKey, cacheTags);
        await prefs.setString(_tagsUpdatedAtKey, DateTime.now().toString());

        return const Ok(());
      },
    );
  }

  FutureResult<SharedPreferences, CacheFailure> get _instance async {
    try {
      return Ok(await SharedPreferences.getInstance());
    } catch (e, st) {
      return Err(CacheLoadFailure(error: e, stackTrace: st));
    }
  }

  FutureResult<T, CacheFailure> _getFromCache<T>(
    T? Function(SharedPreferences prefs) get,
  ) {
    return Result.async(
      ($) async {
        final prefs = await _instance[$];
        final value = get(prefs);
        if (value == null) {
          return const Err(EmptyCacheFailure());
        }

        return Ok(value);
      },
    );
  }
}

Result<DateTime, CacheFailure> _toDateTime(String value) {
  final result = DateTime.tryParse(value);

  return switch (result) {
    DateTime() => Ok(result),
    null => const Err(InvalidCacheFailure()),
  };
}
