//
//  AspectRatioView.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 04/03/25.
//

import UIKit

final class AspectRatioView: UIView {
    
    let titleLabel = UILabel()
    let closeButton = UIButton()
    let collectionView: UICollectionView
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension AspectRatioView: ViewCode {
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(closeButton)
        addSubview(collectionView)
    }

    func configure() {
        titleLabel.text = "Proporção da Imagem"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        closeButton.setTitle("Fechar", for: .normal)
        closeButton.setTitleColor(.red, for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AspectRatioCustomCell.self, forCellWithReuseIdentifier: AspectRatioCustomCell.identifier)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }

    func setupStyle() {
        backgroundColor = .white
    }

}
