//
//  ViewController.swift
//  SecondaryPassword
//
//  Created by Chris lee on 4/26/24.
//

import UIKit

final class ViewController: UIViewController{

    // MARK: - ID 입력하는 텍스트 뷰
    private lazy var idTextFieldView : UIView = {
        let view = UIView()
        
        // UI 관련 설정
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
  
        // Subview 추가
        view.addSubview(idInfoLabel)
        view.addSubview(idTextField)
        
        return view
    }()
    
    private let idInfoLabel: UILabel = {
        let label = UILabel()
        
        // UI 관련 설정
        label.text = "아이디"
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        let tf = UITextField()
        
        // UI 관련 설정
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .darkGray
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .default
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return tf
    }()
    
    private lazy var pwTextFieldView : UIView = {
        let view = UIView()
        
        // UI 관련 설정
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        
        // Subview 추가
        view.addSubview(pwInfoLabel)
        view.addSubview(pwTextField)
        
        return view
    }()
    
    private let pwInfoLabel: UILabel = {
        let label = UILabel()
        
        // UI 관련 설정
        label.text = "비밀번호"
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    private lazy var pwTextField: UITextField = {
        let tf = UITextField()
        
        // UI 관련 설정
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .darkGray
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.keyboardType = .default
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return tf
    }()
    
    // MARK: - 로그인 버튼
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        
        // UI 관련 설정
        button.backgroundColor = .systemBlue.withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
//        button.layer.borderWidth = 1
//        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = true
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - 경고 메세지
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        
        // UI 관련 설정
        label.text = "warning message"
        label.isHidden = true
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .red
        return label
    }()
    
    // MARK: - Stack view 정의
    lazy var loginStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [warningLabel, loginButton])
        st.spacing = 10
        st.axis = .vertical
        st.distribution = .fill
        st.alignment = .fill
        return st
    }()
    
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [idTextFieldView, pwTextFieldView, loginStackView])
        st.spacing = 18
        st.axis = .vertical
        st.distribution = .fill
        st.alignment = .fill
        return st
    }()
    
    
    // MARK: - 상수 설정 및 오토레이아웃을 위한 변수 설정
    /* 아이디와 비밀번호 값 */
    private let id = "aaa"
    private let pw = "1234"
    
    /* 3개의 각 텍스트필드 및 로그인 버튼의 높이 설정 */
    private let textViewHeight: CGFloat = 48
    private let buttonHeight: CGFloat = 40
    
    /* 오토레이아웃을 위한 변수 설정 */
    lazy var idInfoLabelCenterYConstraint = idInfoLabel.centerYAnchor.constraint(equalTo: idTextFieldView.centerYAnchor)
    lazy var pwInfoLabelCenterYConstraint = pwInfoLabel.centerYAnchor.constraint(equalTo: pwTextFieldView.centerYAnchor)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAutoLayout()
    }
    

    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        /* 델리게이트 설정 */
        idTextField.delegate = self
        pwTextField.delegate = self
    }
    
    private func setupAutoLayout() {
        /* 아이디 입력 칸 오토레이아웃 설정 */
        idInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        idInfoLabel.leadingAnchor.constraint(equalTo: idTextFieldView.leadingAnchor, constant: 8).isActive = true
        idInfoLabel.trailingAnchor.constraint(equalTo: idTextFieldView.trailingAnchor, constant: -8).isActive = true
        // idInfoLabel.centerYAnchor.constraint(equalTo: idTextFieldView.centerYAnchor).isActive = true
        idInfoLabelCenterYConstraint.isActive = true
        
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        idTextField.topAnchor.constraint(equalTo: idTextFieldView.topAnchor, constant: 15).isActive = true
        idTextField.bottomAnchor.constraint(equalTo: idTextFieldView.bottomAnchor, constant: -2).isActive = true
        idTextField.leadingAnchor.constraint(equalTo: idTextFieldView.leadingAnchor, constant: 8).isActive = true
        idTextField.trailingAnchor.constraint(equalTo: idTextFieldView.trailingAnchor, constant: -8).isActive = true
        
        
        /* 비밀번호 입력 칸 오토레이아웃 설정 */
        pwInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        pwInfoLabel.leadingAnchor.constraint(equalTo: pwTextFieldView.leadingAnchor, constant: 8).isActive = true
        pwInfoLabel.trailingAnchor.constraint(equalTo: pwTextFieldView.trailingAnchor, constant: -8).isActive = true
        // pwInfoLabel.centerYAnchor.constraint(equalTo: pwTextFieldView.centerYAnchor).isActive = true
        pwInfoLabelCenterYConstraint.isActive = true
        
        
        pwTextField.translatesAutoresizingMaskIntoConstraints = false
        pwTextField.topAnchor.constraint(equalTo: pwTextFieldView.topAnchor, constant: 15).isActive = true
        pwTextField.bottomAnchor.constraint(equalTo: pwTextFieldView.bottomAnchor, constant: -2).isActive = true
        pwTextField.leadingAnchor.constraint(equalTo: pwTextFieldView.leadingAnchor, constant: 8).isActive = true
        pwTextField.trailingAnchor.constraint(equalTo: pwTextFieldView.trailingAnchor, constant: -8).isActive = true
        
        /* 텍스트필드 뷰 및 버튼 높이 설정 */
        idTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        idTextFieldView.heightAnchor.constraint(equalToConstant: textViewHeight).isActive = true
        pwTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        pwTextFieldView.heightAnchor.constraint(equalToConstant: textViewHeight).isActive = true
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        
        /* 스택 뷰 오토레이아웃 설정*/
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    }
    
    @objc private func loginButtonTapped() {
        if idTextField.text! != id {
            warningLabel.isHidden = false
            warningLabel.text = "존재하지 않는 아이디 입니다."
            idTextFieldView.layer.borderColor = UIColor.red.cgColor
            pwTextFieldView.layer.borderColor = UIColor.clear.cgColor
            return
        }
        else if pwTextField.text != pw {
            warningLabel.isHidden = false
            warningLabel.text = "일치하지 않는 패스워드 입니다."
            idTextFieldView.layer.borderColor = UIColor.clear.cgColor
            pwTextFieldView.layer.borderColor = UIColor.red.cgColor
            return
        }
        warningLabel.isHidden = true
        idTextFieldView.layer.borderColor = UIColor.systemBlue.cgColor
        pwTextFieldView.layer.borderColor = UIColor.systemBlue.cgColor
        
        /* 다음 화면으로 넘어가는 코드 */
        guard let secondaryVC = storyboard?.instantiateViewController(withIdentifier: "SecondaryVC") 
                as? SecondaryViewController else { return } // 구체적이지 않은 UIVC 타입-> 구체적 타입으로 타입캐스팅
        
        secondaryVC.delegate = self // 대리자 설정
        present(secondaryVC, animated: true)
    }
    
    func presentLastView() {
        /* 다음 화면으로 넘어가는 코드 */
        guard let lastVC = storyboard?.instantiateViewController(withIdentifier: "LastVC")
                as? LastViewController else { return } // 구체적이지 않은 UIVC 타입-> 구체적 타입으로 타입캐스팅
        lastVC.modalPresentationStyle = .fullScreen
        present(lastVC, animated: true)
    }
    
}

