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
## 📂 프로젝트 메인 페이지
<table>
  <tr>
    <td width="35%" align="center">
      <img src="/asset/projectImg/main.png" alt="easyme" width="200">
    </td>
    <td width="65%">
      <h4>프로젝트 메인 페이지</h4>
      <p>화면 상단에는 사용자 정보가 보여지며, 하단은 메뉴 리스트로 구성됩니다.</p>
      <p>사용자 정보는 화면에 고정되며, 메뉴는 SingleChildScrollView 위젯을 사용하여 스크롤이 가능하도록 구현하였습니다.</p>
    </td>
  </tr>
</table>

<details> 
    <summary><b>📅 1. Calendar</b></summary>
    <table>
        <tr>
            <td width="35%" align="center">
              <img src="/asset/projectImg/blog.png" alt="calendar-app" width="200">
            </td>
            <td width="65%">
                <h4>📅 일정관리 앱</h4>
                <h5>✨ 주요 기능</h5>
                <p>MySQL 데이터베이스와 연동하여 CRUD 기능을 구현한 일정 관리 앱입니다.</p>
                <ul>
                    <li>1️⃣ 달력 기반 일정 조회</li>
                        <p>한 달 동안 등록된 일정이 있는 날짜는 빨간 원으로 표시됩니다.</p>
                        <p> 날짜를 클릭하면 해당 날짜의 일정이 리스트로 나타납니다.</p>
                    <li>2️⃣ CRUD (생성, 조회, 수정, 삭제)</li>
                        <p>일정 추가: 일정 제목과 내용을 입력 후 저장하면 자동으로 해당 날짜에 추가됩니다.</p>
                        <p>일정 조회: 선택한 날짜에 맞는 일정만 화면에 표시됩니다.</p>
                        <p>일정 수정: 기존 일정을 클릭하여 내용을 수정할 수 있습니다.</p>
                        <p>일정 삭제: 일정을 왼쪽으로 슬라이드하면 일정이 삭제됩니다. 
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    </p>
                </ul>
            </td>
        </tr>
    </table>
</details>

<details> 
    <summary><b>📝 2. Blog</b></summary>
    <table>
        <tr>
            <td width="35%" align="center">
              <img src="/asset/projectImg/blog.png" alt="easyme" width="200">
            </td>
            <td width="65%">
                <h4>📝 블로그 웹 앱</h4>
                <h5>✨ 주요 기능</h5>
                <ul>
                    <p>웹뷰 위젯을 사용하여 앱에서 웹브라우저의 기능을 구현하였습니다.</p>
                    <li>1️⃣ AppBar</li>
                    <p>웹뷰 컨트롤러를 사용하여 뒤로가기 버튼과 홈버튼을 구현하였습니다.</p>
                    <li>2️⃣ WebView</li>
                    <p>기본 url을 티스토리 블로그로 설정하여 해당 웹사이트를 화면에 보여주었습니다.
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </p>
                </ul>
            </td>
        </tr>
    </table>
</details>

<details> 
    <summary><b>⏲️ 3. Timer</b></summary>
    <table>
        <tr>
            <td width="25%" align="center">
              <img src="/asset/projectImg/timer.png" alt="easyme" width="200">
            </td>
            <td width="25%" align="center">
              <img src="/asset/projectImg/stop.png" alt="easyme" width="200">
            </td>
            <td width="50%">
                <h4>⏲️ 타이머 / 스탑워치앱</h4>
                <h5>✨ 주요 기능</h5>
                <ul>
                    <p>TabBarView 위젯을 사용한 탭 기능과, 타이머 / 스탑워치 기능을 구현하였습니다.</p>
                    <li>1️⃣ Timer</li>
                    <p>CircularCountDownTimer 패키지를 사용하여 Timer앱을 구현하였으며, 
                    CountDownController를 사용하여 타이머 시작 / 일시정지 / 재시작 기능을 구현하였습니다.
                    </p>
                    <li>2️⃣ Stop Watch</li>
                    <p>stop_watch_timer 패키지를 사용하여 Stop Watch앱을 구현하였으며,
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </p>
                </ul>
            </td>
        </tr>
    </table>
</details>

![banner](https://capsule-render.vercel.app/api?type=waving&color=0:fd947f,100:fa72e2&height=220&section=footer)
