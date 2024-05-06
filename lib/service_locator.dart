import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/interceptors/logger_interceptor.dart';
import 'data/repositories/dio_remote_repository.dart';
import 'data/repositories/shared_preferences_local_repository.dart';
import 'domain/repositories/local_repository.dart';
import 'domain/repositories/remote_repository.dart';
import 'domain/usecases/get_cat_amount_use_case.dart';
import 'domain/usecases/get_cat_use_case.dart';
import 'domain/usecases/get_tags_use_case.dart';
import 'presentation/cubit/main_cat_cubit/main_cat_cubit.dart';

final sl = _initializeServiceLocator();

GetIt _initializeServiceLocator() {
  final i = GetIt.I;

  i

    // Repositories
    ..registerLazySingleton<LocalRepository>(
      SharedPreferencesLocalRepository.new,
    )
    ..registerLazySingleton<RemoteRepository>(
      () {
        final dio = Dio();

        dio.interceptors.add(loggerInterceptor);

        return DioRemoteRepository(dio);
      },
    )

    // Usecases
    ..registerLazySingleton<GetCatUseCase>(
      () => GetCatUseCase(remoteRepository: i()),
    )
    ..registerLazySingleton<GetCatAmountUseCase>(
      () => GetCatAmountUseCase(localRepository: i(), remoteRepository: i()),
    )
    ..registerLazySingleton<GetTagsUseCase>(
      () => GetTagsUseCase(localRepository: i(), remoteRepository: i()),
    )

    // Presenters
    ..registerLazySingleton<MainCatCubit>(() => MainCatCubit(i()));

  return i;
}
