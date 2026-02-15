# 실시간 관심 종목 모니터링 - 종목 상세 페이지 구현

Flutter 기반의 Clean Architecture 설계로 구현된 실시간 주식 가격 모니터링 앱입니다. 관심 종목 등록, 목표가 알림, 그리고 섹션별 네비게이션을 지원합니다.

---

## 1. 실행 방법

### 사전 준비 사항
- Flutter SDK 3.41.1 이상
- Dart 3.11.0 이상

### 설치 및 실행

```bash
# 1. 의존성 설치
flutter pub get

# 2. 코드 생성 (freezed, json_serializable, hive)
dart run build_runner build --delete-conflicting-outputs

# 3. 앱 실행
flutter run

# 4. 테스트 실행 (88개 단위 테스트)
flutter test
```

### 코드 생성 (빌드러너) 세부사항
이 프로젝트는 다음 코드 생성 도구를 사용합니다:
- **freezed**: 불변 엔티티 및 상태 클래스 생성
- **json_serializable**: JSON 직렬화/역직렬화 코드 생성
- **hive_generator**: Hive 로컬 저장소 어댑터 생성

생성된 파일들은 `*.freezed.dart`, `*.g.dart` 패턴으로 자동 생성됩니다.

---

## 2. 아키텍처 설명

이 프로젝트는 **Clean Architecture**를 3계층으로 구현합니다.

### 전체 구조

```
lib/
├── core/
│   └── di/                    # 의존성 주입 컨테이너 (get_it)
├── domain/                    # 비즈니스 로직 계층
│   ├── stock/
│   │   ├── entities/          # Stock 엔티티
│   │   └── repos/             # StockRepository 인터페이스
│   ├── watchlist/
│   │   ├── entities/          # WatchlistItem, AlertType 엔티티
│   │   ├── repos/             # WatchlistRepository 인터페이스
│   │   └── watchlist.dart     # 공개 API 배럴 파일
│   └── usecases/              # 비즈니스 로직 (2개 이상 도메인 사용)
│       ├── toggle_watchlist_use_case.dart
│       └── check_target_price_use_case.dart
├── data/                      # 데이터 계층
│   ├── ezar/                  # Mock API (주식 정보, 실시간 가격)
│   │   ├── datasources/       # StockDataSourceEzar, StockTickDataSourceEzar
│   │   └── models/            # DTO (Data Transfer Object)
│   ├── local/                 # 로컬 저장소 (Hive)
│   │   ├── datasources/       # WatchlistDataSourceLocal
│   │   └── models/            # WatchlistItemModel
│   └── repositories/          # Repository 구현체
│       ├── stock_repository_impl.dart
│       └── watchlist_repository_impl.dart
└── presentation/              # UI 계층
    ├── hooks/                 # 커스텀 Flutter Hooks
    │   └── use_tab_scroll_controller.dart
    └── pages/stock/
        ├── stock_page.dart            # 페이지 엔트리포인트
        ├── stock_view.dart            # 주요 UI 컴포넌트
        ├── stock_provider.dart        # 상태 관리 (ChangeNotifier)
        └── stock_state.dart           # 불변 상태 클래스 (freezed)
```

### 계층별 책임

#### Domain Layer (도메인 계층)
- 비즈니스 규칙 및 엔티티 정의
- Repository 인터페이스 (구현 없음)
- UseCase: 여러 도메인에 걸친 비즈니스 로직

**핵심 엔티티:**
- `Stock`: 주식 정보 (코드, 명칭, 현재가, 변동률, 가격 이력)
- `WatchlistItem`: 관심 종목 (종목코드, 목표가, 알림타입)
- `AlertType`: 알림 조건 (상한, 하한, 양방향)

**UseCase:**
- `ToggleWatchlistUseCase`: 관심 종목 등록/해제 (WatchlistRepository 사용)
- `CheckTargetPriceUseCase`: 목표가 도달 여부 판별 (WatchlistRepository 사용)

#### Data Layer (데이터 계층)
- Repository 인터페이스 구현체
- DataSource: 외부 데이터 소스 접근
- DTO 모델: 외부 데이터 형식 변환

**DataSource:**
- `StockDataSourceEzar`: Mock API에서 주식 기본 정보 조회
- `StockTickDataSourceEzar`: 실시간 가격 스트림 (Timer + BehaviorSubject)
- `WatchlistDataSourceLocal`: Hive 로컬 저장소

**Repository 구현체:**
- `StockRepositoryImpl`: 주식 정보 및 실시간 가격 스트림 제공
- `WatchlistRepositoryImpl`: 관심 종목 관리

#### Presentation Layer (UI 계층)
- Widget, 상태 관리, 사용자 인터랙션
- `StockProvider`: ChangeNotifier 기반 상태 관리
- `StockState`: 불변 상태 (freezed)
- `StockView`: 주요 UI 컴포넌트들

### 의존성 흐름 (역전 원칙)

```
presentation → data → domain
     ↓          ↓        ↓
StockProvider  Impl   Repository(인터페이스)
```

