# Korean Display Hook v0.2.0-alpha

Updated alpha runtime-hook release.

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
- Routes renderer, high-level observation, token replacement, StringBuilder/invokedynamic composition, `%s`, numbers, factions, market/planet names, commodities, durations, and location prose through the same display template pipeline where safe.
- Preserves long Korean prose at renderer level instead of clamping it to `...`, relying on the Korean auto-size layout guard to prevent overlap.
- Keeps high-level UI mutation in bind-only/observe mode for release, so AoTD/AshLib/vanilla command keys remain English internally while renderer-visible text can be Korean.
- Excludes debug console, JSONL collection, runtime miss extraction, and helper tools from the release ZIP.

## Install

1. Extract `KoreanDisplayHook-0.2.0-alpha.zip`.
2. Put the extracted `KoreanDisplayHook` folder under Starsector `mods`.
3. Run `install_korean_display_hook.bat`.
4. Confirm `Korean Display Hook` is enabled in the mod launcher.

Original supported mods such as AoTD, Arma Armatura, Nexerelin, MagicLib, LazyLib, GraphicsLib, and AshLib still need to be installed separately. Missing supported mods should not prevent this hook mod from loading.

## Package

- Asset: `KoreanDisplayHook-0.2.0-alpha.zip`
- Zip SHA-256: `f163c3e7ad25fbc6e4ff7d127b94e08ba621856ad38b074e70dd1dadab39a6a3`
- Agent SHA-256: `8b96e990e691538cf9f258c557f2ae53b0ad88d8daefdf1abef06d2c714d4dff`
- Zip size: `36,293,180` bytes

## Local Validation

- Clean test install completed in `H:\Games\Starsector_hook_clean_test`.
- `vmparams` used `-javaagent:..\mods\KoreanDisplayHook\jars\kmt-display-agent.jar`.
- `korean_display_hook` was enabled and `korean_mod_translations` was disabled.
- Release install uses `kmt.display.highlevel.mode=observe`, `kmt.display.highlevel.bindOnly=true`, `kmt.display.highlevel.mutate=false`, and debug/JSONL/console flags set to false.
- AoTD activation audit reported `overall_status=ok`.
- Renderer-first replay covered survey reward, current-market agent intel, bounty/rumor location lines, and long Aleste prose without renderer ellipsis.
- Existing runtime-miss replay showed remaining mixed samples are mostly proper-name/title cases, while the user-reported intel/probe/survey/rumor classes translate.
- Direct-launch smoke with `-DlaunchDirect=true` reached campaign save/resource loading and stayed alive until the smoke timeout; no KMT transform, verifier, or fatal startup errors were found.
- ZIP audit found 120 entries and 0 debug/log-extraction/tool entries.

## Known Limits

- This is still an alpha release.
- Remaining untranslated proper names, titles, or isolated mod labels may still exist.
- No online machine-translation endpoint is included.
