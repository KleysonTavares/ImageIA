//
//  Watermark.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 04/03/25.
//

import UIKit

final class Watermark {

    func addWatermark(to image: UIImage, watermark: UIImage) -> UIImage {
        let imageSize = image.size
        let watermarkSize = CGSize(width: imageSize.width * 0.4, height: imageSize.height * 0.3)

        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: imageSize))

        let watermarkOrigin = CGPoint(
            x: imageSize.width - watermarkSize.width - 10,
            y: imageSize.height - watermarkSize.height - 10
        )

        watermark.draw(in: CGRect(origin: watermarkOrigin, size: watermarkSize), blendMode: .normal, alpha: 0.6)

        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return finalImage ?? image
    }
    
}
