//
//  UIImageGen.swift
//  Fun Tracker
//
//  Created by Aaron on 2/16/22.
//

import UIKit

extension UIImage {
	static func generateImage(from color: UIColor) -> UIImage{
		
		let size = CGSize(width: 16, height: 16)
		
		let renderer = UIGraphicsImageRenderer(size: size)
		
		let image = renderer.image { ctx in
			ctx.cgContext.setFillColor(color.cgColor)
			ctx.fill(CGRect(origin: .zero, size: size))
			
		}
		
		return image
		
	}
}
