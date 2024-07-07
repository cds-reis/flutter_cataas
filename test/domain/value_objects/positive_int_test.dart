import 'package:anyhow/base.dart';
import 'package:flutter_cataas/domain/failures/app_failure.dart';
import 'package:flutter_cataas/domain/value_objects/positive_int.dart';
import 'package:glados/glados.dart';

void main() {
  final config = ExploreConfig(numRuns: 10000000);

  Glados<int>(any.positiveInt, config).test(
    'GIVEN any positive int, THEN must parse PositiveInt successfully',
    (input) {
      expect(
        PositiveInt.tryParse(input),
        isA<Ok<PositiveInt, ParseFailure>>()
            .having((pi) => pi.ok.$1, 'the same internal value', input),
      );
    },
  );
  Glados<int>(any.negativeIntOrZero, config).test(
    'GIVEN any negative int or zero, THEN must FAIL the parse to PositiveInt',
    (input) {
      expect(
        PositiveInt.tryParse(input),
        isA<Err<PositiveInt, ParseFailure>>(),
      );
    },
  );
}
