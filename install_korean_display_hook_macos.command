#!/bin/bash
set -euo pipefail

ModId="korean_display_hook"
OldModId="korean_mod_translations"
ModDirName="KoreanDisplayHook"

ModRoot="$(cd "$(dirname "$0")" && pwd)"
ModsRoot="$(dirname "$ModRoot")"

if [[ "$(basename "$ModsRoot")" != "mods" ]]; then
    echo "Install folder must be inside Starsector.app/mods. Current path: $ModRoot" >&2
    exit 1
fi

GameRoot="$(dirname "$ModsRoot")"
MacLauncher="$GameRoot/Contents/MacOS/starsector_mac.sh"
EnabledModsPath="$ModsRoot/enabled_mods.json"

if [[ "$(basename "$ModRoot")" != "$ModDirName" ]]; then
    echo "Install folder should be named $ModDirName. Current path: $ModRoot" >&2
    exit 1
fi

if [[ ! -f "$MacLauncher" ]]; then
    echo "starsector_mac.sh not found: $MacLauncher" >&2
    echo "Put the KoreanDisplayHook folder under Starsector.app/mods/KoreanDisplayHook and retry." >&2
    exit 1
fi

backup="$MacLauncher.before_korean_display_hook"
if [[ ! -f "$backup" ]]; then
    cp "$MacLauncher" "$backup"
fi

tmp_block="$(mktemp)"
cat > "$tmp_block" <<'KDH_FLAGS'
    -javaagent:../../../mods/KoreanDisplayHook/jars/kmt-display-agent.jar \
    -Dkmt.display.modDir=KoreanDisplayHook \
    -Dkmt.display.reportDir=../../../mods/KoreanDisplayHook/reports \
    -Dkmt.display.dict=../../../mods/KoreanDisplayHook/data/kmt_display_translations.json \
    -Dkmt.display.templateDict=../../../mods/KoreanDisplayHook/data/kmt_display_template_translations.json \
    -Dkmt.display.compositionDict=../../../mods/KoreanDisplayHook/data/kmt_display_composition_templates.json \
    -Dkmt.display.contextDict=../../../mods/KoreanDisplayHook/data/kmt_display_context_translations.json \
    -Dkmt.display.classConstantDict=../../../mods/KoreanDisplayHook/data/kmt_display_class_constant_translations.json \
    -Dkmt.display.denylist=../../../mods/KoreanDisplayHook/data/kmt_display_denylist.txt \
    -Dkmt.display.v4db=../../../mods/KoreanDisplayHook/data/kmt_display_v4_database.json \
    -Dkmt.display.v2=true \
    -Dkmt.display.v4=true \
    -Dkmt.display.agent=true \
    -Dkmt.display.agent.constpatch=true \
    -Dkmt.display.constpatch.core=false \
    -Dkmt.display.constpatch.literalFallback=true \
    -Dkmt.display.agent.renderer=true \
    -Dkmt.display.agent.tokenReplacement=true \
    -Dkmt.display.agent.ruleTokens=true \
    -Dkmt.display.agent.highlevel=true \
    -Dkmt.display.skinOverlays.refresh=true \
    -Dkmt.display.agent.log=false \
    -Dkmt.display.warmup=true \
    -Dkmt.display.highlevel=true \
    -Dkmt.display.highlevel.mode=observe \
    -Dkmt.display.highlevel.bindOnly=true \
    -Dkmt.display.highlevel.mutate=false \
    -Dkmt.display.highlevel.unsafeMutation=false \
    -Dkmt.display.highlevel.broad=false \
    -Dkmt.display.highlevel.safe=true \
    -Dkmt.display.highlevel.patchModClasses=false \
    -Dkmt.display.highlevel.receiverRepeatSkip=true \
    -Dkmt.display.highlevel.measurementHooks=false \
    -Dkmt.display.highlevel.preLayoutFlow=true \
    -Dkmt.display.highlevel.adaptiveLabels=false \
    -Dkmt.display.layout.parentDepth=4 \
    -Dkmt.display.layout.flowFullHeight=true \
    -Dkmt.display.layout.flowLabelHeightRepair=false \
    -Dkmt.display.layout.tooltipParaRepair=true \
    -Dkmt.display.layout.fixedLabelHeightRepair=false \
    -Dkmt.display.layout.autosize=false \
    -Dkmt.display.layout.proseAutosize=true \
    -Dkmt.display.layout.resizeOnSetText=false \
    -Dkmt.display.layout.resizeOnSetSize=false \
    -Dkmt.display.layout.stableLabelFlowRepair=false \
    -Dkmt.display.layout.skillBlockFlowRepair=false \
    -Dkmt.display.layout.excludeDynamicFleet=true \
    -Dkmt.display.layout.textCompaction=false \
    -Dkmt.display.layout.stableLabelFlowRepair.depth=4 \
    -Dkmt.display.layout.stableLabelFlowRepair.skillDepth=5 \
    -Dkmt.display.layout.skillBlockFlowRepair.depth=4 \
    -Dkmt.display.layout.stableLabelFlowRepair.maxShift=360 \
    -Dkmt.display.layout.collisionRepair=false \
    -Dkmt.display.layout.collisionRepair.intervalMs=160 \
    -Dkmt.display.layout.collisionRepair.maxShift=220 \
    -Dkmt.display.layout.fontFit=false \
    -Dkmt.display.layout.fontFit.min=0.76 \
    -Dkmt.display.layout.fontFit.denseMin=0.70 \
    -Dkmt.display.layout.fontFit.denseWidth=0.62 \
    -Dkmt.display.layout.fontFit.rowBudget=false \
    -Dkmt.display.layout.fontFit.rowMin=0.64 \
    -Dkmt.display.layout.fontFit.rowDenseMin=0.58 \
    -Dkmt.display.layout.preserveKoreanSingleLine=true \
    -Dkmt.display.layout.noEllipsis=true \
    -Dkmt.display.skill.semanticCompact=false \
    -Dkmt.display.v2.suppressDuplicateEnglish=true \
    -Dkmt.display.translate.modloader=false \
    -Dkmt.display.hotReload=false \
    -Dkmt.display.debug=false \
    -Dkmt.display.debug.jsonl=false \
    -Dkmt.display.debug.jsonl.full=false \
    -Dkmt.display.debug.stack=false \
    -Dkmt.display.debug.console.auto=false \
    -Dkmt.display.debug.max.mb=16 \
    -Dkmt.display.debug.keep.files=8 \
    -Dkmt.display.debug.archive.max.mb=64 \
