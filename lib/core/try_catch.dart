import 'dart:async';

import 'package:anyhow/base.dart';

Result<T, E> tryCatch<T, E extends Object>(
  T Function() thunk,
  E Function(Object e, StackTrace st) onError,
) {
  try {
    return Ok(thunk());
  } catch (e, st) {
    return Err(onError(e, st));
  }
}

FutureResult<T, E> futureTryCatch<T, E extends Object>(
  FutureOr<T> Function() thunk,
  FutureOr<E> Function(Object e, StackTrace st) onError,
) async {
  try {
    return Ok(await thunk());
  } catch (e, st) {
    return Err(await onError(e, st));
  }
}
