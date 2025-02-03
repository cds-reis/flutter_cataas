import 'dart:typed_data';

import 'package:anyhow/anyhow.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/cat.dart';
import '../../domain/extensions/map_extensions.dart';
import '../../domain/failures/app_failure.dart';
import '../../domain/repositories/remote_repository.dart';
import '../../domain/value_objects/cat_amount.dart';
import '../../domain/value_objects/cat_filter.dart';
import '../../domain/value_objects/cat_identifier.dart';
import '../../domain/value_objects/cat_request.dart';
import '../../domain/value_objects/cat_tag.dart';
import '../../domain/value_objects/cat_text.dart';
import '../../domain/value_objects/positive_int.dart';
import '../dtos/cat_id_with_tags.dart';

final class DioRemoteRepository implements RemoteRepository {
  const DioRemoteRepository(this._dio);

  final Dio _dio;

  static const String _catUrl = 'https://cataas.com/cat';

  @override
  FutureResult<Cat?> getCat(CatRequest request) {
    return Result.async(($) async {
      final catIdWithTags = await _getCatJson(request.identifier)[$];

      if (catIdWithTags == null) {
        return const Ok(null);
      }

      final bytes = await _getCatBytes(
        catId: catIdWithTags.id,
        request: request,
      )[$];

      final cat = Cat(
        id: catIdWithTags.id,
        tags: catIdWithTags.tags,
        image: bytes,
        text: request.text,
        filter: request.filter,
      );

      return Ok(cat);
    });
  }

  FutureResult<CatIdWithTags?> _getCatJson(CatIdentifier identifier) async {
    try {
      final identifierPath = _buildIdentifier(identifier);
      final path = '$_catUrl$identifierPath';
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: {'json': true},
      );

      return _parseCatJson(response.data);
    } on DioException catch (e, st) {
      switch (e.response?.statusCode) {
        case null:
          return bail(e, st);
        case 404:
          return const Ok(null);
        default:
          return bail(e, st);
      }
    }
  }

  Result<CatIdWithTags> _parseCatJson(Map<String, dynamic>? json) {
    if (json case {'tags': final List<dynamic> tags, '_id': final String id}) {
      final catTags = tags.whereType<String>().map(CatTag.fromString).nonNulls;

      final catIdWithTags = CatIdWithTags(id: CatId(id), tags: catTags);

      return Ok(catIdWithTags);
    } else {
      return bail(ParseFailure(json));
    }
  }

  FutureResult<Uint8List> _getCatBytes({
    required CatId catId,
    required CatRequest request,
  }) async {
    try {
      final identifier = _buildIdentifier(catId);
      final (textComplement, textParams) = _buildText(request.text);
      final filterParams = _buildFilter(request.filter);

      final uri = '$_catUrl$identifier$textComplement';
      final result = await _dio.get<Uint8List>(
        uri,
        queryParameters: {
          ...textParams,
          ...filterParams,
        },
        options: Options(responseType: ResponseType.bytes),
      );
      if (result.data case final data?) {
        return Ok(data);
      } else {
        return bail(const ParseFailure(null));
      }
    } catch (e, st) {
      return bail(e, st);
    }
  }

  String _buildIdentifier(CatIdentifier identifier) {
    return switch (identifier) {
      CatId($1: final catId) => '/$catId',
      Tags($1: final tags) => '/${tags.iter().map((e) => e.$1).join(',')}',
      NoIdentifier() => '',
    };
  }

  (String, Map<String, String>) _buildText(CatText? catText) {
    if (catText == null || catText.text.isEmpty) {
      return ('', {});
    }

    final complement = '/says/${catText.text}';
    final params = {
      'fontSize': catText.fontSize?.$1.toString(),
      'fontColor': catText.fontColor?.name,
    }.nonNulls;

    return (complement, params);
  }

  Map<String, String> _buildFilter(CatFilter? filter) {
    return switch (filter) {
      Mono() => {'filter': 'mono'},
      Negate() => {'filter': 'negate'},
      Custom(
        :final brightness,
        :final saturation,
        :final hue,
        :final lightness,
        :final rgb,
      ) =>
        {
          'filter': 'custom',
          'brightness': brightness?.$1.toString(),
          'saturation': saturation?.$1.toString(),
          'lightness': lightness?.$1.toString(),
          'hue': hue?.$1.toString(),
          'r': rgb?.$1.r.toString(),
          'g': rgb?.$1.g.toString(),
          'b': rgb?.$1.b.toString(),
        }.nonNulls,
      null => {},
    };
  }

  @override
  FutureResult<CatAmount> getCatAmount() {
    return Result.async(
      ($) async {
        final amountJson = await _getCatAmountJson()[$];
        return _parseCatAmountJson(amountJson);
      },
    );
  }

  FutureResult<Map<String, dynamic>?> _getCatAmountJson() async {
    try {
      final result = await _dio.get<Map<String, dynamic>>(
        'https://cataas.com/api/count',
      );

      return Ok(result.data);
    } catch (e, st) {
      return bail(e, st);
    }
  }

  Result<CatAmount> _parseCatAmountJson(Map<String, dynamic>? json) {
    return Result(($) {
      if (json case {'count': final int count}) {
        return PositiveInt.tryParse(count).map(CatAmount.new).okOrElse(
              () => anyhow<PositiveInt>(ParseFailure(count)),
            );
      }

      return bail(ParseFailure(json));
    });
  }

  @override
  FutureResult<CatTags> getTags() async {
    try {
      final response = await _dio.get<List<dynamic>>(
        'https://cataas.com/api/tags',
      );

      final data = response.data?.whereType<String>() ?? const Iterable.empty();

      final tags = data.map(CatTag.fromString).nonNulls;

      return Ok(tags);
    } catch (e, st) {
      return bail(e, st);
    }
  }
}
