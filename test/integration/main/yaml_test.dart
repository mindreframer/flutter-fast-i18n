import 'package:fast_i18n/src/builder/build_config_builder.dart';
import 'package:fast_i18n/src/builder/translation_map_builder.dart';
import 'package:fast_i18n/src/generator_facade.dart';
import 'package:fast_i18n/src/model/build_config.dart';
import 'package:fast_i18n/src/model/i18n_locale.dart';
import 'package:fast_i18n/src/model/namespace_translation_map.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../util/resources_utils.dart';

void main() {
  late String enInput;
  late String deInput;
  late String buildYaml;
  late String expectedOutput;

  setUp(() {
    enInput = loadResource('main/yaml_en.yaml');
    deInput = loadResource('main/yaml_de.yaml');
    buildYaml = loadResource('main/build_config.yaml');
    expectedOutput = loadResource('main/expected_single.output');
  });

  test('yaml', () {
    final result = GeneratorFacade.generate(
      buildConfig: BuildConfigBuilder.fromYaml(buildYaml)!,
      baseName: 'translations',
      translationMap: NamespaceTranslationMap()
        ..addTranslations(
          locale: I18nLocale.fromString('en'),
          translations: TranslationMapBuilder.fromString(
            FileType.yaml,
            enInput,
          ),
        )
        ..addTranslations(
          locale: I18nLocale.fromString('de'),
          translations: TranslationMapBuilder.fromString(
            FileType.yaml,
            deInput,
          ),
        ),
      showPluralHint: false,
    );

    expect(result.joinAsSingleOutput(), expectedOutput);
  });
}
