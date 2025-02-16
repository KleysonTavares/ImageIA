//
//  StyleCustomCell.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 16/02/25.
//

import UIKit

class StyleCustomCell: UICollectionViewCell {

    static let identifier = "StyleCustomCell"

    let imageView = UIImageView()
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with option: Option) {
        imageView.image = UIImage(named: option.image)
        label.text = option.label
    }

    func setSelected(_ selected: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.layer.borderColor = selected ? UIColor.purple.cgColor : UIColor.clear.cgColor
        }
    }
}

extension StyleCustomCell: ViewCode {
    func addSubviews() {
        addSubview(imageView)
        addSubview(label)
    }

    func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black

        layer.borderWidth = 2
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius = 8
    }

    func setupStyle() {
        backgroundColor = .white
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

}
