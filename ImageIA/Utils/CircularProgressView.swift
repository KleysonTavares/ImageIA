//
//  CircularProgressView.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 09/03/25.
//

import UIKit

class CircularProgressView: UIView {
    private let shapeLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private let percentageLabel = UILabel()
    
    var progress: CGFloat = 1.0 {
        didSet {
            shapeLayer.strokeEnd = progress
            percentageLabel.text = "\(Int(progress * 5))/5"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2),
                                      radius: bounds.width / 2 - 5,
                                      startAngle: -CGFloat.pi / 2,
                                      endAngle: 1.5 * CGFloat.pi,
                                      clockwise: true)
        
        // Camada de fundo (cinza claro)
        backgroundLayer.path = circlePath.cgPath
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = 6
        layer.addSublayer(backgroundLayer)
        
        // Camada de progresso (roxo)
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = UIColor.purple.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 6
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = progress
        layer.addSublayer(shapeLayer)
        
        // Texto no centro
        percentageLabel.textAlignment = .center
        percentageLabel.font = UIFont.boldSystemFont(ofSize: 16)
        percentageLabel.textColor = .black
        addSubview(percentageLabel)
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            percentageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        updateProgressLabel()
    }
    
    private func updateProgressLabel() {
        percentageLabel.text = "\(Int(progress * 5))/5"
    }
}
