//
//  ViewController.swift
//  Combine_textfield
//
//  Created by 홍승재 on 2022/11/06.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var passwordConfirmTextfield: UITextField!
    @IBOutlet var myButton: UIButton!
    
    var viewModel: MyViewModel!
    
    private var mySubscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MyViewModel()
        passwordTextfield
            .myTextPublisher
            .receive(on: DispatchQueue.main)
//            .print()
            .assign(to: \.passwordInput, on: viewModel)
            .store(in: &mySubscriptions)
        passwordConfirmTextfield
            .myTextPublisher
            .receive(on: DispatchQueue.main)
//            .print()
            .assign(to: \.passwordConfirmInput, on: viewModel)
            .store(in: &mySubscriptions)
        viewModel.isMatchPasswordInput
//            .print()
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: myButton)
            .store(in: &mySubscriptions)
    }
}

extension UITextField {
    var myTextPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
//            .print()
            // UITextField 가져옴
            .compactMap{ $0.object as? UITextField }
            // String 가져옴
            .map{ $0.text ?? ""}
            .print()
            .eraseToAnyPublisher()
    }
}

extension UIButton {
    var isValid: Bool {
        get {
            backgroundColor == .lightGray
        }
        set {
            backgroundColor = newValue ? .yellow : .lightGray
            isEnabled = newValue
            setTitleColor(newValue ? .red : .green, for: .normal)
        }
    }
}
