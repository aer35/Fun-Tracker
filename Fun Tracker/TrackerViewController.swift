//
//  TrackerViewController.swift
//  Fun Tracker
//
//  Created by Aaron on 12/3/21.
//

import UIKit

extension UIView {
	func addSubviewWithConstraints(_ subview: UIView){
		subview.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(subview)
	}
}

class TrackerViewController: UIViewController {
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {.portrait}
	
	static let countKey = "count"
	static let funWords = ["Wow", "Are you ashamed?", "Looks like you did a good job", "Hooray!", "💦💦💦", "Hello World", "Send help I've been trapper here writing these for 2 weeks. Oh lord HES COMING", "Haha funny man did the thing"]

	
	
	
	lazy var countAddButton: UIButton = {
		let addButton = CircleButton()

		addButton.setTitle("Have Fun", for: .normal)
		
		// Can use this line to modify the label color inside the button. ".label" will set the system color based on the system theme.
//		addButton.setTitleColor(.label, for: .normal)
		
//		addButton.layer.backgroundColor = UIColor.systemCyan.cgColor
		addButton.setBackgroundImage(.generateImage(from: .systemCyan), for: .normal)
		
		
		return addButton
	}()
	
	lazy var countResetButton: UIButton = {
		let button = UIButton(type: .system)

		button.setTitle("Mom knows my password", for: .normal)
		button.configuration = .filled()
		button.configuration?.baseBackgroundColor = .secondarySystemBackground
		button.configuration?.baseForegroundColor = .systemRed
		button.configuration?.buttonSize = .small
		
		return button
		
	}()
	
	lazy var label = UILabel()
	var count = UserDefaults.standard.integer(forKey: countKey) {
		didSet {
			UserDefaults.standard.set(self.count, forKey: Self.countKey)
			updateCount()
		}
	}
	
	
	lazy var funText: UILabel = {
		let label = UILabel()
		
		label.numberOfLines = 0
		label.textAlignment = .center
		
		return label
	}()
	

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		self.view.backgroundColor = .systemBackground
		
		self.updateCount()
		
		funText.text = " "
		
		let stackView = UIStackView(arrangedSubviews: [countAddButton, label, funText])
		stackView.axis = .vertical
		stackView.spacing = 10
		stackView.alignment = .center
		
//		self.view.addSubviewWithContraints(self.countAddButton)
//		self.view.addSubviewWithContraints(self.label)
//		self.view.addSubviewWithContraints(self.funText)
		
		self.view.addSubviewWithConstraints(self.countResetButton)
		self.view.addSubviewWithConstraints(stackView)
		
		self.countAddButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
		self.countResetButton.addTarget(self, action: #selector(resetCount), for: .touchUpInside)
		
		
		NSLayoutConstraint.activate([
			countAddButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
			stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
			
			countAddButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.6),
			countResetButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
			countResetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
			
//			self.countAddButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//			self.countAddButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 40),
//
//			self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//			self.label.bottomAnchor.constraint(equalTo: self.countAddButton.topAnchor, constant: -10),
//
//			self.countResetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//			self.countResetButton.topAnchor.constraint(equalTo: self.countAddButton.bottomAnchor, constant: 10),
//
//			self.funText.centerXAnchor.constraint(equalTo: self.label.centerXAnchor),
//			self.funText.bottomAnchor.constraint(equalTo: self.label.topAnchor, constant: -10)
		])
		
		
		
	}
	
	@objc func buttonTapped() {
		self.count += 1
		self.funText.text = Self.funWords.randomElement()
		self.funText.layer.opacity = 1
		UIView.animate(withDuration: 1, delay: 0.5, options: [.curveEaseIn, .curveEaseOut, .transitionCurlUp]) {
			self.funText.layer.opacity = 0
			
		}
	}
	
	func updateCount() {
		self.label.text = "# of Funs: \(self.count)"
	}
	
	@objc func resetCount() {
		
		let alertController = UIAlertController(title: "Are you sure you want to reset the count?", message: "This action cannot be undone.", preferredStyle: .alert)
		alertController.addAction(.init(title: "Delete", style: .destructive, handler: { _ in
			self.count = 0
			self.funText.text = " "
			alertController.dismiss(animated: true, completion: nil)
		}))
		
		alertController.addAction(.init(title: "Cancel", style: .cancel, handler: { _ in
			alertController.dismiss(animated: true, completion: nil)
		}))
		
		self.present(alertController, animated: true, completion: nil)
		
	}

}

