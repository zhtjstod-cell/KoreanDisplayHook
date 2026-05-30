# Korean Display Hook

Starsector 한국어 표시용 런타임 훅 모드입니다.

이 프로젝트는 기존 `Korean Mod Translations` 직접 패치 프로젝트와 분리된 별도 프로젝트입니다. 원본 Starsector core jar, 원본 모드 jar/csv/json 파일을 수정하지 않고, `vmparams`에 Java agent 옵션을 추가해서 화면에 표시되는 텍스트를 런타임에 번역합니다.

## Download

최신 릴리스에서 `KoreanDisplayHook-0.2.0-alpha.zip`을 받으세요.

https://github.com/zhtjstod-cell/KoreanDisplayHook/releases

## Install

1. ZIP을 풀어서 `KoreanDisplayHook` 폴더 전체를 Starsector의 `mods\KoreanDisplayHook` 위치에 둡니다.
2. `install_korean_display_hook.bat`를 실행합니다.
3. 모드 런처에서 `Korean Display Hook`이 켜져 있는지 확인하고 게임을 실행합니다.

Python은 필요 없습니다. Windows PowerShell만 사용합니다.

## Uninstall

`uninstall_korean_display_hook.bat`를 실행하면 `vmparams`의 agent 옵션과 `enabled_mods.json`의 모드 활성화만 제거합니다. 모드 폴더는 삭제하지 않습니다.

## Included

- 런타임 표시 번역 사전
- 숫자/퍼센트/크레딧/키 입력/세력명/함선명 템플릿 사전
- 안전한 클래스 상수 표시 치환 사전
- 한국어 폰트와 `cjkMode` 설정
- 현재 설치된 원본 skin이 있을 때만 활성화되는 선택적 skin 설명 overlay

지원 원본 모드(AoTD, Arma Armatura, Nexerelin 등)는 사용자가 별도로 설치해야 합니다. 그중 일부만 설치되어 있어도 이 모드는 로딩되어야 합니다.

## Debug Mode

일반 플레이 기본값은 로그/JSONL/콘솔/핫리로드가 꺼진 상태입니다. 문제 분석이 필요할 때만 다음처럼 설치하세요.

```bat
install_korean_display_hook.bat -DebugMode
```

로그는 `mods\KoreanDisplayHook\reports`에 용량 제한을 두고 생성됩니다.

## Version

- Current version: `0.2.0-alpha`
- Mod id: `korean_display_hook`
- Game version: `0.98a-RC8`
- No online machine translation endpoint is used.
