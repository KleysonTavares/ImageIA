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
    let counterLabel = UILabel()
    let inputPromptTextView = InputPromptTextView()
    let seachButton = UIButton()
    let loading = UIActivityIndicatorView()
    let aspectLabel = UILabel()
    let aspectRatioContainerView = UIView()
    let styleLabel = UILabel()
    let styleContainerView = UIView()
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
    
    func updateCounterLabel(count: Int) {
            counterLabel.text = "Tentativas restantes: \(count)"
        }
}

extension HomeView: ViewCode {
    func addSubviews() {
        addSubview(counterLabel)
        addSubview(aspectLabel)
        addSubview(aspectRatioContainerView)
        addSubview(styleLabel)
        addSubview(styleContainerView)
        addSubview(loading)
        addSubview(inputPromptTextView)
        addSubview(seachButton)
    }

    func configure() {
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.text = "Imagens restantes: 5"
        counterLabel.font = .boldSystemFont(ofSize: 22)
        counterLabel.textAlignment = .center
        counterLabel.textColor = .red

        aspectLabel.translatesAutoresizingMaskIntoConstraints = false
        aspectLabel.text = "Proporção da imagem"
        aspectLabel.font = .systemFont(ofSize: 20)

        aspectRatioContainerView.translatesAutoresizingMaskIntoConstraints = false
        aspectRatioContainerView.backgroundColor = .clear

        styleLabel.translatesAutoresizingMaskIntoConstraints = false
        styleLabel.text = "Estilo"
        styleLabel.font = .systemFont(ofSize: 20)
        
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
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            counterLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            counterLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            aspectLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aspectLabel.bottomAnchor.constraint(equalTo: aspectRatioContainerView.topAnchor, constant: -5),

            aspectRatioContainerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aspectRatioContainerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            aspectRatioContainerView.heightAnchor.constraint(equalToConstant: 140),
            aspectRatioContainerView.bottomAnchor.constraint(equalTo: styleLabel.topAnchor, constant: -20),

            styleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            styleLabel.bottomAnchor.constraint(equalTo: styleContainerView.topAnchor, constant: -5),

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
