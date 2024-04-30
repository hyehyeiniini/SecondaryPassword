//
//  CustomKeyboard.swift
//  SecondaryPassword
//
//  Created by Chris lee on 4/29/24.
//

import UIKit

protocol CustomKeyBoardDelegate {
    func keyboardTapped(str: String, idx: Int)
    func erase(idx: Int)
}

class CustomKeyboard: UIView {
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var buttonNotUse: UIButton!
    @IBOutlet weak var backSpace: UIButton!
    
    lazy var buttons: [UIButton] = [
        button0, button1, button2,
        button3, button4, button5,
        button6, button7, button8,
        button9
    ]
    
    private let buttonSize: CGFloat = 30
    private var index = 0
    var delegate: CustomKeyBoardDelegate?   // 계속 남아있어 메모리 누수가 일어날 수 있으므로 optional로 선언.
    
    // ⭐️ 랜덤 키보드 로직
    func initButtonTitle() {
        let nums = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].shuffled()
        
        for i in 0...9 {
            buttons[i].setTitle(String(nums[i]), for: .normal)
            buttons[i].titleLabel?.font = UIFont.boldSystemFont(ofSize: buttonSize)
        }
        backSpace.titleLabel?.font = UIFont.boldSystemFont(ofSize: buttonSize)
        buttonNotUse.isEnabled = false
    }
    
    func setIndex(to index: Int){
        self.index = index
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if index < 4 {
            delegate?.keyboardTapped(str: sender.titleLabel!.text!, idx: index)
            self.index += 1
        }
    }

    
    @IBAction func backSpaceTapped(_ sender: UIButton) {
        if index == 0 { return }
        index -= 1
        delegate?.erase(idx: index)
    }
}
