# ๐ iOS-malrang-market 
> ํ๋ก์ ํธ ๊ธฐ๊ฐ 2022.08.14 ~ 2022.09    
๊ฐ๋ฐ์ : [malrang](https://github.com/malrang-malrang) 

# ๐ ๋ชฉ์ฐจ
- [ํ๋ก์ ํธ ์๊ฐ](#-ํ๋ก์ ํธ-์๊ฐ)
- [ํ๋ก์ ํธ ์คํํ๋ฉด](#-ํ๋ก์ ํธ-์คํํ๋ฉด)
- [๊ฐ๋ฐํ๊ฒฝ ๋ฐ ๋ผ์ด๋ธ๋ฌ๋ฆฌ](#-๊ฐ๋ฐํ๊ฒฝ-๋ฐ-๋ผ์ด๋ธ๋ฌ๋ฆฌ)
- [App ๊ตฌ์กฐ](#-app-๊ตฌ์กฐ)
- [๊ณ ๋ฏผํ์ , ํธ๋ฌ๋ธ ์ํ](#-๊ณ ๋ฏผํ์ -ํธ๋ฌ๋ธ-์ํ)

---
## ๐ ํ๋ก์ ํธ ์๊ฐ
<img src="https://i.imgur.com/SvAapwx.jpg" width="830">

---
## ๐บ ํ๋ก์ ํธ ์คํํ๋ฉด
|ListView|GridView|Pagenation|
|--|--|--|
|<img src="https://i.imgur.com/b9RrSRb.gif" width="250">|<img src="https://i.imgur.com/9JDZKMg.gif" width="250">|<img src="https://i.imgur.com/tIDICls.gif" width="250">|

|DetailViewView|EditView|RegistrationView|
|--|--|--|
|<img src="https://i.imgur.com/BhrbhpW.gif" width="250">|<img src="https://i.imgur.com/8EB772I.gif" width="250">|<img src="https://i.imgur.com/drwUmGp.gif" width="250">|

|ContextMenu|ContextMenu๋ฅผ ํตํ ํ๋ฉด ์ ํ|Paging|
|--|--|--|
|<img src="https://i.imgur.com/ie9iGgm.gif" width="250">|<img src="https://i.imgur.com/riKkFpc.gif" width="250">|<img src="https://i.imgur.com/I2c5lHq.gif" width="250">|

---
## ๐  ๊ฐ๋ฐํ๊ฒฝ ๋ฐ ๋ผ์ด๋ธ๋ฌ๋ฆฌ
[![swift](https://img.shields.io/badge/swift-5.0-orange)]() [![xcode](https://img.shields.io/badge/Xcode-13.3.1-blue)]() [![iOS](https://img.shields.io/badge/iOS-13-red)]() [![SwiftLint](https://img.shields.io/badge/SwiftLint-0.47.1-orange)]() [![Snapkit](https://img.shields.io/badge/Snapkit-5.6-orange)]() [![Rxswift](https://img.shields.io/badge/Rxswift-6.5-hotpink)]() [![RxCocoa](https://img.shields.io/badge/RxCocoa-6.5-hotpink)]()

---
## ๐ App ๊ตฌ์กฐ
### Coordinator
<img src="https://i.imgur.com/HX5fqKU.png" width="600">

#### Coordinator ์ ์ฉํ ์ด์ 
- ์ด์  ํ๋ก์ ํธ ์์ ๊ฐ๊ฐ ๋ค๋ฅธ View ์์ ๋์ผํ View๋ก ํ๋ฉด์ ํ์ ์ค๋ณต์ฝ๋๊ฐ ์๊ฒจ๋๊ณ , ๊ฐ ๋ค๋ฅธ View์์ ๋์ผํ Class ์ธ์คํด์ค ๋ฅผ ์ฃผ์๋ฐ์์ผ ํ๋ ์ํฉ์ด ๋ฐ์ํด ์ด๋ฅผ ํด๊ฒฐํ๊ณ ์ Coordinator ํจํด์ ๋ํด ๊ณต๋ถํ๊ณ  ์ ์ฉํ์ต๋๋ค.
- Coordinator ํจํด์ ์ ์ฉํด ํ๋ฉด ์ ํ ๋ก์ง์ ViewController ์์ ๋ถ๋ฆฌ ํ์๊ณ , ViewController ๊ฐ์ ์์กด์ฑ์ ์ ๊ฑฐ ํ์์ต๋๋ค.

### MVVM, CleanArchitecture
<img src="https://i.imgur.com/nB50IBY.png" width="800">

#### ์ ์ฉํ ์ด์ 
- ๊ธฐ์กด MVVM์ ๊ฒฝ์ฐ MVC๋ณด๋ค๋ ๊ณ์ธต์ด ๋ถ๋ฆฌ๋๊ณ , ๊ฐ์ฒด๋ค์ ๊ด์ฌ์ฌ๊ฐ ๋ถ๋ฆฌ๋์ง๋ง ๊ทธ๋ผ์๋ ViewModel์ ์ญํ ์ด ์ปค์ง๋ ๋ฌธ์ ๊ฐ ๋ฐ์ํ์ต๋๋ค.
- CleanArchitecture๋ฅผ ํตํด Layer๋ฅผ ํ์ธต ๋ ๋๋์ด ์ฃผ๋ฉด์ ๊ณ์ธต๋ณ๋ก ๊ด์ฌ์ฌ๊ฐ ๋๋์ด์ง๊ฒ ๋๊ณ , ์์ฐ์ค๋ฝ๊ฒ ๊ฐ๊ฐ์ ๊ฐ์ฒด๋ค์ ์ญํ ์ด ๋๋์ด ์ง๋๋ก ํ์์ต๋๋ค.
- ์ด๋ก ์ธํด ๊ฐ์ฒด๋ค์ ๊ฒฐํฉ๋๊ฐ ๋ฎ์์ง๊ณ , ์์ง๋๋ ๋์์ง๋ฉด์ ๋ฌธ์ ๊ฐ ๋ฐ์ํ์ ๋ ์ฝ๊ฒ ์ฐพ์ ์ ์๊ณ  ํด๋น ๋ถ๋ถ๋ง ์์ ์ด ๊ฐ๋ฅํด์ง๋ฉด์ ์ ์ง๋ณด์์ ์ธ ์ธก๋ฉด์์ ์๋นํ ์ด์ ์ ๊ฐ์ ์ ์๊ฒ ๋์์ต๋๋ค.

---
## ๐ค ๊ณ ๋ฏผํ์ , ํธ๋ฌ๋ธ ์ํ

### 1๏ธโฃ ๋คํธ์ํฌ ํต์ ๊ณผ ๋ฌด๊ดํ๋๋ก Mock ๊ฐ์ฒด๋ฅผ ๋ง๋ค์ด Test ํ๋ ๋ฐฉ๋ฒ? ๐ค
์์ ์๋ URLSession์ ํ๋กํ ์ฝ๋ก ์ถ์ํํ์ฌ URLSession ๋ง๊ณ  dataTask() ๋ฉ์๋๋ฅผ ๊ฐ์ง Mock๊ฐ์ฒด๋ฅผ ์ฃผ์ํ์ฌ ํ์คํธ ํ์๋๋ฐ URLProtocol๋ผ๋ ํค์๋๋ฅผ ์๊ฒ๋์๊ณ  ๊ฒฐ๋ก ์ ์ผ๋ก URLProtocol์ ํ์ฉํ๊ฒ๋๋ฉด ๋คํธ์ํฌ ์์ฒญ๋ ํ๊ณ , ๋ฐ์ดํฐ๋ ํ์คํธ ํ ์ ์๊ฒ๋์ด ์ด๋ฅผ ์ ์ฉํด๋ณด์์ต๋๋ค.

**1. ๋คํธ์ํฌ ํต์ ๊ณผ ๋ฌด๊ดํ ํ์คํธ๋ฅผ ์ ํด์ผํ ๊น??**
- ์ ๋ ํ์คํธ๋ ๋น ๋ฅด๊ณ  ์์ ์ ์ผ๋ก ์งํ๋์ด์ผ ํ๋ค. ์ค์  ์๋ฒ์ ํต์ ํ๊ฒ๋๋ฉด ๋จ์ ํ์คํธ์ ์๋๊ฐ ๋๋ ค์ง ๋ฟ๋ง ์๋๋ผ ์ธํฐ๋ท ์ฐ๊ฒฐ์ ์์กดํ๊ธฐ ๋๋ฌธ์ ํ์คํธ๋ฅผ ์ ๋ขฐํ  ์ ์๋ค.
- ์ค์  ์๋ฒ์ ํต์ ํ๋ฉด ์๋์น ์์ ๊ฒฐ๊ณผ๋ฅผ ๋ถ๋ฌ์ฌ ์ ์๋ค. ์๋ฅผ๋ค์ด ์๋ฒ์ ์์ฒญํด์ ๋ฐ์ดํฐ๋ฅผ ๊ฐ์ ธ์ฌ๋, ์๋ฒ์ ์ ์ฅ๋๊ฐ์ด ๋ณ๊ฒฝ๋ ์ ์๊ธฐ ๋๋ฌธ์ ํญ์ ์ํ๋ ๊ฐ์ ๋ฐ์์์์๊ฒ์ด๋ผ๋ ๋ณด์ฅ์ด ์๋ค.
- ์๋ฒ์์ ์ฃผ๋ ๋ฐ์ดํฐ์ ์๊ด์์ด ๊ตฌํํ ๊ธฐ๋ฅ๋ค์ด ์ ์๋ํ๋์ง ํ์คํธ ํด์ผํ๊ธฐ ๋๋ฌธ์ด๋ค.

**2. ๋คํธ์ํฌ ํต์ ๊ณผ ๋ฌด๊ดํ ํ์คํธ๋ ์ด๋ป๊ฒ ํด์ผํ ๊น??**
- ๋คํธ์ํฌ ํต์ ์ ํตํด ๋ฐ์ดํฐ๋ฅผ ์ ๋ฌ ๋ฐ์๋๋ URLSession ์ ๊ตฌํ๋ ๋ฉ์๋์ธ dataTask()๋ฉ์๋๋ฅผ ํ์ฉํ๋ค.
- ๋ด๋ถ์์ ์ด๋ป๊ฒ ์๋๋๋์ง ์์ ์์ง๋ง ์ฐ๋ฆฌ๋ URL ํน์ URLRquest์ ๊ฐ์ dataTask() ๋ฉ์๋์ ์ธ์๋ก ์ ๋ฌํ์ฌ ๋ฐ์ดํฐ๋ฅผ ๋ฐ์์ค๊ฒ๋๋ค!
- ๊ทธ๋ ๋ค๋ฉด ์ฐ๋ฆฌ๊ฐ ํด์ฃผ์ด์ผํ ๊ฒ์ dataTask() ๋ฉ์๋๋ฅผ ์กฐ์ํ๋๊ฒ์ด ํต์ฌ์ด๋ ๊ฒ์ด๋ค!

**3. ๋คํธ์ํฌ ํต์ ๊ณผ ๋ฌด๊ดํ ํ์คํธ๋ฅผ ํ๊ธฐ์ํด ํ์ํ๊ฒ๋ค**
- ๋คํธ์ํฌ์ ํต์ ํ  ์์๋ ๊ฐ์ฒด๊ฐ ํ์ํ ๊ฒ์ด๋ค.
- ๋คํธ์ํฌ์ ํต์ ํ  ์์๋ ๊ฐ์ฒด๊ฐ ๊ฐ์ง URLSessionํ์์ ํ๋กํผํฐ๋ URLSessionํ์์ ์ฃผ์๋ฐ์์ ์๋๋ก ํ๋ค.
- ์ฌ๊ธฐ์ ์ฃผ์ํด์ฃผ์ด์ผ ํ๋ URLSession์ ์๋ํ HTTPURLResponse, Data ๋ฅผ ๋ฐํํ๋ Mock๊ฐ์ฒด๋ฅผ ์ด์ฉํด ๋ง๋  URLSession์ด๋ค.
- ์์๊ฐ์ด ๊ตฌํํด์ฃผ์๋ค๋ฉด ์๋ํ ๊ฐ์ ๋ฐํํ๋ dataTask() ๋ฉ์๋๋ฅผ ๊ฐ์ง URLSessionํ์์ ํ๋กํผํฐ ์ฌ์ฉํ ์ ์๊ฒ๋๋ค.

**4. ๋คํธ์ํฌ ํต์ ๊ณผ ๋ฌด๊ดํ ํ์คํธ๋ฅผ ํด๋ณด์!**
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
์์๊ฐ์ด URLSession์ ์ฃผ์๋ฐ๋ ๋คํธ์ํฌ์ ํต์ ํ ์ ์๋ ๊ฐ์ฒด๋ฅผ ๋ง๋ค์ด ์ฃผ์๋ค.
ํ์คํธ ์ฝ๋์์๋ NetworkProvider์ request()๋ฉ์๋๋ฅผ ํ์คํธํ๊ฒ ๋ ํ๋ฐ!
์๋ํ ๊ฐ์ ๋ฐํํ๋ URLSession์ ์ฃผ์ ์ํฌ์ ์๋๋ก Mock๊ฐ์ฒด๋ฅผ ํ๋ ๋ง๋ค์ด๋ณด์!

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
์์์ ์ฌ์ฉ๋ URLProtocol์ URL ๋ฐ์ดํฐ ๋ก๋ฉ์ ๋ค๋ฃจ๋ ์ถ์ํด๋์ค๋ค.
startLoading๋ฉ์๋๋ ์ธ๋ถ์์ ์ฃผ์ํ(requestHandler ํ๋กํผํฐ) Block์ ํตํด ์ํ๋ ์๋ต๊ฐ์ ๋ด๋ ค๋ฐ์์ ์๋๋ก ๋ง๋ค์๋ค.

์ด๋์์ ๊ฐ์ง๊ณ  URLSession์ ์์ฑํด์ฃผ๋ฉด๋๋ค!

```swift
let configuration = URLSessionConfiguration.default
configuration.protocolClasses = [MockURLProtocol.self]
let urlSession = URLSession(configuration: configuration)
```
์ด์  MockURLProtocol์ URLSessionConfiguration์ protocolClasses์ ๋ฃ๊ณ , ์ด Configuration์ ๊ฐ์ง๋ URLSession์ ๋ง๋ค์ด์ฃผ์๋ค.

ํ์คํธํ ๋๋ ์ด์  ์ด๋ ๊ฒ ๋ง๋ค์ด์ค URLSession์ NetworkProvider์ ์ฃผ์ํด์ฃผ๋ฉด๋๋ค!

์์ง ํด์ผํ ์ผ์ด ๋จ์๋ค..! URLSession์ ์ฃผ์ํ๋๋ฐ์ ์ฑ๊ณตํ์ผ๋ฉด ์ด์  URLSession์ด ์๋ํ ๊ฐ์ ๋ฐํํ๋๋ก ํด์ฃผ์ด์ผ ํ๋ค!
MockURLProtocol์ requestHandler์ ํด๋ก์ ๋ฅผ ์์ฑํด์ฃผ๋ฉด๋๋ค!

์๋๋ ์ด๋ฅผ ํ์ฉํด ์์ฑํ NetworkProvider ํ์คํธ ์ฝ๋์๋๋ค!

```swift
MockURLProtocol.requestHandler = { _ in
  let httpResponse = HTTPURLResponse()
  let data = Data()
  return (httpResponse, data)
}
```
์๋ ๊ฒ ํด์ฃผ๋ฉด ์ํ๋ HTTPURLResponse, Data๋ฅผ ๋ฐํ ๋ฐ์์ ์๋ค!

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

    func test_๋คํธ์ํฌ๊ฐ_์ฐ๊ฒฐ์ด_๋์ง์์๋_request๋ฅผ_ํธ์ถํ ๋_์์๊ฐ์_๋ฐํํ๋ค() {
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

### 2๏ธโฃ SegmentControl์ Underlin ์์น๋ฅผ ๊ณ ์ ๊ฐ์ด์๋ ๋์ ์ผ๋ก ๊ณ์ฐํด์ค์ ์์๊น? ๐ค
์ด๋ป๊ฒ ๊ตฌํํ๋์ง๋ ๋ธ๋ก๊ทธ์ ์ ๋ฆฌํด ๋์์ต๋๋ค! :) [๋ง๋ ๋ธ๋ก๊ทธ](https://marlangmarlang.tistory.com/93)

![](https://i.imgur.com/ITiMx68.gif)

์ด๋ฒ ํ๋ก์ ํธ๋ฅผ ์งํํ๋ฉด์ ์ค๋์์งAPP์์ ๋ณธ Underline SegmentControl์ ๋ง๋ค์ด ๋ณด๊ณ ์ถ์๋ค.
UISegmentedControl์ ์์๋ฐ๋ Custom SegmentControl์ ๋ง๋ค์ด์ฃผ์๊ณ  ๋ด๋ถ์ underlineView๋ฅผ ํ๋กํผํฐ๋ก ์์ ํ๊ณ  
underlineView์ ์์น๋ฅผ ๋ณ๊ฒฝํด์ฃผ๋ ๋ฉ์๋๋ฅผ ๊ตฌํํด layoutSubviews() ์์ ํธ์ถํ๋๋ก ํด์ฃผ์๋ค.(๋ ์ด์์์ ๋ค์ ๊ทธ๋ ค์ผํ ๋๋ง๋ค ํด๋น ๋ฉ์๋๋ฅผ ํธ์ถํด์ฃผ๊ธฐ ์ํจ์ด๋ค.)
๊ธฐ๋ฅ์์ ๋ฌธ์ ๋ ์์์ง๋ง underlineView์ ์์น์ ํฌ๊ธฐ๋ฅผ ๊ณ ์ ๊ฐ์ผ๋ก ํ ๋นํด์ฃผ๊ธฐ ๋๋ฌธ์ ๋๋ฐ์ด์ค์ ํฌ๊ธฐ๊ฐ ๋ฌ๋ผ์ง๋ ๊ฒฝ์ฐ ์๋ํ์ง ์์ ํฌ๊ธฐ์ ์์น์ ์ธ๋๋ผ์ธ๋ทฐ๊ฐ ์์นํ๋ ๋ฌธ์ ๊ฐ ๋ฐ์ํ๋ค.

๋๋ฐ์ด์ค์ ํฌ๊ธฐ๊ฐ ๋ฌ๋ผ์ ธ๋ ๋์ํ ์ ์๋๋ก ๋์ ์ผ๋ก ๊ณ์ฐํด์ค์ ์์๊น? ๊ณ ๋ฏผํ์๊ณ  SegmentControl์ numberOfSegments, selectedSegmentIndex, ๊ทธ๋ฆฌ๊ณ  SegmentControl์ bounds ๋ฅผ ์ด์ฉํด ๋ฌธ์ ๋ฅผ ํด๊ฒฐํ ์ ์์ง ์์๊น? ์๊ฐํ๊ณ  ๋ค์๊ณผ ๊ฐ์ ๋ฐฉ๋ฒ์ผ๋ก ๋ฌธ์ ๋ฅผ ํด๊ฒฐํ ์ ์์๋ค!
```swift
func changeUnderlinePosition() {
        //UnderlineView์ width๊ฐ SegmentIndex์ ์ ๋ฐ์ด ๋ ์ ์๋๋ก ๊ณ์ฐํ๋๋ก ํ๋ค!
        let width = self.bounds.size.width / (CGFloat(self.numberOfSegments) * 2)
        //underLinewView์ ๋์ด
        let height = 7.0
         
        //UnderlineView์ ์์น๋ UnderlineView์ ์ค์์ด selectedSegmentIndex์ ์ค์๊ณผ ๋์ผํ๋๋ก ํด์ฃผ๊ธฐ ์ํด ๋ค์๊ณผ ๊ฐ์ด ๊ณ์ฐํ๋๋ก ํ๋ค!
        //UnderlineView๋ฅผ ์ผ๋ง๋งํผ ๋์์ค๊ฒ์ธ๊ฐ? underlineView์ widthํฌ๊ธฐ๋ SegmentIndex์ ์ ๋ฐ์ด๋๊น width ๋ฅผ 2๋ก ๋๋๊ฒ ๋๋ฉด 4/1 ์ ํฌ๊ธฐ๊ฐ ๋๋ค!
        //4/1 ๋งํผ ๋์ด๊ณณ์์ ๊ทธ๋ฆฌ๊ธฐ ์์ํ๋ฉด underLineView๊ฐ ๊ทธ๋ ค์ง๊ณ  ๋๋ค์ ๊ณต๊ฐ๋ ๋์ผํ๊ฒ SegmentIndex์ 4/1 ์ ๊ณต๊ฐ์ด ๋จ๊ฒ ๋๋ค!
        let spacer = width / 2
        //SegmentIndex์ ๊ตฌ๋ถ์ ์ ๋ง๋ค๊ธฐ์ํด ์๋์ ๊ฐ์ด ๊ณ์ฐํด์ฃผ์๋ค. ๋ง์ฝ self.bounds.width๊ฐ 100์ด๋ผ๋ฉด SegmentControl์ item์ ๊ฐฏ์๊ฐ2๊ฐ ์ผ๋๋ 50 ์ด๋๋ค.
        //๊ฐ SegmentIndex์ width์ ํฌ๊ธฐ๊ฐ 50 ์ด๋๋ค๋ ๋ป์ด๋ค!
        let dividePotin = self.bounds.width / CGFloat(self.numberOfSegments)
        //์์ ๊ณ์ฐํด๋๊ฒ๋ค์ ํ์ฉํด ์ค์  ์ด๋ค ์์น์ ๊ทธ๋ ค์ง๊ฒ์ธ์ง๋ฅผ ๊ณ์ฐํด์ฃผ์๋ค.
        let xPosition = CGFloat(self.selectedSegmentIndex) * dividePotin + spacer
        let yPosition = self.bounds.size.height - height
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        //์ ๋๋ฉ์ด์๋ ์ถ๊ฐํด์คฌ๋ค!
        UIView.animate(withDuration: 0.1) {
            self.underlineView.frame = frame
        }
    }
```

### 3๏ธโฃ CustomButton ์ ์ฌํ์ฉ ํ ์ ์์๊น? ๐ค

์ฑ์์ ์ํ์ ๋ฑ๋กํ๊ธฐ์ํด ์ํ๋ฑ๋ก View๋ก ์ ํํ๋ ๋๊ทธ๋ ๋ฒํผ์ ๊ตฌํํ๋ค.

<img src="https://i.imgur.com/V9Zip3W.gif" width="200"><img src="https://i.imgur.com/9etQMYq.gif" width="200">

UIButton์ ์์๋ฐ๋๋ก ํ๊ณ  draw๋ฉ์๋๋ฅผ overrideํ์ฌ CoreGraphics ๋ฅผ ํ์ฉํด ์ํ๋ ์ด๋ฏธ์ง๋ฅผ ๊ทธ๋ ค์ฃผ์๋ค.

๋ฒํผ์ tap ํ ๊ฒฝ์ฐ isHighlighted Bool๊ฐ์ด true -> false ๋ณ๊ฒฝ๋๋๊ฒ์ ์ด์ฉํด ์ ๋๋ฉ์ด์์ ์ถ๊ฐํด์ฃผ์๋ค.

์ถํ ์ฑ์ ๊ฐ๋ฐํ๋ฉด์ ์ํ๋ฑ๋ก View ์์ ์ํ์ ์ด๋ฏธ์ง๋ฅผ ์ถ๊ฐํ๊ธฐ ์ํด ๋์ผํ ์ด๋ฏธ์ง ์ด์ง๋ง ์ํ์ด ์๋ ์ฌ๊ฐํ์ ๋ฒํผ์ด ํ์ํด์ก๋๋ฐ ๊ธฐ์กด์ ๊ตฌํํ ๋ฒํผ์ ์ฌํ์ฉ ํ ์ ์๋๋ก ํ ์ ์์๊น? ๊ณ ๋ฏผํ์๋ค.

์ํ์ผ๋ก ๊ตฌํํ์ง ์๊ณ  ์ฌ๊ฐํ์ผ๋ก ๊ตฌํํด ์ฌ์ฉ์ฒ์์ cornerRadius ์ ๊ฐ์ ๋ณ๊ฒฝํ์ฌ ์ํ๋ ๋ชจ์์ผ๋ก ์ฌ์ฉํ ์ ์์๊น? ์๊ฐํ์๊ณ  ์ฝ๊ฒ ๋ฌธ์ ๋ฅผ ํด๊ฒฐํ ์ ์์๋ค.

```swift
final class AddButton: UIButton {
    //isHighlighted๋ ๋ฒํผ์ ํญํ ๊ฒฝ์ฐ true -> false ๋ก ๋ณ๊ฒฝ๋๋ 
    //ํน์ง์ ์ด์ฉํด ํด๋น๊ฐ์ ๋ณํ๊ฐ ์๋ค๋ฉด ์ ๋๋ฉ์ด์ ํจ๊ณผ๋ฅผ ์ฃผ๋๋ก ํ์๋ค.
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
        //๋ค๋ชจ๋ฅผ ๊ทธ๋ฆฌ๊ณ !
        self.drawRectangle()
        //๋ค๋ชจ ๋ด๋ถ์ + ๋ชจ์์ ์ ์ ๊ทธ๋ ค์ค๋๋ค!
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


### 4๏ธโฃ ๋น ๋ฅด๊ฒ ์คํฌ๋กคํ๋ฉด ๋ฉ๋ชจ๋ฆฌ๊ฐ ๋๋ฌด๋ง์ด ์ฌ์ฉ๋๋๋ฐ.. ๋ฉ๋ชจ๋ฆฌ ์ฌ์ฉ๋์ ์ค์ผ์ ์์๊น? ๐ค

**ํ์ฌ API๊ฐ ์๋ฒ ์ด์  ๋ฌธ์ ๋ก ๋ฐ์ดํฐ๋ฅผ ๊ฐ์ ธ์ฌ์๊ฐ ์์ด์ ๋ฉ๋ชจ๋ฆฌ ์ฌ์ฉ๋ ์ ํ ๋น๊ต ์ฌ์ง์ ์ถํ์ ๊ธฐ์ฌํ  ์์ ์๋๋ค..!**

์ฑ์ ๋ฉ์ธ๋ทฐ์๋ ์๋ฒ์์ ๋ฑ๋ก๋ ์ํ๋ค์ ์ ๋ณด๊ฐ List, Grid ํ์์ผ๋ก ๋์ด ๋์ด์๋๋ฐ ์คํฌ๋กค์ ์์๋๋ก ๋น ๋ฅด๊ฒ ์์ง์ด๊ฒ๋ ๊ฒฝ์ฐ ๋ฉ๋ชจ๋ฆฌ ์ฌ์ฉ๋์ด ๊ฒ์ ์ฆ๊ฐํ๋ ์ํฉ์ด ๋ฐ์ํ๋ค..!(500mb ๋๊ฒ ์ฌ์ฉ๋๋๊ฑธ ํ์ธํ๋๋ฐ ๋๋น ๋ฅด๊ฒ ํ๋ฉด ๋๋ง์ด ์ฌ์ฉํ ์ง๋..!??๐ค)

๋ฌด์์ด ๋ฌธ์ ์ผ๊น..! ์คํฌ๋กค์ ๋น ๋ฅด๊ฒ ํ ์๋ก ์๋ฒ์ ํต์ ๋์ด ๋ง์์ง๊ณ  ๊ทธ์ค์๋ ์ด๋ฏธ์ง๋ฅผ ๊ฐ์ ธ์ค๋ ์์์ด ๋ฉ๋ชจ๋ฆฌ๋ฅผ ๋ง์ด ์ฌ์ฉํ ๊ฑฐ๋ผ ์ถ์ธกํ๋ค.

์์๊ฐ์ ์ํฉ์์ ๋ฉ๋ชจ๋ฆฌ ์ฌ์ฉ๋์ ์ค์ผ์ ์๋ ๋ฐฉ๋ฒ์ ์ฐพ๊ฒ๋์๊ณ  Cache๋ฅผ ํ์ฉํด ํด๊ฒฐํ์๋ค!

Cache์๋ํด์๋ ์๋ ๋ธ๋ก๊ทธ์ ๊ฐ๋จํ๊ฒ ์ ๋ฆฌํด ๋์๋ค!
[๋ง๋๋ธ๋ก๊ทธ Cache ๊ฐ๋จ ์ ๋ฆฌ](https://marlangmarlang.tistory.com/104)


```swift
final class ImageCacheManager {
    static let shared = ImageCacheManager()

    let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        return cache
    }()

    private init() {}
}
```
๋ค์๊ณผ ๊ฐ์ด ์บ์์ ์ด๋ฏธ์ง๋ฅผ ์ต๋ 100๊ฐ ์ ์ฅํ ์ ์๋๋ก Singletone ์ผ๋ก ๊ตฌํํด์ฃผ์๋ค!

```swift
@discardableResult
    func download(
        with urlString: String,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            return nil
        }

        let task = session.dataTask(with: url) { data, response, error in

            if let error = error as? ImageDownloadError {
                return completion(.failure(error))
            }

            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(ImageDownloadError.responseError))
            }

            guard (200..<300).contains(response.statusCode) else {
                return completion(.failure(ImageDownloadError.statusCodeError(statusCode: response.statusCode)))
            }

            guard let data = data else {
                return completion(.failure(ImageDownloadError.emptyDataError))
            }

            guard let image = UIImage(data: data) else {
                return completion(.failure(ImageDownloadError.imageConvertError))
            }

            completion(.success(image))
        }
        task.resume()
        return task
    }
```

๊ทธ๋ฆฌ๊ณ  URL String์ผ๋ก ํต์ ํด ์ด๋ฏธ์ง๋ฅผ ๋ค์ด๋ก๋ ํ๋ ์๋์ ๊ฐ์ ๋ฉ์๋๋ฅผ ๊ตฌํํด ์ฃผ์๋ค.
ํด๋น ํ๋ก์ ํธ์ API์์ ์ด๋ฏธ์ง๋ฅผ String๊ฐ์ผ๋ก ์ ๋ฌ๋ฐ๊ธฐ ๋๋ฌธ์ String์ผ๋ก ์๋ฒ์ ํต์ ํด ์ด๋ฏธ์ง๋ฅผ ๋ค์ด๋ฐ์์ ์๋๋ก ๊ตฌํํ ๊ฒ์ด๋ค!

```swift
extension UIImageView {
    private var imageDownloadTask: URLSessionDataTask? {
        get { objc_getAssociatedObject(self, "image") as? URLSessionDataTask }
        set { objc_setAssociatedObject(self, "image", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func setImage(with urlstring: String, placeholder: UIImage? = nil) {
        self.imageDownloadTask?.suspend()
        self.imageDownloadTask?.cancel()

        let cache = ImageCacheManager.shared.cache

        if let cacheImage = cache.object(forKey: urlstring as NSString) {
            return self.image = cacheImage
        }

        self.imageDownloadTask = ImageDownloader.default.download(with: urlstring) { result in
            switch result {
            case .success(let image):
                cache.setObject(image, forKey: urlstring as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
                return
            case .failure:
                guard let placeholder = placeholder else { return }
                DispatchQueue.main.async {
                    self.image = placeholder
                }
                return
            }
        }
    }
}
```
์์ ๊ตฌํํ ์บ์์ ์ด๋ฏธ์ง ๋ค์ด๋ก๋๋ฅผ ํ์ฉํด UIImageView๋ฅผ extensionํ์ฌ ์์ ๊ฐ์ ๋ฉ์๋๋ฅผ ๋ง๋ค์ด ์ฃผ์๋ค.

์ธ์๋ก ์ ๋ฌ๋ฐ์ urlString๊ฐ์ด ์บ์์ ์ ์ฅ๋ ํค์ ์ผ์นํ๋ ๊ฒ์ด ์๋ค๋ฉด ๊บผ๋ด์ ์ฌ์ฉํ๋๋ก ํ์๊ณ , ์ผ์นํ๋ ๊ฒ์ด ์๋ค๋ฉด ๋คํธ์ํฌ ํต์ ์ ํตํด ์ด๋ฏธ์ง๋ฅผ ๋ค์ด๋ฐ๊ณ  ์บ์์ ์ ์ฅํ๋๋ก ํ์๋ค.

์์ setImage๋ ๋ผ์ด๋ธ๋ฌ๋ฆฌ KingFisher๋ฅผ ์ฐธ๊ณ ํด ๊ตฌํํ์ผ๋ฉฐ ๋์ผํ ImageView๊ฐ ์ด๋ฏธ ๋คํธ์ํฌ ํต์ ์ ํ์ฌ ์ด๋ฏธ์ง๋ฅผ ๋ค์ด๋ก๋ ํ๋์ค์ด๋ผ๋ฉด ๊ธฐ์กด์ ํต์ ์ ์ทจ์ํ๊ณ  ๋ง์ง๋ง์ผ๋ก ๋ค์ด๋ก๋ ์์ฒญํ๊ฒ๋ง ์ํํ๋๋ก ํ์ฌ ๋ฉ๋ชจ๋ฆฌ ํจ์จ์ฑ์ ๋์ฌ์ค์ ์์๋ค.
