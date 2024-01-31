# 환율 계산 앱
- iOS 13.0 target
- No 3rd party
  
![Simulator Screen Recording - iPhone 15 - 2024-01-30 at 12 08 06](https://github.com/ibcylon/CodingTest/assets/25360781/9925c81f-5658-44b0-83a4-dd84d706e5e4)

### 의의
* 과제 테스트를 위해 작성함
* Rx만 써오다가 Combine 공부하게 됨
  - Example통한 겉핥기 공부만하다가 WWDC, 문서를 베이스로 학습
* UIkit + Combine 특이한 스택 경험
# 아키텍처
## Clean Architecture
- Package를 이용하여 Presentation / Domain / Data Layer 모듈화
- Repository protocol을 이용하여 DIP
- DI를 이용한 testable한 코드를 작성
- CompositionRoot를 작성하여 의존성 관리
- Data Layer - Stub / API Test를 작성하여 신뢰성있는 코드 작성
- Network Layer - Moya Abstract Layer를 참고하여 작성
## MVVM with Combine
- combine을 이용하여 직관적인 비동기 코드 및 반응형 프로그래밍을 작성
- Input / Output을 나눠 작성하여 코드 가독성을 증가
# 생산성 증가
- DIContainer, VCFactory
- UIKit + Preview
# 트러블 슈팅 및 회고
- RxCocoa를 통해 쉽게 UI Binding 해오다가, combine 사용하게 되면서 UI Event publisher 작성해보는 경험
  - NotificationCenter를 이용한 custom publisher 작성 - 제일 간단하여 채택
  - @objc + subject를 이용한 방법 - declartive한 방법이 아닌 것 같아 사용 자제함
  - UI Event를 이용한 custom pubilsher 작성 - 제일 범용적이나 스스로 이해하지 못하고 작성하는 것 같아 보류
- Rx와 다르게 stream 연결을 위해, subject 사용이 강제 됨

