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
    var inputPrompt: String?
    var selectedStyle: String = "realistic"
    var selectedAspectRatio: String = "1:1"

    private let homeView = HomeView()
    private let styleViewController = StyleViewController()
    private let aspectRatioViewController = AspectRatioViewController()
    private let serviceDall_e = ServiceDall_e()
    private let serviceImagineArt = ServiceImagineArt()
    private let counter = ImageGenerationCounter()

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
        addAspectRatioViewController()
        configLayoutAspectRatio()
        configLayoutStyle()
        configAdManager()
        updateProgressView()
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
        guard let watermarkImage = UIImage(named: "watermark") else { return }
        let finalImage = Watermark().addWatermark(to: image, watermark: watermarkImage)
        delegate?.didTapSearchButton(image: finalImage)
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
    
    func configLayoutAspectRatio() {
        aspectRatioViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aspectRatioViewController.view.topAnchor.constraint(equalTo: homeView.aspectRatioContainerView.topAnchor),
            aspectRatioViewController.view.leadingAnchor.constraint(equalTo: homeView.aspectRatioContainerView.leadingAnchor),
            aspectRatioViewController.view.trailingAnchor.constraint(equalTo: homeView.aspectRatioContainerView.trailingAnchor),
            aspectRatioViewController.view.bottomAnchor.constraint(equalTo: homeView.aspectRatioContainerView.bottomAnchor)
        ])
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

    func validCount() {
         if counter.count > 0 {
             counter.decrement()
             updateProgressView()
             generateImage()
         } else {
             showErrorAlert(message: "Você atingiu o limite de tentativas!")
         }
     }

    func generateImage() {
        AdManager.shared.showInterstitialAd(from: self) // Exibe o anúncio
        dismissKeyboard()
        if let input = homeView.inputPromptTextView.textView.text {
            inputPrompt = input
        }
    }

    func updateProgressView() {
           let progress = CGFloat(counter.count) / 5.0
           homeView.updateCounterView(progress: progress)
    }

    func addStyleViewController() {
        addChild(styleViewController)
        homeView.styleContainerView.addSubview(styleViewController.view)
        styleViewController.didMove(toParent: self)
        styleViewController.delegate = self
    }
    
    func addAspectRatioViewController() {
        addChild(aspectRatioViewController)
        homeView.aspectRatioContainerView.addSubview(aspectRatioViewController.view)
        aspectRatioViewController.didMove(toParent: self)
        aspectRatioViewController.delegate = self
    }

}

extension HomeViewController: HomeViewDelegate {
    func didSeachButtonPressed() {
        validCount()
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
    }
}
