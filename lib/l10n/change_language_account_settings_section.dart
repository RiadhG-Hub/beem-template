import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:momra/core/theme/colors.dart';
import 'package:momra/core/theme/styles.dart' show TextStyles;
import 'package:momra/core/util/size_config.dart';
import 'package:momra/core/util/widget_ext.dart';
import 'package:momra/l10n/l10n.dart';

import 'language_provider.dart';

class ChangeLanguageAccountSettingsSection extends ConsumerWidget {
  const ChangeLanguageAccountSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageState = ref.watch(languageStateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            context.l10n.language,
            style: TextStyles.bodyMedium.copyWith(
              color: AppColors.neutral100,
            ),
          ),
        ).paddingOnly(b: SizeConfig.safeBlockHorizontal * 3),
        Center(
          child: DropdownButton<Locale>(
              isExpanded: true,
              underline: const SizedBox.shrink(),
              iconEnabledColor: AppColors.neutral100,
              dropdownColor: AppColors.neutral0.withOpacity(0.5),
              style: TextStyles.bodySmall.copyWith(color: AppColors.neutral100),
              items: AppLocalizations.supportedLocales
                  .map((e) => DropdownMenuItem<Locale>(
                        value: e,
                        child: Text(
                          _getLangName(context, e),
                          style: TextStyles.bodySmall
                              .copyWith(color: AppColors.neutral100),
                        ).paddingOnly(l: SizeConfig.safeBlockHorizontal * 3),
                      ))
                  .toList(),
              onChanged: (language) {
                if (language != null) {
                  ref
                      .read(languageStateProvider.notifier)
                      .changeLanguage(language);
                }
              },
              value: languageState.locale),
        ),
      ],
    );
  }

  String _getLangName(BuildContext context, Locale l) {
    switch (l.languageCode) {
      case "de":
        return context.l10n.de;

      default:
        return context.l10n.en;
    }
  }
}