- Domain은 Data/Presentation에 의존하지 않음 (의존성 역전)
- Data는 Domain의 Repository 인터페이스를 구현
- Presentation은 Domain의 Repository를 통해 접근

### 상태 관리 방식

**StockState (불변 상태)**
```dart
@freezed
abstract class StockState with _$StockState {
  const StockState._();

  const factory StockState({
    Stock? stock,
    @Default([]) List<WatchlistItem> watchlist,
    ({WatchlistItem item, bool isUpper})? triggeredAlert,
  }) = _StockState;

  bool get isLoading => stock == null;
  bool get hasError => stock != null && stock!.code.isEmpty;
  Stock get stockOrDefault => stock ?? const Stock();
  bool get isInWatchlist =>
      watchlist.any((item) => item.stockCode == stockOrDefault.code);
}
```

**StockProvider (상태 변경 통지)**
- `ChangeNotifier` 상속으로 상태 변경 시 `notifyListeners()` 호출
- `context.select()`로 필요한 상태만 구독 → 불필요한 rebuild 방지
- 스트림 구독/해제 및 리소스 정리는 `dispose()`에서 처리

---

## 3. 종목 상세 페이지의 섹션 네비게이션/하이라이팅 구현 방식

### 개요

종목 상세 페이지는 스크롤 기반의 5개 섹션으로 구성되며, AppBar 바로 아래의 탭 버튼으로 섹션 간 네비게이션을 지원합니다. 사용자가 스크롤할 때 현재 보이는 섹션에 해당하는 탭이 자동으로 하이라이팅됩니다.

**섹션 구성:**
1. 가격 섹션 (가격 그래프, 현재가)
2. 요약 섹션 (종목 정보 요약)
3. 입력 섹션 (TextField 포함)
4. 확장 패널 섹션 (ExpansionPanelList)
5. 기타 섹션 (데모 섹션)

### 핵심 구현: useTabScrollController 커스텀 훅

모든 네비게이션 로직은 `useTabScrollController` 커스텀 훅에 중앙화되어 있습니다.

#### 1. 초기화 및 리소스 할당

```dart
TabScrollController useTabScrollController({required int tabViewCount}) {
  final scrollController = useScrollController();  // 스크롤 컨트롤러
  final tabController = useTabController(initialLength: tabViewCount);  // 탭 컨트롤러
  final viewportKey = useMemoized(GlobalKey.new);  // 뷰포트 영역 참조
  final tabViewKeys = useMemoized(
    () => List.generate(tabViewCount, (_) => GlobalKey()),  // 각 섹션 참조
  );
  final isScrollingByTap = useRef(false);  // 탭 클릭 플래그
}
```

- `scrollController`: ListView 스크롤 추적
- `tabController`: 탭 상태 관리 및 하이라이팅
- `viewportKey`: 뷰포트 화면 좌표 기준점
- `tabViewKeys`: 각 섹션의 화면 위치 계산용
- `isScrollingByTap`: 탭 클릭에 의한 스크롤 중 리스너 무시

#### 2. 스크롤 → 탭 동기화 (자동 하이라이팅)

```dart
int findCurrentTabIndex() {
  final viewportTop = getTopDyOfWidget(viewportKey);
  return tabViewKeys.lastIndexWhere((key) {
    return key.currentContext != null && getTopDyOfWidget(key) <= viewportTop;
  });
}

useEffect(() {
  void onScroll() {
    if (isScrollingByTap.value) return;  // 탭 클릭 중이면 무시
    if (viewportKey.currentContext == null) return;

    final currentIndex = findCurrentTabIndex();
    if (currentIndex != -1 && tabController.index != currentIndex) {
      tabController.index = currentIndex;  // 탭 하이라이팅 변경
    }
  }

  scrollController.addListener(onScroll);
  return () => scrollController.removeListener(onScroll);
}, [scrollController, tabController]);
```

**동작 원리:**
- `getTopDyOfWidget()`: 각 섹션의 화면상 위치(dy) 계산
  - `RenderBox.localToGlobal(Offset.zero).dy`로 절대 좌표 획득
- `findCurrentTabIndex()`: 뷰포트 상단(viewportTop)보다 위에 있는 섹션 중 가장 마지막 인덱스
  - 즉, 뷰포트를 벗어난 마지막 섹션 = 현재 보이는 첫 섹션
- 스크롤 리스너에서 현재 섹션이 변경되면 `tabController.index` 변경
  - TabBar 자동 하이라이팅

#### 3. 탭 → 스크롤 동기화 (섹션 이동)

```dart
void scrollTo(int index) {
  final targetContext = tabViewKeys[index].currentContext;
  if (targetContext == null) return;

  isScrollingByTap.value = true;  // 플래그 설정
  Scrollable.ensureVisible(
    targetContext,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  ).then((_) => isScrollingByTap.value = false);  // 플래그 해제
}
```

**동작 원리:**
- `Scrollable.ensureVisible()`: 지정된 위젯이 뷰포트에 보이도록 자동 스크롤
- `isScrollingByTap` 플래그:
  - 탭 클릭 시 `true`로 설정
  - 스크롤 리스너에서 플래그 체크하여 탭 변경 무시
  - 스크롤 완료 후 `false`로 해제
