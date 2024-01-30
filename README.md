# 환율 계산
![Simulator Screen Recording - iPhone 15 - 2024-01-30 at 12 08 06](https://github.com/ibcylon/CodingTest/assets/25360781/9925c81f-5658-44b0-83a4-dd84d706e5e4)

# 아키텍처
## Clean Architecture + MVVM with Combine
- Presentation / Domain / Data Layer로 나눴습니다.
- Repository protocol을 이용하여 DIP하였습니다.
- SPM을 이용하여 모듈화하여, 빌드 타임을 줄이고, 개발 병목을 줄입니다.
- DI를 이용한 testable한 코드를 작성하였습니다.
- 생산성을 위해 DIContainer와 VCFactory를 만들었습니다.
- CompositionRoot를 작성하여 의존성 관리를 분리하였습니다.

- Data Layer - Stub / API Test를 작성하여 신뢰성있는 코드를 작성하였습니다.
- Data Layer의 Network는 Moya Abstract Layer를 참고하여 작성하였습니다.

- combine을 이용하여 직관적인 비동기 코드 및 반응형 프로그래밍을 작성하였습니다.
- Input / Output을 나눠 작성하여 코드 가독성을 증가시켰습니다.

# 편의를 위해 적용한 것
- DIContainer, VCFactory
- UIKit + Preview

# 트러블 슈팅 