extension ViewController: UITextFieldDelegate {
    // MARK: - 텍스트필드 편집 시작할때의 설정 - 문구가 위로올라가면서 크기 작아지고, 오토레이아웃 업데이트
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == idTextField {
            idTextFieldView.backgroundColor = .systemGray5
            idInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            idInfoLabelCenterYConstraint.constant = -13
        }
        
        if textField == pwTextField {
            pwTextFieldView.backgroundColor = .systemGray5
            pwInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            pwInfoLabelCenterYConstraint.constant = -13
        }
        
        // 애니메이션 넣는 코드
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    // MARK: - 텍스트필드 편집 끝날때의 설정 - (적은게 없으면) 문구가 아래로 내려가며 크기 커지고, 오토레이아웃 업데이트
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == idTextField {
            idTextFieldView.backgroundColor = .systemGray6
            // 아무것도 입력된게 있어야 원래 위치로
            if idTextField.text == "" {
                idInfoLabel.font = UIFont.systemFont(ofSize: 18)
                // 오토레이아웃 업데이트
                idInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        if textField == pwTextField {
            pwTextFieldView.backgroundColor = .systemGray6
            if pwTextField.text == "" {
                pwInfoLabel.font = UIFont.systemFont(ofSize: 18)
                // 오토레이아웃 업데이트
                pwInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        // 애니메이션 넣는 코드
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    
    @objc func textFieldEditingChanged() {
        guard
            let id = idTextField.text, !id.isEmpty,
            let pw = pwTextField.text, !pw.isEmpty
        else{
            loginButton.backgroundColor = .systemBlue.withAlphaComponent(0.5)
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = .systemBlue
        loginButton.isEnabled = true
        return
    }
    
}

extension ViewController: SecondViewControllerDelegate {
    func dismissWithKey(toNext: Bool) {
        if toNext == true {
            presentLastView()
        }
    }
}
