#!/bin/bash
set -euo pipefail

ModId="korean_display_hook"
ModRoot="$(cd "$(dirname "$0")" && pwd)"
ModsRoot="$(dirname "$ModRoot")"

if [[ "$(basename "$ModsRoot")" != "mods" ]]; then
    echo "Install folder must be inside Starsector.app/mods. Current path: $ModRoot" >&2
    exit 1
fi

GameRoot="$(dirname "$ModsRoot")"
MacLauncher="$GameRoot/Contents/MacOS/starsector_mac.sh"
EnabledModsPath="$ModsRoot/enabled_mods.json"

if [[ -f "$MacLauncher" ]]; then
    tmp_launcher="$(mktemp)"
    awk '
        /kmt-display-agent\.jar/ { next }
        /-Dkmt\.display\./ { next }
        { print }
    ' "$MacLauncher" > "$tmp_launcher"
    mv "$tmp_launcher" "$MacLauncher"
    chmod +x "$MacLauncher"
fi

if [[ -f "$EnabledModsPath" ]]; then
    /usr/bin/osascript -l JavaScript -e '
function run(argv) {
    ObjC.import("Foundation");
    const path = argv[0];
    const modId = argv[1];
    const text = $.NSString.stringWithContentsOfFileEncodingError(path, $.NSUTF8StringEncoding, null);
    if (text.isNil()) return;
    let payload;
    try { payload = JSON.parse(ObjC.unwrap(text)); } catch (_) { return; }
    const isArrayPayload = Array.isArray(payload);
    let mods = isArrayPayload ? payload : payload.enabledMods;
    if (!Array.isArray(mods)) mods = [];
    mods = mods.map(String).filter((id) => id !== modId);
    const outputPayload = isArrayPayload ? mods : Object.assign(payload, { enabledMods: mods });
    const output = JSON.stringify(outputPayload, null, 2) + "\n";
    $.NSString.alloc.initWithUTF8String(output).writeToFileAtomicallyEncodingError(path, true, $.NSUTF8StringEncoding, null);
}
' "$EnabledModsPath" "$ModId"
fi

echo "Korean Display Hook disabled for macOS. The mod folder was not deleted."
