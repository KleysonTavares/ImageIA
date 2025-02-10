//
//  HomeView.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

protocol ImageViewDelegate: AnyObject {
    func didButtonPressed()
}

class ImageView: UIView {
    var imageView = UIImageView()
    weak var delegate: ImageViewDelegate?

       init() {
           super.init(frame: .zero)
           setupView()
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

}

extension ImageView: ViewCode {
    func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFit
    }
    
    func addSubviews() {
        addSubview(imageView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

    func setupStyle() {
        backgroundColor = .white
    }
}
