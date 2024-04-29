import 'package:flutter_cataas/domain/value_objects/positive_int.dart';
import 'package:glados/glados.dart';

void main() {
  Glados<int>(any.positiveInt).test(
    'GIVEN any positive int, THEN must parse PositiveInt successfully',
    (input) {
      expect(
        PositiveInt.tryParse(input),
        isA<PositiveInt>()
            .having((pi) => pi.$1, 'the same internal value', input),
      );
    },
  );
  Glados<int>(any.negativeIntOrZero).test(
    'GIVEN any negative int or zero, THEN must FAIL the parse to PositiveInt',
    (input) {
      expect(
        PositiveInt.tryParse(input),
        isNull,
      );
    },
  );
}