KDH_FLAGS

tmp_launcher="$(mktemp)"
awk -v block_file="$tmp_block" '
    /kmt-display-agent\.jar/ { next }
    /-Dkmt\.display\./ { next }
    /\$\{EXTRAARGS\}/ && !inserted {
        while ((getline line < block_file) > 0) print line
        close(block_file)
        inserted = 1
    }
    { print }
    END { if (!inserted) exit 42 }
' "$MacLauncher" > "$tmp_launcher" || {
    rm -f "$tmp_launcher" "$tmp_block"
    echo "Failed to update $MacLauncher. Could not find the \${EXTRAARGS} insertion point." >&2
    exit 1
}
rm -f "$tmp_block"
mv "$tmp_launcher" "$MacLauncher"
chmod +x "$MacLauncher"

/usr/bin/osascript -l JavaScript -e '
function run(argv) {
    ObjC.import("Foundation");
    const path = argv[0];
    const modId = argv[1];
    const oldModId = argv[2];
    const manager = $.NSFileManager.defaultManager;
    let payload = { enabledMods: [] };
    if (manager.fileExistsAtPath(path)) {
        const text = $.NSString.stringWithContentsOfFileEncodingError(path, $.NSUTF8StringEncoding, null);
        if (!text.isNil()) {
            try { payload = JSON.parse(ObjC.unwrap(text)); } catch (_) { payload = { enabledMods: [] }; }
        }
    }
    const isArrayPayload = Array.isArray(payload);
    let mods = isArrayPayload ? payload : payload.enabledMods;
    if (!Array.isArray(mods)) mods = [];
    mods = mods.map(String).filter((id) => id !== modId && id !== oldModId);
    mods.push(modId);
    const outputPayload = isArrayPayload ? mods : Object.assign(payload, { enabledMods: mods });
    const output = JSON.stringify(outputPayload, null, 2) + "\n";
    $.NSString.alloc.initWithUTF8String(output).writeToFileAtomicallyEncodingError(path, true, $.NSUTF8StringEncoding, null);
}
' "$EnabledModsPath" "$ModId" "$OldModId"

echo "Korean Display Hook installed for macOS."
echo "Game root: $GameRoot"
echo "Launcher backup: $backup"
echo "Debug logging: disabled"
