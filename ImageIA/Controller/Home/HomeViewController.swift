//
//  ViewController.swift
//  Image IA
//
//  Created by Kleyson Tavares on 07/02/25.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapSearchButton(image: UIImage?)
    func didTapAspecRatioButton()
}

final class HomeViewController: UIViewController {
    weak var delegate: HomeViewControllerDelegate?
    var inputPrompt: String?
    var selectedStyle: String = "realistic"
    var selectedAspectRatio: String = "1:1"

    private let homeView = HomeView()
    private let styleViewController = StyleViewController()
    private let serviceDall_e = ServiceDall_e()
    private let serviceImagineArt = ServiceImagineArt()

    override func loadView() {
        super.loadView()
        view = homeView
        homeView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardObservers()
        setupTapGesture()
        addStyleViewController()
        homeView.aspectRatioButton.addTarget(self, action: #selector(showAspectRatioModal), for: .touchUpInside)
        updateAspectRatioButtonIcon() // Atualiza o ícone inicial
        configLayoutStyle()
        configAdManager()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func searchImagineArt(input: String, style: String, aspectRatio: String) {
        startLoading()
        if promptDuplicate(prompt: input) == false {
            serviceImagineArt.generateImage(prompt: input, style: style, aspectRatio: aspectRatio) { data in
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
            if savedUrl == prompt || prompt.isEmpty {
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
            self?.homeView.loading.startAnimating()
            self?.homeView.seachButton.isEnabled = false
        }
    }

    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.homeView.loading.stopAnimating()
            self?.homeView.seachButton.isEnabled = true
        }
    }
    
    func configLayoutStyle() {
        styleViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            styleViewController.view.topAnchor.constraint(equalTo: homeView.styleContainerView.topAnchor),
            styleViewController.view.leadingAnchor.constraint(equalTo: homeView.styleContainerView.leadingAnchor),
            styleViewController.view.trailingAnchor.constraint(equalTo: homeView.styleContainerView.trailingAnchor),
            styleViewController.view.bottomAnchor.constraint(equalTo: homeView.styleContainerView.bottomAnchor)
        ])
    }
    
    func configAdManager() {
        AdManager.shared.onAdDidDismiss = { [weak self] in
            guard let self = self else { return }
            if let input = self.inputPrompt {
                self.searchImagineArt(input: input, style: selectedStyle, aspectRatio: selectedAspectRatio)
            }
        }
        AdManager.shared.loadInterstitialAd()
    }
    
    func addStyleViewController() {
        addChild(styleViewController)
        homeView.styleContainerView.addSubview(styleViewController.view)
        styleViewController.didMove(toParent: self)
        styleViewController.delegate = self
    }
    
    private func updateAspectRatioButtonIcon() {
           let options = AspectRatioViewController().aspectRatios
           if let selectedAspectRatio = options.first(where: { $0.aspectRatio == self.selectedAspectRatio }) {
               homeView.aspectRatioButton.setImage(UIImage(named: selectedAspectRatio.image), for: .normal)
           }
       }

       @objc private func showAspectRatioModal() {
           delegate?.didTapAspecRatioButton()
       }
}

extension HomeViewController: HomeViewDelegate {
    func didSeachButtonPressed() {
        AdManager.shared.showInterstitialAd(from: self) // Exibe o anúncio
        dismissKeyboard()
        if let input = homeView.inputPromptTextView.textView.text {
            inputPrompt = input
        }
    }
}

extension HomeViewController: StyleViewControllerDelegate {
    func didSelectStyle(_ style: String) {
        selectedStyle = style
    }
}

extension HomeViewController: AspectRatioViewControllerDelegate {
    func didSelectAspectRatio(_ aspectRatio: String) {
        selectedAspectRatio = aspectRatio
        updateAspectRatioButtonIcon()
    }
}