- 300ms 애니메이션으로 부드러운 스크롤

#### 4. 충돌 방지 메커니즘

**문제:** 탭을 클릭하면 스크롤이 발생 → 스크롤 리스너 호출 → 탭 인덱스 변경 → 무한 루프

**해결책:** `isScrollingByTap` 플래그로 탭 클릭 중에만 스크롤 리스너를 비활성화
- 사용자가 탭 클릭 → 플래그 ON
- 스크롤 리스너에서 플래그 확인 후 조기 반환
- 스크롤 완료 → 플래그 OFF
- 이후 사용자 손가락 스크롤은 정상 작동

### 사용 방법

**StockPage (상위 위젯):**
```dart
final tabScrollController = useTabScrollController(tabViewCount: 5);

return StockView(tabScrollController: tabScrollController);
```

**StockView (UI 구성):**
```dart
Scaffold(
  appBar: StockAppBarView(
    tabController: widget.tabScrollController.tabController,
    onTabTap: widget.tabScrollController.scrollTo,  // 탭 클릭 시 scrollTo 호출
  ),
  body: ListView(
    key: widget.tabScrollController.viewportKey,  // 뷰포트 기준점
    controller: widget.tabScrollController.scrollController,  // 스크롤 추적
    children: [
      StockPriceView(key: widget.tabScrollController.keys[0]),  // 섹션 1
      const Divider(),
      StockSummaryView(key: widget.tabScrollController.keys[1]),  // 섹션 2
      const Divider(),
      StockInputView(key: widget.tabScrollController.keys[2]),  // 섹션 3
      const Divider(),
      StockExpansionView(key: widget.tabScrollController.keys[3]),  // 섹션 4
      const Divider(),
      StockEtcView(key: widget.tabScrollController.keys[4]),  // 섹션 5
    ],
  ),
);
```

### 성능 최적화 및 메모리 관리

1. **Memoization**
   - `useMemoized()`로 GlobalKey, 탭 컨트롤러 재생성 방지
   - 불필요한 rebuild 감소

2. **선택적 구독**
   - `context.select()`로 필요한 상태만 구독
   - 전체 상태 변경 시 모든 위젯 rebuild 방지

3. **리소스 정리**
   - `useEffect()` 반환 함수에서 스크롤 리스너 제거
   - `dispose()`에서 컨트롤러 및 스트림 구독 해제
   - 메모리 누수 방지

4. **플래그 기반 제어**
   - `isScrollingByTap` 플래그로 불필요한 리스너 호출 방지
   - 스크롤 계산 최소화

---

## 실시간 가격 스트림

### Mock WebSocket 구현

`StockTickDataSourceEzar`는 Timer와 RxDart의 BehaviorSubject를 활용하여 Mock WebSocket을 구현합니다.

```dart
Stream<Stock> stockTickStream(String code) async* {
  await _tickStreamSubject.close();
  _tickStreamSubject = BehaviorSubject<Stock>();
  _timer?.cancel();

  _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
    final currentStock = // ... 현재 주식 정보
    final randomPrice = // ... 랜덤 가격 생성
    _tickStreamSubject.add(currentStock.copyWith(
      currentPrice: randomPrice,
      changeRate: changeRate,
    ));
  });

  yield* _tickStreamSubject.stream;
}
```

- **5초 간격**으로 랜덤 가격 생성
- `BehaviorSubject`: 최신 값 유지, 새 구독자에게 마지막 값 즉시 전달
- `StockProvider._subscribeTick()`에서 구독, `dispose()`에서 해제

### 관심 종목 및 목표가 알림

1. **Hive 로컬 저장소**
   - `WatchlistItem` 저장/로드 (앱 재시작 후에도 유지)
   - 하트 버튼으로 등록/해제

2. **목표가 감지**
   - `CheckTargetPriceUseCase`: 가격 변동 시 목표가 도달 여부 판별
   - 상한가, 하한가, 양방향 알림 지원
   - 도달 시 스낵바 알림 표시

---

## 테스트

이 프로젝트는 88개의 단위 테스트를 포함합니다.

**테스트 범위:**
- Domain 엔티티 및 로직
- Data 계층 (DataSource, Repository)
- Presentation Widget (StockView)

**모킹 도구:**
- `mocktail`: Repository, DataSource 모킹

**실행:**
```bash
flutter test
```

---

## 주요 라이브러리

| 라이브러리 | 버전 | 용도 |
|-----------|------|------|
| provider | 6.1.5 | 상태 관리 |
| get_it | 9.2.0 | 의존성 주입 |
| rxdart | 0.28.0 | BehaviorSubject (Mock WebSocket) |
| hive_ce | 2.19.3 | 로컬 저장소 |
| freezed | 3.2.5 | 불변 엔티티/상태 코드 생성 |
| fl_chart | 1.1.1 | 가격 그래프 |
| flutter_hooks | 0.21.3 | 커스텀 훅 |
| mocktail | 1.0.4 | 테스트 모킹 |

