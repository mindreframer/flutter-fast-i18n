import 'package:fast_i18n/src/model/build_config.dart';
import 'package:fast_i18n/src/model/context_type.dart';
import 'package:fast_i18n/src/model/i18n_locale.dart';
import 'package:fast_i18n/src/model/interface.dart';
import 'package:fast_i18n/src/model/pluralization.dart';

/// general config, applies to all locales
class I18nConfig {
  final String baseName; // name of all i18n files, like strings or messages
  final I18nLocale baseLocale; // defaults to 'en'
  final FallbackStrategy fallbackStrategy;
  final OutputFormat outputFormat;
  final bool renderLocaleHandling;
  final Map<String, RuleSet> renderedCardinalResolvers;
  final Map<String, RuleSet> renderedOrdinalResolvers;
  final Set<String> unsupportedPluralLanguages; // resolvers needed
  final String translateVariable;
  final String enumName;
  final TranslationClassVisibility translationClassVisibility;
  final bool renderFlatMap;
  final bool renderTimestamp;
  final List<ContextType> contexts;
  final List<Interface> interface; // may include more than in build config

  I18nConfig({
    required this.baseName,
    required this.baseLocale,
    required this.fallbackStrategy,
    required this.outputFormat,
    required this.renderLocaleHandling,
    required this.renderedCardinalResolvers,
    required this.renderedOrdinalResolvers,
    required this.unsupportedPluralLanguages,
    required this.translateVariable,
    required this.enumName,
    required this.translationClassVisibility,
    required this.renderFlatMap,
    required this.renderTimestamp,
    required this.contexts,
    required this.interface,
  });

  Set<String> getRenderedPluralResolvers() {
    return (renderedCardinalResolvers.keys.toList() +
            renderedOrdinalResolvers.keys.toList())
        .toSet();
  }

  bool hasPluralResolver(String language) {
    return renderedCardinalResolvers[language] != null ||
        renderedOrdinalResolvers[language] != null;
  }

  bool hasPlurals() {
    return renderedCardinalResolvers.isNotEmpty ||
        renderedOrdinalResolvers.isNotEmpty ||
        unsupportedPluralLanguages.isNotEmpty;
  }
}
