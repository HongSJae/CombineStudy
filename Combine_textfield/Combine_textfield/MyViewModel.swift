//
//  MyViewModel.swift
//  Combine_textfield
//
//  Created by 홍승재 on 2022/11/06.
//

import Foundation
import Combine

class MyViewModel {
    @Published var passwordInput: String = ""
    @Published var passwordConfirmInput: String = ""
    lazy var isMatchPasswordInput: AnyPublisher<Bool, Never> = Publishers
        .CombineLatest( $passwordInput,
                        $passwordConfirmInput)
        .map({ (password: String, passwordConfirm: String) in
            if password == "" || passwordConfirm == "" {
                return false
            }
            if password == passwordConfirm {
                return true
            } else {
                return false
            }
        })
        .print()
        .eraseToAnyPublisher()
}
