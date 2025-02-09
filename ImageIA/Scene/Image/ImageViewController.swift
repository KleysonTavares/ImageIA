//
//  Image.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

class ImageViewController: UIViewController {
    var receivedImage: UIImage?  // Variável para armazenar a imagem recebida
    var theView: ImageView? {
        view as? ImageView
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
        if let image = receivedImage {
            print("Imagem carregada: \(image)")  // Verifica se a imagem foi recebida
            loadImageImagineArt(from: image)
        } else {
        print("Imagem não foi passada para ImageViewController.")
    }
        
    }
    
    func loadImageImagineArt(from image: UIImage) {
        DispatchQueue.global().async {
                DispatchQueue.main.async {
                    self.theView?.imageView.image = image
            }
        }
    }
    
}

extension ImageViewController: ImageViewDelegate {
    func didButtonPressed() {
    }
    
}
