//
//  Image.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

class ImageViewController: UIViewController {
    var theView: ImageView? {
        view as? ImageView
    }

    var image: UIImage? {
        didSet {
            updateImage()
        }
    }

    override func loadView() {
        let newView = ImageView()
        newView.delegate = self
        view = newView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Imagem gerada"
        updateImage()
    }

    func loadImageImagineArt(from image: UIImage) {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                self.theView?.imageView.image = image
            }
        }
    }

    func updateImage() {
        if let image = image {
            loadImageImagineArt(from: image)
        } else {
            showErrorAlert(message: "Não foi possível gerar a imagem. Tente novamente mais tarde.")
        }
    }

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}

extension ImageViewController: ImageViewDelegate {
    func didButtonPressed() {
    }

}
