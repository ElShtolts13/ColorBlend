//
//  ViewController.swift
//  Blend Color
//
//  Created by Надежда Капацина on 20.01.2025.
//

import UIKit

class ColorMixingViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    private lazy var firsColorButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .black
        element.layer.cornerRadius = 50

        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var secondColorButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .black
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    private var selectedButton: UIButton?

    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(firsColorButton)
        view.addSubview(secondColorButton)
        setupView()
    }
    
    
    func setupView() {
        
        NSLayoutConstraint.activate(
            [firsColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             firsColorButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             firsColorButton.heightAnchor.constraint(equalToConstant: 100),
             firsColorButton.widthAnchor.constraint(equalToConstant: 100),
             secondColorButton.leadingAnchor.constraint(equalTo: firsColorButton.leadingAnchor),
             secondColorButton.topAnchor.constraint(equalTo: firsColorButton.bottomAnchor, constant: 50),
             secondColorButton.heightAnchor.constraint(equalToConstant: 100),
             secondColorButton.widthAnchor.constraint(equalToConstant: 100),])
        
        
        firsColorButton.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
        secondColorButton.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
    }
    
    @objc private func colorButtonTapped(sender: UIButton) {
        selectedButton = sender
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)

        
    }
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
           guard let selectedButton = selectedButton else { return }
           
           selectedButton.backgroundColor = viewController.selectedColor
       }
   }
