@echo off
echo Generating localization files...
dart run easy_localization:generate -S "assets/translations" -O "lib/core/generated" -o "locale_keys.g.dart" -f keys
echo.
echo Localization files generated successfully!
pause
