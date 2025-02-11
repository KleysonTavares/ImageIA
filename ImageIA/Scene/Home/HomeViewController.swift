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
        super.loadView()
        let newView = HomeView()
        newView.delegate = self
        view = newView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardObservers()
        setupTapGesture()
    }
    
    deinit {
            NotificationCenter.default.removeObserver(self)
        }

    func searchImagineArt(input: String) {
        startLoading()
        if promptDuplicate(prompt: input) == false {
            serviceImagineArt.generateImage(prompt: input) { data in
                if let data = data, let image = UIImage(data: data) {
                    self.goToImage(image: image)
                    UserDefaults.standard.set(input, forKey: "savedImageURL")
                } else {
                    self.showErrorAlert(message: "Não foi possível gerar a imagem. Tente novamente mais tarde.")
                }
            }
        }
    }
    
    func promptDuplicate(prompt: String) -> Bool {
        if let savedUrl = UserDefaults.standard.string(forKey: "savedImageURL") {
            if savedUrl == prompt {
                showErrorAlert(message: "favor, digite uma imagem diferente")
                stopLoading()
            } else {
                return false
            }
        }
        return true
    }

    private func setupKeyboardObservers() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }

        @objc private func keyboardWillShow(_ notification: Notification) {
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                let keyboardHeight = keyboardFrame.height
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin.y = -keyboardHeight
                }
            }
        }

        @objc private func keyboardWillHide(_ notification: Notification) {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = 0
            }
        }

       private func setupTapGesture() {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
           view.addGestureRecognizer(tapGesture)
       }

       @objc private func dismissKeyboard() {
           view.endEditing(true)
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
                    self.stopLoading()
                }
            } else {
                DispatchQueue.main.async {
                    self.stopLoading()
                    self.showErrorAlert(message: "Não foi possível gerar a imagem. Tente novamente mais tarde.")
                }
            }
        }
    }

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    @objc private func goToImage(image: UIImage) {
        delegate?.didTapSearchButton(image: image)
        stopLoading()
    }

    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.theView?.loading.startAnimating()
            self?.theView?.button.isEnabled = false
        }
    }

    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.theView?.loading.stopAnimating()
            self?.theView?.button.isEnabled = true
        }
    }

}

extension HomeViewController: HomeViewDelegate {
    func didButtonPressed() {
        dismissKeyboard()
        if let inputPrompt = theView?.inputPromptTextView.textView.text {
            searchImagineArt(input: inputPrompt)
        }
    }

}
