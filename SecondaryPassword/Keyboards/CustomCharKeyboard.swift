//
//  CustomCharKeyboard.swift
//  SecondaryPassword
//
//  Created by Chris lee on 4/29/24.
//

import UIKit

protocol CustomCharKeyBoardDelegate {
    func keyboardTapped(str: String)
    func backToCustomKeyboard()
}

class CustomCharKeyboard: UIView {
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
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button16: UIButton!
    @IBOutlet weak var button17: UIButton!
    @IBOutlet weak var button18: UIButton!
    @IBOutlet weak var button19: UIButton!
    @IBOutlet weak var button20: UIButton!
    @IBOutlet weak var button21: UIButton!
    @IBOutlet weak var button22: UIButton!
    @IBOutlet weak var button23: UIButton!
    @IBOutlet weak var button24: UIButton!
    @IBOutlet weak var button25: UIButton!
    @IBOutlet weak var backSpace: UIButton!
    
   
    lazy var buttons: [UIButton] = [
        button0, button1, button2, button3, button4, button5, button6,
        button7, button8, button9, button10, button11, button12, button13,
        button14, button15, button16, button17, button18, button19, button20,
        button21, button22, button23, button24, button25
    ]
    
    let buttonSize: CGFloat = 25
    var delegate: CustomCharKeyBoardDelegate?
    
    // ⭐️ 랜덤 키보드 로직
    func initButtonTitle() {
        let chars = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").shuffled()
        
        for i in 0...25 {
            buttons[i].setTitle(String(chars[i]), for: .normal)
            buttons[i].titleLabel?.font = UIFont.boldSystemFont(ofSize: buttonSize)
        }
        backSpace.titleLabel?.font = UIFont.boldSystemFont(ofSize: buttonSize)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.keyboardTapped(str: sender.titleLabel!.text!)
    }
    
    @IBAction func backSpaceTapped(_ sender: UIButton) {
        delegate?.backToCustomKeyboard()
    }
    
}
