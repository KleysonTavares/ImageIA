//
//  ViewCode.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

protocol ViewCode {
    func configure()
    func addSubviews()
    func setupConstraints()
    func setupStyle()
}

extension ViewCode {
    func setupView() {
        configure()
        addSubviews()
        setupConstraints()
        setupStyle()
    }
}
