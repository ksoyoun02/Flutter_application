![banner](https://capsule-render.vercel.app/api?type=waving&color=0:fd947f,100:fa72e2&height=220&text=My%20Flutter%20Project&fontSize=50&fontColor=fff&section=header)

## 📌 프로젝트 소개
이 프로젝트는 **코드팩토리의 플러터 프로그래밍 도서를 학습하며 구현한 flutter 앱**입니다.

Flutter의 기본 개념과 주요 기능을 익히는 데 초점을 맞췄으며, 학습한 내용을 바탕으로 직접 기능을 추가하며 앱의 완성도를 높였습니다.

---

## 🛠 사용 기술 스택
<span>
<img src="https://img.shields.io/badge/dart-0175C2?style=flat&logo=dart&logoColor=white"/>
<img src="https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white"/>
<img src="https://img.shields.io/badge/Node.js-339933?style=flat&logo=nodedotjs&logoColor=white"/>
<img src="https://img.shields.io/badge/Json-000000?style=flat&logo=json&logoColor=white"/>
<img src="https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white"/>
<img src="https://img.shields.io/badge/Spring%20boot-6DB33F?style=flat&logo=springboot&logoColor=white"/>
</span>

---
## 📂 프로젝트 구조
```
lib/
├── main.dart                            # 앱의 진입점
├── const/                               # 통신, global color 공통
├── component/                           # 컴포넌트
├── models/                              # 데이터 모델 정의
├── screens/                             # 주요 화면 위젯
│   ├── blog/                            # 블로그 앱
│   │   ├── blog_screen.dart             
│   ├── calendar/                        # 캘린더 앱
│   │   ├── calendar_scheduler_screen.dart
│   ├── choolCheck/                      # 출석체크 앱
│   │   ├── chool_check_screen.dart
│   ├── d_day/                           # 디데이 앱
│   │   ├── d_day_screen.dart
│   ├── dice/                            # 다이스 앱
│   │   ├── dice_main_screen.dart        # 다이스 메인화면
│   │   ├── dice_screen.dart             # 다이스 1번탭 - 다이스 굴리기
│   │   ├── dice_setting_screen.dart     # 다이스 2번탭 - 민감도 옵션 조정
│   ├── home/                            # 홈
│   │   ├── home_screen.dart
│   ├── imageEditor/                     # 이미지 편집 앱
│   │   ├── image_editor_screen.dart
│   ├── img/                             # 이미지 로더 앱
│   │   ├── img_screen.dart
│   ├── timer/                           # 타이머 앱
│   │   ├── timer_main_screen.dart       # 타이머 메인
│   │   ├── timer_screen.dart            # 타이머 1번탭 - 타이머
│   │   ├── stop_watch_screen.dart       # 타이머 2번탭 - 스톱워치
│   ├── video/                           # 비디오 로더 앱
│   │   ├── video_screen.dart      
│   ├── youtube/                         # 유튜브 로더 앱
│   │   ├── youtube_screen.dart    
├── widgets/                             # 재사용 가능한 위젯 모음
│   ├── date_picker_widget.dart          # 날짜입력/선택 위젯
│   ├── menu_widget.dart                 # 메뉴 위젯
│   ├── time_picker_widget.dart          # 시간입력/선택 위젯
└── services/                            # 데이터 처리 로직
    ├── calendar_service.dart            # 캘린더 서비스단
```


---
## 📂 메인 Page


<details> <summary><b>🚀 1.</b> (클릭하여 펼치기)</summary>
할 일 관리
사용자가 할 일을 추가, 삭제, 수정할 수 있습니다.
상태 변경(예: 완료, 미완료)을 지원합니다.
검색 및 필터링
키워드 기반 검색 및 상태별 필터링 기능 제공.
반응형 UI
모바일 및 데스크톱에서도 최적화된 레이아웃을 지원합니다.
데이터 저장
SQLite 또는 백엔드 API를 연동하여 데이터를 관리합니다.
</details>



![banner](https://capsule-render.vercel.app/api?type=waving&color=0:fd947f,100:fa72e2&height=220&text=My%20Flutter%20Project&fontSize=50&fontColor=fff&section=footer)
