//
//  InputPromptTextView.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

class InputPromptTextView: UIViewController, UITextViewDelegate {
    
    let textView = UITextView()
    let characterCountLabel = UILabel()
    let maxCharacters = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        setupCharacterCountLabel()
    }
    
    func setupTextView() {
        textView.delegate = self
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 10
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setupCharacterCountLabel() {
        characterCountLabel.text = "0/\(maxCharacters)"
        characterCountLabel.textColor = .gray
        characterCountLabel.textAlignment = .right
        characterCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(characterCountLabel)
        
        NSLayoutConstraint.activate([
            characterCountLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
            characterCountLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor)
        ])
    }
    
    // Delegate para mudar a borda ao começar a digitar
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.purple.cgColor
    }
    
    // Delegate para restaurar a borda ao sair do campo
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // Delegate para limitar os caracteres e atualizar o contador
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > maxCharacters {
            textView.text = String(textView.text.prefix(maxCharacters))
        }
        characterCountLabel.text = "\(textView.text.count)/\(maxCharacters)"
    }
}

