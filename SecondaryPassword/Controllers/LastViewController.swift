//
//  LastViewController.swift
//  SecondaryPassword
//
//  Created by Chris lee on 4/30/24.
//

import UIKit

final class LastViewController: UIViewController {

    private let mainLabel: UILabel = {
        let label = UILabel()
        
        // UI 관련 설정
        label.text = "서비스 접속 성공"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = .clear
        label.textColor = .black
        return label
    }()
    
    private lazy var mainButton: UIButton = {
        let button = UIButton()
        
        // UI 관련 설정
        button.setTitle("알림 버튼", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.isEnabled = true
        button.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [mainLabel, mainButton])
        
        st.axis = .vertical
        st.spacing = 15
        st.alignment = .center
        st.distribution = .fill
        return st
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAutoLayout()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        view.addSubview(stackView)
    }
    
    func setupAutoLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        mainButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    
    @objc private func mainButtonTapped() {
        let alert = UIAlertController(title: "알림", message: "알림창입니다. 확인버튼을 눌러보세요.", preferredStyle: .alert)

        // 확인 버튼을 누르면 실행할 내용
        let success = UIAlertAction(title: "확인", style: .default) { action in
            self.mainLabel.text = "확인 버튼이 눌림"
        }
        // 취소 버튼을 누르면 실행할 내용
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소버튼이 눌렸습니다.")
        }

        alert.addAction(success)
        alert.addAction(cancel)

        // 실제 띄우기
        self.present(alert, animated: true, completion: nil)
    }
}
