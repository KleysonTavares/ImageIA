//
//  ImageModalView.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 17/03/25.
//

import UIKit

final class ImageModalView: UIView {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "square.and.arrow.down")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
        button.setImage(image, for: .normal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "square.and.arrow.up")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
        button.setImage(image, for: .normal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "xmark.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
        button.setImage(image, for: .normal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let saveLabel: UILabel = {
        let label = UILabel()
        label.text = "Salvar"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let shareLabel: UILabel = {
        let label = UILabel()
        label.text = "Compartilhar"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let closeLabel: UILabel = {
        let label = UILabel()
        label.text = "Fechar"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let savedImageLabel: UILabel = {
        let label = UILabel()
        label.text = "Imagem salva na galeria"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        loadingIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showButtons() {
        saveButton.isHidden = false
        shareButton.isHidden = false
        closeButton.isHidden = false
        saveLabel.isHidden = false
        shareLabel.isHidden = false
        closeLabel.isHidden = false
    }
}

extension ImageModalView: ViewCode {
    func setupStyle() {
    }
    
    func addSubviews() {
        addSubview(imageView)
        addSubview(loadingIndicator)
        addSubview(saveButton)
        addSubview(shareButton)
        addSubview(closeButton)
        addSubview(saveLabel)
        addSubview(shareLabel)
        addSubview(closeLabel)
        addSubview(savedImageLabel)
    }
    
    func configure() {
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
 
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),

            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            saveButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            saveButton.heightAnchor.constraint(equalToConstant: 50),

            saveLabel.centerXAnchor.constraint(equalTo: saveButton.centerXAnchor),
            saveLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 5),

            shareButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            shareButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            
            shareLabel.centerXAnchor.constraint(equalTo: shareButton.centerXAnchor),
            shareLabel.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 5),
            
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            closeButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 50),

            closeLabel.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor),
            closeLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 5),
            
            savedImageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            savedImageLabel.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -20)
        ])
    }
}
