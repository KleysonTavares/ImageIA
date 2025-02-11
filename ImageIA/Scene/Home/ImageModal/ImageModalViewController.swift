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

    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "square.and.arrow.up")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(shareImage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "xmark.circle.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let shareLabel: UILabel = {
        let label = UILabel()
        label.text = "Compartilhar"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let closeLabel: UILabel = {
        let label = UILabel()
        label.text = "Fechar"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(shareButton)
        view.addSubview(closeButton)
        view.addSubview(shareLabel)
        view.addSubview(closeLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            shareButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            
            shareLabel.centerXAnchor.constraint(equalTo: shareButton.centerXAnchor),
            shareLabel.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 5),
            
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            closeButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            
            closeLabel.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor),
            closeLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 5)
        ])
    }
    
    @objc private func shareImage() {
        guard let image = image else { return }
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    @objc private func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
}
