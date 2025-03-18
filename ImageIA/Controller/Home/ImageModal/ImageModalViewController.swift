//
//  ImageModalViewController.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 11/02/25.
//

import UIKit

final class ImageModalViewController: UIViewController {
    
    var image: UIImage? {
        didSet {
            modalView.imageView.image = image
            modalView.loadingIndicator.stopAnimating() // Parar a animação quando a imagem é carregada
            modalView.showButtons() // Exibir os botões e labels após o carregamento
        }
    }
    
    private let modalView = ImageModalView()
    
    override func loadView() {
        view = modalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    private func setupActions() {
        modalView.saveButton.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        modalView.shareButton.addTarget(self, action: #selector(shareImage), for: .touchUpInside)
        modalView.closeButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
    }
    
    @objc private func saveImage() {
        guard let imageTemp = image else { return }
        ImageSaveManager.saveImageToAppAlbum(imageTemp) { [weak self] success in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if success {
                    self.modalView.savedImageLabel.isHidden = false
                    self.modalView.saveButton.isEnabled = false
                }
            }
        }
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
