import 'package:flutter/material.dart';
import '../services/theme_service.dart';
import '../constants/app_colors.dart';
import '../l10n/app_localizations.dart';

class ColorThemePicker extends StatelessWidget {
  final ThemeService themeService;

  const ColorThemePicker({
    super.key,
    required this.themeService,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.chooseColorTheme,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: ColorTheme.values.map((theme) {
                final isSelected = themeService.colorTheme == theme;
                return GestureDetector(
                  onTap: () {
                    themeService.setColorTheme(theme);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: theme.color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColors.black : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            color: AppColors.white,
                            size: 24,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  AppLocalizations.of(context)!.close,
                  style: TextStyle(
                    color: themeService.primaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
