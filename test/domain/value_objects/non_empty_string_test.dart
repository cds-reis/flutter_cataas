import 'package:flutter_cataas/domain/value_objects/non_empty_string.dart';
import 'package:glados/glados.dart';

void main() {
  test(
    'GIVEN an empty string, THEN must fail the parse AND return null',
    () {
      final result = NonEmptyString.tryParse('');
      expect(result, isNull);
    },
  );
  Glados<String>(any.whiteSpace).test(
    '''
GIVEN a string WITH only whitespace, 
THEN must fail the parse AND return null''',
    (input) {
      expect(NonEmptyString.tryParse(input), isNull);
    },
  );

  Glados<String>(any.nonEmptyLetterOrDigits).test(
    '''
GIVEN a non empty string, THEN must create a [NonEmptyString] WITH the same value''',
    (input) {
      final nes = NonEmptyString.tryParse(input)!;
      expect(
        nes,
        isA<NonEmptyString>()
            .having((nes) => nes.$1, 'the same interior value', input),
      );
    },
  );
}

extension AnyWhiteSpace on Any {
  Generator<String> get whiteSpace {
    return simple(
      generate: (random, size) => ' ' * (random.nextInt(size) + 1),
      shrink: (input) sync* {
        yield input.substring(0, input.length - 1);
      },
    );
  }
}
