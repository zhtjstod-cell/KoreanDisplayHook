# Korean Display Hook

Starsector 한국어 표시용 런타임 훅 모드입니다.

Starsector 본편 + 대형모드 3종의 올인원 한글패치입니다. (해당 모드들이 없더라도 한글패치가 작동합니다.)

이 프로젝트는 기존 `Korean Mod Translations` 직접 패치 프로젝트와 분리된 별도 프로젝트입니다. 원본 Starsector core jar, 원본 모드 jar/csv/json 파일을 수정하지 않고, `vmparams`에 Java agent 옵션을 추가해서 화면에 표시되는 텍스트를 런타임에 번역합니다.

## Download

최신 릴리스에서 `KoreanDisplayHook-0.2.8.zip` 또는 더 최신 ZIP을 받으세요.

https://github.com/zhtjstod-cell/KoreanDisplayHook/releases

## Install on Windows

1. ZIP을 풀어서 `KoreanDisplayHook` 폴더 전체를 Starsector의 `mods\KoreanDisplayHook` 위치에 둡니다.
2. `install_korean_display_hook.bat`를 실행합니다.
3. 모드 런처에서 `Korean Display Hook`이 켜져 있는지 확인하고 게임을 실행합니다.

Python은 필요 없습니다. Windows PowerShell만 사용합니다.

## Install on macOS

macOS에서는 `mod_info.json`만으로 Java agent를 등록할 수 없어서 `Starsector.app/Contents/MacOS/starsector_mac.sh`에 JVM 인자를 추가해야 합니다. 이 설치 방식은 Starsector 본체 JAR 또는 모드 JAR/CSV/JSON을 수정하지 않습니다.

1. Starsector 앱을 `/Applications` 같은 일반 위치로 옮깁니다. `Downloads`에서 바로 실행하면 macOS App Translocation 때문에 경로 탐색이 실패할 수 있습니다.
2. ZIP을 풀어서 `KoreanDisplayHook` 폴더 전체를 `Starsector.app/mods/KoreanDisplayHook` 위치에 둡니다.
3. 터미널에서 다음 명령을 실행합니다.

```bash
cd "/Applications/Starsector.app/mods/KoreanDisplayHook"
chmod +x install_korean_display_hook_macos.command uninstall_korean_display_hook_macos.command
./install_korean_display_hook_macos.command
```

설치 스크립트는 다음 작업만 수행합니다.

- `Contents/MacOS/starsector_mac.sh`를 한 번 백업합니다: `starsector_mac.sh.before_korean_display_hook`
- 기존 Korean Display Hook JVM 인자를 제거한 뒤 `-javaagent:../../../mods/KoreanDisplayHook/jars/kmt-display-agent.jar`와 `-Dkmt.display.*` 일반 플레이 기본값을 다시 삽입합니다.
- `mods/enabled_mods.json`에 `korean_display_hook`을 추가하고, 이전 직접 패치 모드 id인 `korean_mod_translations`는 제거합니다.

설치 후 모드 런처에서 `Korean Display Hook`이 켜져 있는지 확인하고 게임을 실행합니다.

## Uninstall

Windows에서는 `uninstall_korean_display_hook.bat`를 실행하면 `vmparams`의 agent 옵션과 `enabled_mods.json`의 모드 활성화만 제거합니다.

macOS에서는 다음 명령을 실행합니다.

```bash
cd "/Applications/Starsector.app/mods/KoreanDisplayHook"
./uninstall_korean_display_hook_macos.command
```

macOS 제거 스크립트는 `starsector_mac.sh`의 Korean Display Hook JVM 인자와 `enabled_mods.json`의 `korean_display_hook` 활성화만 제거합니다. 모드 폴더는 삭제하지 않습니다.

## Included

- 런타임 표시 번역 사전
- 숫자/퍼센트/크레딧/키 입력/세력명/행성명/상품명/기간/위치 문장 템플릿 사전
- StringBuilder/invokedynamic 조합문과 `%s` 포맷문을 위한 전역 표시 템플릿 파이프라인
- 안전한 클래스 상수 표시 치환 사전
- 한국어 폰트와 `cjkMode` 설정
- 현재 설치된 원본 skin이 있을 때만 활성화되는 선택적 skin 설명 overlay

지원 원본 모드(AoTD, Arma Armatura, Nexerelin 등)는 사용자가 별도로 설치해야 합니다. 그중 일부만 설치되어 있어도 이 모드는 로딩되어야 합니다.

## Runtime Defaults

일반 플레이 기본값은 로그/JSONL/콘솔/핫리로드가 꺼진 상태입니다. 테스트용 로그 추출 스크립트와 디버그 콘솔은 성능 영향을 피하기 위해 배포 ZIP에 포함하지 않습니다.

## Version

- Current version: `0.2.8`
- Mod id: `korean_display_hook`
- Game version: `0.98a-RC8`
- No online machine translation endpoint is used.
