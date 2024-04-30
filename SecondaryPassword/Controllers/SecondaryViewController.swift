//
//  SecondaryViewController.swift
//  SecondaryPassword
//
//  Created by Chris lee on 4/29/24.
//

import UIKit

final class SecondaryViewController: UIViewController {
    // MARK: - 메인 레이블
    private var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호를 눌러주세요"
        label.backgroundColor = .clear
        label.textColor = UIColor.mainColor
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    // MARK: - 서브 레이블
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "숫자 4자리 + 영문자 1자리"
        label.backgroundColor = .clear
        label.textColor = UIColor.subColor
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    // MARK: - 비밀번호 뷰 배열 선언
    var pwdImages: [UIImageView] = {
        var container: [UIImageView] = []
        
        for i in 0...5 {
            let view = UIImageView()
            // ⭐️ 이미지 크기 키우는 로직 - configuration 이용(정리하기)
            // 이미지 관련 변수
            let configuration = UIImage.SymbolConfiguration(scale: .large)
            
            switch i {
            case 4:
                view.image = UIImage(systemName: "plus", withConfiguration: configuration)?
                    .withTintColor(.shadowColor, renderingMode: .alwaysOriginal)
            default:
                view.image = UIImage(systemName: "circle.fill", withConfiguration: configuration)?
                    .withTintColor(.shadowColor, renderingMode: .alwaysOriginal)
            }
            container.append(view)
        }
        return container
    }()
    
    // MARK: - 비밀번호 찾기 버튼 선언
    private lazy var findPwButton : UIButton = {
        let button = UIButton()
        // UI 관련 설정
        button.backgroundColor = .shadowColor
        button.layer.cornerRadius = 8
        button.setTitle("비밀번호를 몰라요", for: .normal)
        button.titleLabel?.textColor = .subColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.isEnabled = true
        return button
    }()
    
    // MARK: - 스택 뷰 선언
    lazy var pwStackView: UIStackView = {
        let st = UIStackView()
        pwdImages.forEach { st.addArrangedSubview($0) }
        // UI 관련 설정
        st.spacing = 17
        st.axis = .horizontal
        st.distribution = .fillEqually
        st.alignment = .center
        return st
    }()
    
    lazy var labelStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [mainLabel, subLabel])
        // UI 관련 설정
        st.spacing = 10
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .center
        return st
    }()
    
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [labelStackView, pwStackView, findPwButton])
        // UI 관련 설정
        st.spacing = 24
        st.axis = .vertical
        st.distribution = .fill
        st.alignment = .center
        return st
    }()
    
    private lazy var textfield: UITextField = {
        let tf = UITextField()
        tf.text = ""
        tf.backgroundColor = .clear
        tf.textColor = .clear
        tf.tintColor = .clear
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        return tf
    }()
    
    /* 비밀번호 설정 */
    private let secondPw = "1234A"
    var isPassed = false
    var delegate: SecondViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard(index: 0)
        setupUI()
        setupAutoLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.dismissWithKey(toNext: isPassed)
    }
    
    func setupKeyboard(index: Int) {
        textfield.resignFirstResponder()
        let loadNib = Bundle.main.loadNibNamed("CustomKeyboard", owner: nil, options: nil)   // xib 파일 정보를 불러온 것.
                
        let myKeyboardView = loadNib?.first as! CustomKeyboard
        myKeyboardView.delegate = self  // 이 선언문이 중요함.
        myKeyboardView.initButtonTitle()
        myKeyboardView.setIndex(to: index)
        
        textfield.inputView = myKeyboardView
        textfield.becomeFirstResponder()
    }    
    
    func changeKeyboardSetup() {
        textfield.resignFirstResponder()
        let loadNib = Bundle.main.loadNibNamed("CustomCharKeyboard", owner: nil, options: nil)   // xib 파일 정보를 불러온 것.
                
        let myKeyboardView = loadNib?.first as! CustomCharKeyboard
        myKeyboardView.delegate = self  // 이 선언문이 중요함.
        myKeyboardView.initButtonTitle()
        
        textfield.inputView = myKeyboardView
        textfield.becomeFirstResponder()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(stackView)
        view.addSubview(textfield)
    }

    func setupAutoLayout() {
        /* 비밀번호 찾기 버튼 오토레이아웃 */
        findPwButton.translatesAutoresizingMaskIntoConstraints = false
        findPwButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        findPwButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        /* 스택 뷰 오토레이아웃*/
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    }
    
    // 📌 여기부터 코드 작성
    func checkPassword() {
        if textfield.text == secondPw {
            /* 현재 모달 뷰 내리기 */
            isPassed = true
            dismiss(animated: true)
        } else {
            /* 비밀번호 재입력 코드 */
            reset()
        }
    }
    
    func reset() {
        // 비밀번호 리셋, 인덱스 처음으로, 키보드 숫자 키보드로 바꾸기
        // 1. 비밀번호 리셋
        for i in [0, 1, 2, 3, 5]{
            erase(idx: i)
        }
        
        // 2. 인덱스 초기화 & 숫자 키보드로
        setupKeyboard(index: 0)
        
        // 3. 레이블 텍스트 변경
        mainLabel.text = "비밀번호가 맞지 않아요"
    }

}

extension SecondaryViewController: CustomKeyBoardDelegate {
    func keyboardTapped(str: String, idx: Int){
        // 패스워드 뷰(동그라미) 색 바뀌고 크기 커지게 + 애니메이션
        if idx <= 3 {
            let configuration = UIImage.SymbolConfiguration(scale: .large)
            let newImage = UIImage(systemName: "circle.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
            pwdImages[idx].image = newImage
            textfield.text! += str
        }
        // 마지막 글자 입력되면 알파벳 키보드로 바꾸기
        if idx == 3 {
            changeKeyboardSetup()
        }
    }
    
    func erase(idx: Int) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let newImage = UIImage(systemName: "circle.fill", withConfiguration: configuration)?.withTintColor(.shadowColor, renderingMode: .alwaysOriginal)
        pwdImages[idx].image = newImage
        textfield.text?.removeLast()
    }
}

extension SecondaryViewController: CustomCharKeyBoardDelegate {
    func keyboardTapped(str: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let newImage = UIImage(systemName: "circle.fill", withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        self.pwdImages[5].image = newImage
        self.textfield.text! += str
        
        // ⭐️ 마지막 뷰까지 흰색으로 채워진 다음에 체크하는 코드 실행
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.checkPassword()
        }
    }
    
    func backToCustomKeyboard() {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let newImage = UIImage(systemName: "circle.fill", withConfiguration: configuration)?.withTintColor(.shadowColor, renderingMode: .alwaysOriginal)
        pwdImages[3].image = newImage
        textfield.text?.removeLast()
        setupKeyboard(index: 3)
    }
}

protocol SecondViewControllerDelegate {
    func dismissWithKey(toNext: Bool)
}
