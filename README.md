# 🎁 iOS-malrang-market 
> 프로젝트 기간 2022.08.14 ~ 2022.    
개발자 : [malrang](https://github.com/malrang-malrang) 

# 📋 목차
- [프로젝트 소개](#-프로젝트-소개)
- [프로젝트 실행화면](#-프로젝트-실행화면)
- [개발환경 및 라이브러리](#-개발환경-및-라이브러리)
- [App 구조](#-app-구조)
- [고민한점, 트러블 슈팅](#-고민한점-트러블-슈팅)

---
## 🔎 프로젝트 소개
<img src="https://i.imgur.com/SvAapwx.jpg" width="830">

---
## 📺 프로젝트 실행화면
|ListView|GridView|Pagenation|
|--|--|--|
|<img src="https://i.imgur.com/b9RrSRb.gif" width="250">|<img src="https://i.imgur.com/9JDZKMg.gif" width="250">|<img src="https://i.imgur.com/tIDICls.gif" width="250">|

|DetailViewView|EditView|RegistrationView|
|--|--|--|
|<img src="https://i.imgur.com/BhrbhpW.gif" width="250">|<img src="https://i.imgur.com/8EB772I.gif" width="250">|<img src="https://i.imgur.com/drwUmGp.gif" width="250">|

|ContextMenu|ContextMenu를 통한 화면 전환|Paging|
|--|--|--|
|<img src="https://i.imgur.com/ie9iGgm.gif" width="250">|<img src="https://i.imgur.com/riKkFpc.gif" width="250">|<img src="https://i.imgur.com/I2c5lHq.gif" width="250">|

---
## 🛠 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.0-orange)]() [![xcode](https://img.shields.io/badge/Xcode-13.3.1-blue)]() [![iOS](https://img.shields.io/badge/iOS-13-red)]() [![SwiftLint](https://img.shields.io/badge/SwiftLint-0.47.1-orange)]() [![Snapkit](https://img.shields.io/badge/Snapkit-5.6-orange)]() [![Rxswift](https://img.shields.io/badge/Rxswift-6.5-hotpink)]() [![RxCocoa](https://img.shields.io/badge/RxCocoa-6.5-hotpink)]()

---
## 🗂 App 구조
### Coordinator
<img src="https://i.imgur.com/Nlcuhiw.png" width="600">

#### Coordinator 적용한 이유
- 이전 프로젝트 에서 각각 다른 View 에서 동일한 View로 화면전환시 중복코드가 생겨나고, 각 다른 View에서 동일한 Class 인스턴스 를 주입받아야 하는 상황이 발생해 이를 해결하고자 Coordinator 패턴에 대해 공부하고 적용했습니다.
- Coordinator 패턴을 적용해 화면 전환 로직을 ViewController 에서 분리 하였고, ViewController 간의 의존성을 제거 하였습니다.

### MVVM, CleanArchitecture
<img src="https://i.imgur.com/nB50IBY.png" width="800">

#### 적용한 이유
- 기존 MVVM의 경우 MVC보다는 계층이 분리되고, 객체들의 관심사가 분리되지만 그럼에도 ViewModel의 역할이 커지는 문제가 발생했습니다.
- CleanArchitecture를 통해 Layer를 한층 더 나누어 주면서 계층별로 관심사가 나누어지게 되고, 자연스럽게 각각의 객체들의 역할이 나누어 지도록 하였습니다.
- 이로 인해 객체들의 결합도가 낮아지고, 응집도는 높아지면서 문제가 발생했을 때 쉽게 찾을 수 있고 해당 부분만 수정이 가능해지면서 유지보수적인 측면에서 상당한 이점을 갖을 수 있게 되었습니다.

---
## 🤔 고민한점, 트러블 슈팅

### 1️⃣ 네트워크 통신과 무관하도록 Mock 객체를 만들어 Test 하는 방법? 🤔
예전에는 URLSession을 프로토콜로 추상화하여 URLSession 말고 dataTask() 메서드를 가진 Mock객체를 주입하여 테스트 하였는데 URLProtocol라는 키워드를 알게되었고 결론적으로 URLProtocol을 활용하게되면 네트워크 요청도 하고, 데이터도 테스트 할수 있게되어 이를 적용해보았습니다.

**1. 네트워크 통신과 무관한 테스트를 왜 해야할까??**
- 유닛 테스트는 빠르고 안정적으로 진행되어야 한다. 실제 서버와 통신하게되면 단위 테스트의 속도가 느려질 뿐만 아니라 인터넷 연결에 의존하기 때문에 테스트를 신뢰할 수 없다.
- 실제 서버와 통신하면 의도치 않은 결과를 불러올 수 있다. 예를들어 서버에 요청해서 데이터를 가져올때, 서버에 저장된값이 변경될수 있기 때문에 항상 원하는 값을 받을수있을것이라는 보장이 없다.
- 서버에서 주는 데이터와 상관없이 구현한 기능들이 잘 작동하는지 테스트 해야하기 때문이다.

**2. 네트워크 통신과 무관한 테스트는 어떻게 해야할까??**
- 네트워크 통신을 통해 데이터를 전달 받을때는 URLSession 에 구현된 메서드인 dataTask()메서드를 활용한다.
- 내부에서 어떻게 작동되는지 알수 없지만 우리는 URL 혹은 URLRquest의 값을 dataTask() 메서드에 인자로 전달하여 데이터를 받아오게된다!
- 그렇다면 우리가 해주어야할것은 dataTask() 메서드를 조작하는것이 핵심이될것이다!

**3. 네트워크 통신과 무관한 테스트를 하기위해 필요한것들**
- 네트워크와 통신할 수있는 객체가 필요할것이다.
- 네트워크와 통신할 수있는 객체가 가진 URLSession타입의 프로퍼티는 URLSession타입을 주입받을수 있도록 한다.
- 여기서 주입해주어야 하는 URLSession은 의도한 HTTPURLResponse, Data 를 반환하는 Mock객체를 이용해 만든 URLSession이다.
- 위와같이 구현해주었다면 의도한 값을 반환하는 dataTask() 메서드를 가진 URLSession타입의 프로퍼티 사용할수 있게된다.

**4. 네트워크 통신과 무관한 테스트를 해보자!**
```swift
final class NetworkProvider: Provider {
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func request(endPoint: EndPoint) -> Observable<Data> {
        return Single<Data>.create { single in
            let urlRequest: URLRequest

            switch endPoint.generateUrlRequest() {
            case .success(let request):
                urlRequest = request
            case .failure(let error):
                single(.failure(error))
                return Disposables.create()
            }
            let task = self.urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
                guard let result = self?.checkError(with: data, response, error) else {
                    return
                }

                switch result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            task.resume()
            return Disposables.create()
        }
        .asObservable()
    }
}
```
위와같이 URLSession을 주입받는 네트워크와 통신할수 있는 객체를 만들어 주었다.
테스트 코드에서는 NetworkProvider의 request()메서드를 테스트하게 될텐데!
의도한 값을 반환하는 URLSession을 주입 시킬수 있도록 Mock객체를 하나 만들어보자!

```swift
class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            return
        }

        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}
```
위에서 사용된 URLProtocol은 URL 데이터 로딩을 다루는 추상클래스다.
startLoading메서드는 외부에서 주입한(requestHandler 프로퍼티) Block을 통해 원하는 응답값을 내려받을수 있도록 만들었다.

이녀석을 가지고 URLSession을 생성해주면된다!

```swift
let configuration = URLSessionConfiguration.default
configuration.protocolClasses = [MockURLProtocol.self]
let urlSession = URLSession(configuration: configuration)
```
이제 MockURLProtocol을 URLSessionConfiguration의 protocolClasses에 넣고, 이 Configuration을 가지는 URLSession을 만들어주었다.

테스트할때는 이제 이렇게 만들어준 URLSession을 NetworkProvider에 주입해주면된다!

아직 해야할일이 남았다..! URLSession을 주입하는데에 성공했으면 이제 URLSession이 의도한 값을 반환하도록 해주어야 한다!
MockURLProtocol의 requestHandler에 클로저를 작성해주면된다!

아래는 이를 활용해 작성한 NetworkProvider 테스트 코드입니다!

```swift
MockURLProtocol.requestHandler = { _ in
  let httpResponse = HTTPURLResponse()
  let data = Data()
  return (httpResponse, data)
}
```
요렇게 해주면 원하는 HTTPURLResponse, Data를 반환 받을수 있다!

```swift
class NetworkProviderTest: XCTestCase {
    var sut: NetworkProvider!

    override func setUpWithError() throws {
        let session = self.makeMockUrlSession()
        self.sut = NetworkProvider(urlSession: session)
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_네트워크가_연결이_되지않아도_request를_호출할때_예상값을_반환한다() {
        // given
        let promise = expectation(description: "Test Request")
        self.makeResult()
        let endPoint = EndPoint(baseURL: "Test")

        // when
        _ = self.sut.request(endPoint: endPoint)
            .decode(type: ProductList.self, decoder: Json.decoder)
            .subscribe { productList in
                let result = productList.itemsPerPage
                let expected = 20
                XCTAssertEqual(expected, result)
                promise.fulfill()
            } onError: { error in
                XCTFail(error.localizedDescription)
                promise.fulfill()
            }
        wait(for: [promise], timeout: 10)
}

extension NetworkProviderTest {
    private func makeMockUrlSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }

    private func makeResult() {
        MockURLProtocol.requestHandler = { _ in
            let httpResponse = HTTPURLResponse()
            let data = NSDataAsset(name: "products")!.data
            return (httpResponse, data)
        }
    }
}
```

### 2️⃣ SegmentControl의 Underlin 위치를 고정값이아닌 동적으로 계산해줄순 없을까? 🤔
어떻게 구현했는지는 블로그에 정리해 두었습니다! :) [말랑 블로그](https://marlangmarlang.tistory.com/93)

![](https://i.imgur.com/ITiMx68.gif)

이번 프로젝트를 진행하면서 오늘의집APP에서 본 Underline SegmentControl을 만들어 보고싶었다.
UISegmentedControl을 상속받는 Custom SegmentControl을 만들어주었고 내부에 underlineView를 프로퍼티로 소유하고 
underlineView의 위치를 변경해주는 메서드를 구현해 layoutSubviews() 에서 호출하도록 해주었다.(레이아웃을 다시 그려야할때마다 해당 메서드를 호출해주기 위함이다.)
기능상의 문제는 없었지만 underlineView의 위치와 크기를 고정값으로 할당해주기 때문에 디바이스의 크기가 달라지는 경우 의도하지 않은 크기와 위치에 언더라인뷰가 위치하는 문제가 발생했다.

디바이스의 크기가 달라져도 대응할수 있도록 동적으로 계산해줄수 없을까? 고민하였고 SegmentControl의 numberOfSegments, selectedSegmentIndex, 그리고 SegmentControl의 bounds 를 이용해 문제를 해결할수 있지 않을까? 생각했고 다음과 같은 방법으로 문제를 해결할수 있었다!
```swift
func changeUnderlinePosition() {
        //UnderlineView의 width가 SegmentIndex의 절반이 될수 있도록 계산하도록 했다!
        let width = self.bounds.size.width / (CGFloat(self.numberOfSegments) * 2)
        //underLinewView의 높이
        let height = 7.0
         
        //UnderlineView의 위치는 UnderlineView의 중앙이 selectedSegmentIndex의 중앙과 동일하도록 해주기 위해 다음과 같이 계산하도록 했다!
        //UnderlineView를 얼마만큼 띄워줄것인가? underlineView의 width크기는 SegmentIndex의 절반이니까 width 를 2로 나누게 되면 4/1 의 크기가 된다!
        //4/1 만큼 띄운곳에서 그리기 시작하면 underLineView가 그려지고 난뒤의 공간도 동일하게 SegmentIndex의 4/1 의 공간이 남게 된다!
        let spacer = width / 2
        //SegmentIndex의 구분점을 만들기위해 아래와 같이 계산해주었다. 만약 self.bounds.width가 100이라면 SegmentControl의 item의 갯수가2개 일때는 50 이된다.
        //각 SegmentIndex의 width의 크기가 50 이된다는 뜻이다!
        let dividePotin = self.bounds.width / CGFloat(self.numberOfSegments)
        //위에 계산해둔것들을 활용해 실제 어떤 위치에 그려질것인지를 계산해주었다.
        let xPosition = CGFloat(self.selectedSegmentIndex) * dividePotin + spacer
        let yPosition = self.bounds.size.height - height
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        //애니메이션도 추가해줬다!
        UIView.animate(withDuration: 0.1) {
            self.underlineView.frame = frame
        }
    }
```

### 3️⃣ CustomButton 을 재활용 할수 없을까? 🤔

앱에서 상품을 등록하기위해 상품등록 View로 전환하는 동그란 버튼을 구현했다.

![](https://i.imgur.com/V9Zip3W.gif)

UIButton을 상속받도록 하고 draw메서드를 override하여 CoreGraphics 를 활용해 원하는 이미지를 그려주었다.

버튼을 tap 할경우 isHighlighted Bool값이 true -> false 변경되는것을 이용해 애니메이션을 추가해주었다.

추후 앱을 개발하면서 상품등록 View 에서 상품의 이미지를 추가하기 위해 동일한 이미지 이지만 원형이 아닌 사각형의 버튼이 필요해졌는데 기존에 구현한 버튼을 재활용 할수 있도록 할수 없을까? 고민하였다.

원형으로 구현하지 않고 사각형으로 구현해 사용처에서 cornerRadius 의 값을 변경하여 원하는 모양으로 사용할수 있을까? 생각하였고 쉽게 문제를 해결할수 있었다.

```swift
final class AddButton: UIButton {
    //isHighlighted는 버튼을 탭할경우 true -> false 로 변경되는 
    //특징을 이용해 해당값에 변화가 있다면 애니메이션 효과를 주도록 하였다.
    override var isHighlighted: Bool {
        didSet {
            self.didTapButtonAnimation()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        //네모를 그리고!
        self.drawRectangle()
        //네모 내부에 + 모양의 선을 그려줍니다!
        self.drawAddLine()
    }

    private func setupButton() {
        self.backgroundColor = .systemBackground
        self.clipsToBounds = true
    }

    private func drawRectangle() {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        let height = bounds.height
        let width = bounds.width

        context.setLineCap(.round)
        context.setFillColor(#colorLiteral(red: 1, green: 0.7698566914, blue: 0.8562441468, alpha: 1))

        let rect = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: width, height: height)
        )
        context.addRect(rect)
        context.fillPath()
    }

    private func drawAddLine() {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        let height = bounds.height
        let width = bounds.width

        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(3)
        context.move(to: CGPoint(x: width * 0.2, y: height * 0.5))
        context.addLine(to: CGPoint(x: width * 0.8, y: height * 0.5))
        context.move(to: CGPoint(x: width * 0.5, y: height * 0.2))
        context.addLine(to: CGPoint(x: width * 0.5, y: height * 0.8))
        context.drawPath(using: .stroke)
    }

    private func didTapButtonAnimation() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
            self.transform = CGAffineTransform.identity
        }
    }
}

```


### 4️⃣ 빠르게 스크롤하면 메모리가 너무많이 사용되는데..!? 메모리 사용량을 줄일수 없을까? 🤔

