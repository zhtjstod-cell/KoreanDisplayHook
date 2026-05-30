# Korean Display Hook v0.2.0-alpha

First separate runtime-hook release.

This package is distributed as `KoreanDisplayHook`, a different mod from the older direct-patch `KoreanModTranslations` package.

## What Changed

- Added a runtime Java agent display hook for Starsector mod Korean translation.
- Does not modify original Starsector core jars or original mod jar/csv/json files.
- Uses PowerShell install/uninstall scripts instead of requiring Python.
- Installs as mod id `korean_display_hook`.
- Disables the older `korean_mod_translations` entry when installing.
- Includes Korean font assets and runtime dictionaries inside the mod package.
- Adds display dictionaries, template dictionaries, context dictionaries, class-constant replacements, and a small v4 exact database.
- Adds optional skin description overlays only when matching source skins exist in the user's installation.
- Keeps normal play logging disabled by default.
- Supports debug logging with `install_korean_display_hook.bat -DebugMode`.

## Install

1. Extract `KoreanDisplayHook-0.2.0-alpha.zip`.
2. Put the extracted `KoreanDisplayHook` folder under Starsector `mods`.
3. Run `install_korean_display_hook.bat`.
4. Confirm `Korean Display Hook` is enabled in the mod launcher.

Original supported mods such as AoTD, Arma Armatura, Nexerelin, MagicLib, LazyLib, GraphicsLib, and AshLib still need to be installed separately. Missing supported mods should not prevent this hook mod from loading.

## Package

- Asset: `KoreanDisplayHook-0.2.0-alpha.zip`
- Zip SHA-256: `186111e6f88ee3daa4ac5601ddc64ae123ecf6356afc7f977d9131f36d9ffb0e`
- Agent SHA-256: `52ae4e9e5df2ade1eacb81008de147854f3b01ab53c58eb343d7d703a2eaf8b0`
- Zip size: `36,105,064` bytes

## Local Validation

- Clean test install completed in `H:\Games\Starsector_hook_clean_test`.
- `vmparams` used `-javaagent:..\mods\KoreanDisplayHook\jars\kmt-display-agent.jar`.
- `korean_display_hook` was enabled and `korean_mod_translations` was disabled.
- A 55-second launch smoke test stayed alive.
- The checked log tail did not show fatal Java transform or verifier errors.

## Known Limits

- This is still an alpha release.
- The unattended smoke test did not enter the main menu because Starsector needs a user click.
- Remaining untranslated or mixed runtime-composed strings may still exist.
- No online machine-translation endpoint is included.
