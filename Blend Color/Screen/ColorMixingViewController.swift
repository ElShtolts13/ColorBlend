//
//  ColorMixingViewController.swift
//  Blend Color
//
//  Created by Надежда Капацина on 26.01.2025.
//

import UIKit

class ColorMixingViewController: UIViewController, UIColorPickerViewControllerDelegate {

    
    // MARK: - UI elements
    
    private lazy var backgroundView: UIImageView = {
        let element = UIImageView(image: UIImage(named: "background"))
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.text = "Mix Colors 🎨"
        element.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        element.textColor = UIColor.white
        element.textAlignment = .center
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var firsColorButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .red
        element.layer.cornerRadius = 84
        element.setTitle("Red", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.tag = 0 // Set tag for first color button
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var secondColorButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .blue
        element.setTitle("Blue", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.layer.cornerRadius = 84
        element.tag = 1 // Set tag for second color button
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var resultsButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .purple
        element.setTitle("Purple", for: .normal)
        element.setTitleColor(.black, for: .normal)
        element.layer.cornerRadius = 84
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private var selectedButton: UIButton?
    var color1: UIColor? = .red
    var color2: UIColor? = .blue
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundView)
        view.addSubview(firsColorButton)
        view.addSubview(secondColorButton)
        view.addSubview(resultsButton)
        view.addSubview(titleLabel)
       
        setupConstraints()
        updateMixedColor()
    }

    @objc private func colorButtonTapped(sender: UIButton) {
        selectedButton = sender
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }

    func colorDistance(color1: UIColor, color2: UIColor) -> CGFloat {
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0

        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0

        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        let rDiff = r1 - r2
        let gDiff = g1 - g2
        let bDiff = b1 - b2

        return sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
    }

    func nearestColor(to selectedColor: UIColor) -> String {
        var closestColorName: String = "Custom Color"
        var closestDistance: CGFloat = CGFloat.greatestFiniteMagnitude

        for (name, color) in colorNames {
            let distance = colorDistance(color1: selectedColor, color2: color)
            if distance < closestDistance {
                closestDistance = distance
                closestColorName = name
            }
        }

        return closestColorName
    }

    func mixColors(color1: UIColor, color2: UIColor, ratio: CGFloat = 0.5) -> UIColor {
        let clampedRatio = min(max(ratio, 0), 1)

        var red1: CGFloat = 0
        var green1: CGFloat = 0
        var blue1: CGFloat = 0
        var alpha1: CGFloat = 0
        color1.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)

        var red2: CGFloat = 0
        var green2: CGFloat = 0
        var blue2: CGFloat = 0
        var alpha2: CGFloat = 0
        color2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)

        let mixedRed = (red1 * (1 - clampedRatio)) + (red2 * clampedRatio)
        let mixedGreen = (green1 * (1 - clampedRatio)) + (green2 * clampedRatio)
        let mixedBlue = (blue1 * (1 - clampedRatio)) + (blue2 * clampedRatio)
        let mixedAlpha = (alpha1 * (1 - clampedRatio)) + (alpha2 * clampedRatio)

        return UIColor(red: mixedRed, green: mixedGreen, blue: mixedBlue, alpha: mixedAlpha)
    }

    func updateMixedColor() {
        if let c1 = color1 ?? color2 {
            let resultColor: UIColor
            if let c2 = color2 {
                resultColor = mixColors(color1: c1, color2: c2)
            } else {
                resultColor = c1
            }

            let resultclosestColorName = nearestColor(to: resultColor)
            resultsButton.backgroundColor = resultColor
            resultsButton.setTitle(resultclosestColorName, for: .normal)
            updateTextColor(for: resultsButton, basedOn: resultColor)
        }
    }

    func updateTextColor(for button: UIButton, basedOn color: UIColor) {
        let red = color.cgColor.components?[0] ?? 0
        let green = color.cgColor.components?[1] ?? 0
        let blue = color.cgColor.components?[2] ?? 0

        let brightness = (0.299 * red + 0.587 * green + 0.114 * blue)

        if brightness < 0.5 {
            button.setTitleColor(.white, for: .normal)
        } else {
            button.setTitleColor(.black, for: .normal)
        }
    }

    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        guard let selectedButton = selectedButton else { return }

        let selectedColor = viewController.selectedColor
        selectedButton.backgroundColor = selectedColor
        updateTextColor(for: selectedButton, basedOn: selectedColor)

        let closestColorName = nearestColor(to: selectedColor)
        selectedButton.setTitle(closestColorName, for: .normal)

        if selectedButton.tag == 0 {
            color1 = selectedColor
        } else if selectedButton.tag == 1 {
            color2 = selectedColor
        }

        updateMixedColor()
    }
}

// MARK: - Setup Constraints

extension ColorMixingViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate(
            [ backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
              backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
              backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
             titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
             titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             
             firsColorButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
             firsColorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
             firsColorButton.heightAnchor.constraint(equalToConstant: 168),
             firsColorButton.widthAnchor.constraint(equalToConstant: 168),
             
             secondColorButton.topAnchor.constraint(equalTo: firsColorButton.topAnchor),
             secondColorButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
             secondColorButton.heightAnchor.constraint(equalToConstant: 168),
             secondColorButton.widthAnchor.constraint(equalToConstant: 168),

             resultsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             resultsButton.topAnchor.constraint(equalTo: firsColorButton.bottomAnchor, constant: -50),
             resultsButton.heightAnchor.constraint(equalToConstant: 168),
             resultsButton.widthAnchor.constraint(equalToConstant: 168),
            ]
)

        firsColorButton.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
        secondColorButton.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
    }
    
}
