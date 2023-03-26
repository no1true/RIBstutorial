//
//  LoggedOutViewController.swift
//  TicTacToe
//
//  Created by no1true on 2023/03/25.
//  Copyright © 2023 Uber. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol LoggedOutPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func login(withPlayer1Name player1Name: String?, player2Name: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
    
    weak var listener: LoggedOutPresentableListener?
    
    let vStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        return stackView
    }()
    
    let firstNameTextField : UITextField = {
        let textField = makeTextField()
        textField.placeholder = "Player1 Name"
        return textField
    }()
    
    let secondNameTextField : UITextField = {
        let textField = makeTextField()
        textField.placeholder = "Player2 Name"
        return textField
    }()
    
    static func makeTextField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.keyboardType = .asciiCapable
        return textField
    }
    
    lazy var loginBtn : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(vStackView)
        
        vStackView.addArrangedSubview(firstNameTextField)
        vStackView.addArrangedSubview(secondNameTextField)
        vStackView.addArrangedSubview(loginBtn)
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: view.topAnchor ,constant: 40),
            vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
        
    }
    
    @objc
    private func didTapLogin() {
        if let player1Name = firstNameTextField.text,
           let player2Name = secondNameTextField.text {
            listener?.login(withPlayer1Name: player1Name, player2Name: player2Name)
        }
    }
}
