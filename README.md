# SecondaryPassword

## 로그인 화면
1. ID와 PW를 입력할 수 있도록 UILabel, UITextField를 배치합니다.
2. login button을 배치합니다. 입력한 ID가 일치하지 않으면, "존재하지 않는 ID입니다" 라는 워닝메시지를 텍스트 필드와 버튼 사이 공간에 출력합니다. ID는 일치하지만 PW가 일치하지 않는다면 "패스워드가 일치하지 않습니다"라는 메시지를 출력합니다.
3. 입력한 ID와 PW가 모두 일치한다면, 2차 비밀번호 입력 화면을 모달뷰로 띄워줍니다.


## 2차 비밀번호 화면
2차 비밀번호를 입력하는 화면은 토스의 2차 비밀번호 입력화면을 클론합니다.
- 비밀번호는 숫자 네자리와 알파벳 한자리로 이루어져있습니다.
- 하단 비밀번호 입력버튼의 순서는 모달뷰가 띄워질 때 마다 랜덤으로 배치됩니다.
- 비밀번호를 성공적으로 입력하면 모달뷰가 내려가고, 서비스 접속 완료 화면으로 넘어갑니다.
- 비밀번호를 틀리면 햅틱 피드백을 보내고, 다시 입력합니다. 비밀번호 재설정은 구현하지 않습니다.


## 서비스 접속 완료 화면
1. 화면 상단에는 "서비스 접속 성공"이라는 내용의 UILabel을 배치합니다.
2. 화면 중단에는 UIButton을 배치합니다.
3. UIButton을 터치하면 얼럿이 나타납니다. 얼럿의 내용은 다음과 같습니다.
4. 얼럿의 타이틀은 "알림", 메시지는 "알림창입니다. 확인버튼을 눌러보세요."
5. 왼쪽 버튼은 "취소", 오른쪽 버튼은 "확인" 속성은 각각 .cancel, .default
6. 확인버튼을 누르면 "서비스 접속 성공" 라벨의 내용이 "확인 버튼이 눌림"으로 바뀝니다.


## 트러블슈팅
### 자주 사용하는 색을 상수로 설정하기
자주 사용하는 색이 코드를 작성하는 데 있어서 알아보기 불편했기에, UIColor 클래스를 확장하여 이를 타입 속성으로 선언해 주었습니다.
 ```Swift
 extension UIColor {
    static let backgroundColor = UIColor(red: 0.14, green: 0.18, blue: 0.24, alpha: 1.00)
    static let mainColor = UIColor.white
    static let subColor = UIColor(red: 0.62, green: 0.65, blue: 0.73, alpha: 1.00)
    static let shadowColor = UIColor(red: 0.23, green: 0.27, blue: 0.32, alpha: 1.00)
  }
 ```


### 랜덤 커스텀 키보드 만들기
1. .xib 파일 만들어서 커스텀 키보드(숫자 및 영문 키보드)의 레이아웃을 설정했습니다.
2. 이후 UIView를 상속하는 커스텀 키보드 클래스를 생성하고, 델리게이트 패턴을 이용해 키보드 버튼이 눌렸을 때의 행동을 SecondViewController에서 정의하도록 작성했습니다.
3. 키보드가 보여질 때 마다 버튼이 재배열되야 합니다. 따라서 SecondViewController에서 키보드 설정에 대한 함수를 호출할 때, 키보드 클래스에서 랜덤으로 버튼을 배치하는 메서드(.initButtonTitle())을 호출하도록 코드를 작성했습니다.
  ``` Swift
  func setupKeyboard(index: Int) {
      textfield.resignFirstResponder()
      let loadNib = Bundle.main.loadNibNamed("CustomKeyboard", owner: nil, options: nil)   // xib 파일 정보를 불러온 것.
              
      let myKeyboardView = loadNib?.first as! CustomKeyboard
      myKeyboardView.delegate = self  // 이 선언문이 중요함.
      myKeyboardView.initButtonTitle() // 키보드 버튼 랜덤 배치 ---(3)
      myKeyboardView.setIndex(to: index)
      
      textfield.inputView = myKeyboardView
      textfield.becomeFirstResponder()
  }    
  ```

### 2차 비밀번호 일치 시에만 서비스 화면으로 이동
* 2차 비밀번호 화면인 SecondViewController에서 2차 비밀번호의 일치 여부를 확인하는데, 일치할 경우 2차 비밀번호 화면을 dismiss하고, 첫번째 화면에 돌아갔다가 서비스 접속 화면으로 넘어가도록 구현했습니다.
* 따라서, dismiss로 첫 번째 화면으로 돌아갈 때 비밀번호 일치 여부 데이터를 넘겨주어야 하므로 델리게이트 패턴을 사용했습니다.
  1. SecondViewControllerDelegate 프로토콜 생성
     ```Swift
     protocol SecondViewControllerDelegate {
         func dismissWithKey(toNext: Bool)
     }
     ```
  2. ViewController에서 프로토콜의 요구사항 구현: 비밀번호 일치 시에만 서비스 접속 화면으로 넘어가도록
     ```Swift
	 extension ViewController: SecondViewControllerDelegate {
		func dismissWithKey(toNext: Bool) {
			if toNext == true {
				presentLastView()
			}
		}
	 }
     ```
  4. SecondViewController의 View가 없어지는 시점인 viewWillDisappear에서 델리게이트 프로토콜의 함수 호출
     ``` Swift
     override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
     	delegate?.dismissWithKey(toNext: isPassed)
     }
     ```
