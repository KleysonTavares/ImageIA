//
//  ViewController.swift
//  Image IA
//
//  Created by Kleyson Tavares on 07/02/25.
//

import UIKit

class Home: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionImage: InputPromptTextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageButton: UIButton!
    @IBAction func searchImageButton(_ sender: UIButton) {
        searchImagineArt()
    }
    
    let serviceDall_e = ServiceDall_e()
    let serviceImagineArt = ServiceImagineArt()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    func searchImagineArt() {
        if let savedUrl = UserDefaults.standard.string(forKey: "savedImageURL") {
            if savedUrl == descriptionImage.textView.text {
                showErrorAlert(message: "favor, digite uma imagem diferente")
                    self.endLoading()
            }
        } else {
            serviceImagineArt.generateImage(prompt: descriptionImage.textView.text) { data in
                DispatchQueue.main.async {
                    self.startLoading()
                    if let data = data {
                        self.loadImageImagineArt(from: data)
                        UserDefaults.standard.set(self.descriptionImage.textView.text, forKey: "savedImageURL")
                    }
                }
            }
        }
    }
    
    
    func loadImageImagineArt(from data: Data) {
        DispatchQueue.global().async {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.endLoading()
                }
            } else {
                DispatchQueue.main.async {
                    self.endLoading()
                    self.showErrorAlert(message: "Não foi possível gerar a imagem. Tente novamente mais tarde.")
                }
            }
        }
    }
    
    
    func searchImageDall_e() {
        if let savedUrl = UserDefaults.standard.string(forKey: "savedImageURL"), let url = URL(string: savedUrl) {
            loadImage(from: url) // Carrega a imagem do cache
        } else {
            serviceDall_e.generateImage(prompt: descriptionImage.textView.text) { imageUrl in
                DispatchQueue.main.async {
                    if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
                        self.loadImage(from: url)
                        UserDefaults.standard.set(imageUrl, forKey: "savedImageURL")
                    }
                }
            }
        }
    }
    
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.endLoading()
                }
            } else {
                DispatchQueue.main.async {
                    self.endLoading()
                    self.showErrorAlert(message: "Não foi possível gerar a imagem. Tente novamente mais tarde.")
                }
            }
        }
    }
    
    // salvar a imagem no disco
    func saveImageToDisk(image: UIImage, fileName: String = "cachedImage.png") {
        if let data = image.pngData() {
            let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
            try? data.write(to: fileURL)
            print("Imagem salva em: \(fileURL.path)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func loadCachedImage(fileName: String = "cachedImage.png") -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        if let data = try? Data(contentsOf: fileURL) {
            return UIImage(data: data)
        }
        return nil
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func startLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        imageButton.isEnabled = false
    }
    
    func endLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        imageButton.isEnabled = true
    }
}
