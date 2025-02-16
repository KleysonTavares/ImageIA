//
//  HomeView.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didButtonPressed()
}

class HomeView: UIView {
    var inputPromptTextView = InputPromptTextView()
    var button = UIButton()
    var loading = UIActivityIndicatorView()
    var styleContainerView = UIView()
    weak var delegate: HomeViewDelegate?

       init() {
           super.init(frame: .zero)
           setupView()
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    @objc internal func buttonPressed() {
        delegate?.didButtonPressed()
    }
    
}

extension HomeView: ViewCode {
    func addSubviews() {
        addSubview(styleContainerView)
        addSubview(loading)
        addSubview(inputPromptTextView)
        addSubview(button)
    }

    func configure() {
        styleContainerView.translatesAutoresizingMaskIntoConstraints = false
        styleContainerView.backgroundColor = .clear

        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.style = .large
        loading.color = .purple
        
        inputPromptTextView.translatesAutoresizingMaskIntoConstraints = false
        inputPromptTextView.placeholder = "de asas a sua imaginação..."
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Gerar Imagem", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            styleContainerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            styleContainerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            styleContainerView.heightAnchor.constraint(equalToConstant: 140),
            styleContainerView.bottomAnchor.constraint(equalTo: inputPromptTextView.topAnchor, constant: -20),
            
            inputPromptTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            inputPromptTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            inputPromptTextView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20),
            
            button.heightAnchor.constraint(equalToConstant: 50),
            button.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

    func setupStyle() {
        backgroundColor = .white
    }
}
