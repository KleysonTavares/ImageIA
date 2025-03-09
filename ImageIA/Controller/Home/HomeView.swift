//
//  HomeView.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didSeachButtonPressed()
}

final class HomeView: UIView {
    let inputPromptTextView = InputPromptTextView()
    let seachButton = UIButton()
    let loading = UIActivityIndicatorView()
    let styleLabel = UILabel()
    let styleContainerView = UIView()
    let aspectRatioButton = UIButton()
    weak var delegate: HomeViewDelegate?

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc internal func buttonPressed() {
        delegate?.didSeachButtonPressed()
    }
}

extension HomeView: ViewCode {
    func addSubviews() {
        addSubview(aspectRatioButton)
        addSubview(styleLabel)
        addSubview(styleContainerView)
        addSubview(loading)
        addSubview(inputPromptTextView)
        addSubview(seachButton)
    }

    func configure() {
        styleLabel.translatesAutoresizingMaskIntoConstraints = false
        styleLabel.text = "Estilo"
        styleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        styleContainerView.translatesAutoresizingMaskIntoConstraints = false
        styleContainerView.backgroundColor = .clear

        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.style = .large
        loading.color = .purple
        
        inputPromptTextView.translatesAutoresizingMaskIntoConstraints = false
        inputPromptTextView.placeholder = "de asas a sua imaginação..."
        
        seachButton.translatesAutoresizingMaskIntoConstraints = false
        seachButton.setTitle("Gerar Imagem", for: .normal)
        seachButton.setTitleColor(.white, for: .normal)
        seachButton.backgroundColor = .purple
        seachButton.layer.borderColor = UIColor.lightGray.cgColor
        seachButton.layer.borderWidth = 2
        seachButton.layer.cornerRadius = 10
        seachButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        seachButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        aspectRatioButton.translatesAutoresizingMaskIntoConstraints = false
        aspectRatioButton.setImage(UIImage(named: "aspect_1_1"), for: .normal)
        aspectRatioButton.tintColor = .black
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            aspectRatioButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aspectRatioButton.widthAnchor.constraint(equalToConstant: 100),
            aspectRatioButton.heightAnchor.constraint(equalToConstant: 100),
            aspectRatioButton.bottomAnchor.constraint(equalTo: styleLabel.topAnchor, constant: -20),

            styleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            styleLabel.bottomAnchor.constraint(equalTo: styleContainerView.topAnchor, constant: -10),

            styleContainerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            styleContainerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            styleContainerView.heightAnchor.constraint(equalToConstant: 140),
            styleContainerView.bottomAnchor.constraint(equalTo: inputPromptTextView.topAnchor, constant: -20),
            
            inputPromptTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            inputPromptTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            inputPromptTextView.bottomAnchor.constraint(equalTo: seachButton.topAnchor, constant: -20),
            
            seachButton.heightAnchor.constraint(equalToConstant: 50),
            seachButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            seachButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            seachButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            seachButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }

    func setupStyle() {
        backgroundColor = .white
    }
}
