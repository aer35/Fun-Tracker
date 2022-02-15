//
//  CircleButton.swift
//  Fun Tracker
//
//  Created by Aaron on 2/15/22.
//

import UIKit

class CircleButton : UIButton {
	
	
	init(){
		super.init(frame: .zero)
		self.clipsToBounds = true
		

		NSLayoutConstraint.activate([
			
			self.heightAnchor.constraint(equalTo: self.widthAnchor)
		])
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.layer.cornerRadius = 0.5 * self.frame.size.width

		
	}
	
	
}
