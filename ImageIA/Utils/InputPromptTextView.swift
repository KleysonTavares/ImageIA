//
//  InputPromptTextView.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

class InputPromptTextView: UIView, UITextViewDelegate {
    
    var textView = UITextView()
    var placeholderLabel = UILabel()
    let characterCountLabel = UILabel()
    let maxCharacters = 500
    let fixedHeight: CGFloat = 150  // Altura fixa para o campo de texto
    
    var placeholder: String = "Digite algo..." {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Configuração da TextView
        textView.delegate = self
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 10
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = true  // Mantém o scroll ativado caso ultrapasse o tamanho
        textView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textView)
        
        // Configuração do Placeholder
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = .lightGray
        placeholderLabel.font = UIFont.systemFont(ofSize: 16)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        
        // Configuração do contador de caracteres
        characterCountLabel.text = "0/\(maxCharacters)"
        characterCountLabel.textColor = .gray
        characterCountLabel.textAlignment = .right
        characterCountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(characterCountLabel)
        
        // Constraints para fixar o tamanho do TextView
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: fixedHeight), // 🔥 Altura fixa
            
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5),
            
            characterCountLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
            characterCountLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            characterCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor) // Mantém o contador sempre visível
        ])
    }
    
    // Quando começa a digitar, a borda fica roxa e esconde o placeholder
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.purple.cgColor
    }
    
    // Quando termina de editar, a borda volta ao normal e mostra o placeholder se o campo estiver vazio
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderColor = UIColor.lightGray.cgColor
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    // Atualiza contador, limita caracteres e esconde o placeholder quando há texto
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > maxCharacters {
            textView.text = String(textView.text.prefix(maxCharacters))
        }
        characterCountLabel.text = "\(textView.text.count)/\(maxCharacters)"
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
