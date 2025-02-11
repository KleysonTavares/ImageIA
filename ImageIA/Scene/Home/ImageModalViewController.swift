//
//  ImageModalViewController.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 11/02/25.
//

import UIKit

class ImageModalViewController: UIViewController {
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Fechar", for: .normal)
        button.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)  // Fundo escuro semitransparente
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            // Centraliza a imagem na tela
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            
            // Botão de fechar no canto superior
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
}

