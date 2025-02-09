//
//  ViewController.swift
//  Image IA
//
//  Created by Kleyson Tavares on 07/02/25.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapSearchButton(image: UIImage?)
}

final class HomeViewController: UIViewController {
    weak var delegate: HomeViewControllerDelegate?
    var theView: HomeView? {
        view as? HomeView
    }
    
    let serviceDall_e = ServiceDall_e()
    let serviceImagineArt = ServiceImagineArt()

    override func loadView() {
        let newView = HomeView()
        newView.delegate = self
        view = newView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("🟢 HomeViewController carregada - Delegate é nil? \(delegate == nil)")

    }
    
    func searchImagineArt(input: String) {
//        if let savedUrl = UserDefaults.standard.string(forKey: "savedImageURL") {
//            if savedUrl == input {
//                showErrorAlert(message: "favor, digite uma imagem diferente")
//                    self.endLoading()
//            }
//        } else {
            serviceImagineArt.generateImage(prompt: input) { data in
                DispatchQueue.main.async {
                    self.theView?.startLoading()
                    if let data = data {
                        self.loadImageImagineArt(from: data)
                        if let image = UIImage(data: data) {
                            self.goToImage(image: image)
                        }
                        UserDefaults.standard.set(input, forKey: "savedImageURL")
                    }
                }
            }
//        }
    }
    
    
    func loadImageImagineArt(from data: Data) {
        DispatchQueue.global().async {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.theView?.imageView.image = image
                    self.theView?.endLoading()
                }
            } else {
                DispatchQueue.main.async {
                    self.theView?.endLoading()
                    self.showErrorAlert(message: "Não foi possível gerar a imagem. Tente novamente mais tarde.")
                }
            }
        }
    }
    
    
    func searchImageDall_e() {
        if let savedUrl = UserDefaults.standard.string(forKey: "savedImageURL"), let url = URL(string: savedUrl) {
            loadImageDall_e(from: url) // Carrega a imagem do cache
        } else {
            serviceDall_e.generateImage(prompt: theView?.inputPromptTextView.textView.text ?? String()) { imageUrl in
                DispatchQueue.main.async {
                    if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
                        self.loadImageDall_e(from: url)
                        UserDefaults.standard.set(imageUrl, forKey: "savedImageURL")
                    }
                }
            }
        }
    }
    
    func loadImageDall_e(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.theView?.imageView.image = image
                    self.theView?.endLoading()
                }
            } else {
                DispatchQueue.main.async {
                    self.theView?.endLoading()
                    self.showErrorAlert(message: "Não foi possível gerar a imagem. Tente novamente mais tarde.")
                }
            }
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func goToImage(image: UIImage) {
        delegate?.didTapSearchButton(image: image)        
      }
    
}


extension HomeViewController: HomeViewDelegate {
    func didButtonPressed() {
        if let inputPrompt = theView?.inputPromptTextView.textView.text {
            searchImagineArt(input: inputPrompt)
        }
    }

}
