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
        element.backgroundColor = .red
        element.layer.cornerRadius = 50
        element.setTitle("Red", for: .normal)
        element.setTitleColor(.black, for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var secondColorButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .blue
        element.setTitle("Blue", for: .normal)
        element.setTitleColor(.black, for: .normal)
        element.layer.cornerRadius = 50
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var resultsButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = .purple
        element.setTitle("Purple", for: .normal)
        element.setTitleColor(.black, for: .normal)
        element.layer.cornerRadius = 50
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private var selectedButton: UIButton?
    var color1: UIColor?
    var color2: UIColor?

    let colorNames: [String: UIColor] = [
        "Red": UIColor.red,
        "Green": UIColor.green,
        "Blue": UIColor.blue,
        "Yellow": UIColor.yellow,
        "Cyan": UIColor.cyan,
        "Magenta": UIColor.magenta,
        "Black": UIColor.black,
        "White": UIColor.white,
        "Gray": UIColor.gray,
        "DarkGray": UIColor.darkGray,
        "LightGray": UIColor.lightGray,
        "Orange": UIColor.orange,
        "Purple": UIColor.purple,
        "Brown": UIColor.brown,
        "Pink": UIColor.systemPink,
        "Teal": UIColor.systemTeal,
        "Indigo": UIColor.systemIndigo,
        "Gold": UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0), // Золотой
        "Violet": UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0), // Фиолетовый
        "Lavender": UIColor(red: 0.9, green: 0.9, blue: 0.98, alpha: 1.0), // Лаванда
        "Coral": UIColor(red: 1.0, green: 0.5, blue: 0.31, alpha: 1.0), // Кораловый
        "Salmon": UIColor(red: 1.0, green: 0.5, blue: 0.5, alpha: 1.0), // Лососевый
        "Mint": UIColor(red: 0.6, green: 1.0, blue: 0.6, alpha: 1.0), // Мятный
        "Peach": UIColor(red: 1.0, green: 0.8, blue: 0.6, alpha: 1.0), // Персиковый
        "Navy": UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1.0), // Темно-синий
        "Olive": UIColor(red: 128/255, green: 128/255, blue: 0/255, alpha: 1.0), // Оливковый
        "Maroon": UIColor(red: 128/255, green: 0/255, blue: 0/255, alpha: 1.0), // Бордовый
        "SlateGray": UIColor(red: 112/255, green: 128/255, blue: 144/255, alpha: 1.0), // Сланцевый серый
        "Turquoise": UIColor(red: 64/255, green: 224/255, blue: 208/255, alpha: 1.0) // Бирюзовый
    ]
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(firsColorButton)
        view.addSubview(secondColorButton)
        view.addSubview(resultsButton)
        setupView()
    }
    
    
    func setupView() {
        
        NSLayoutConstraint.activate(
            [firsColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             firsColorButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             firsColorButton.heightAnchor.constraint(equalToConstant: 100),
             firsColorButton.widthAnchor.constraint(equalToConstant: 100),
             
             resultsButton.leadingAnchor.constraint(equalTo: firsColorButton.leadingAnchor),
             resultsButton.topAnchor.constraint(equalTo: firsColorButton.bottomAnchor, constant: 50),
             resultsButton.heightAnchor.constraint(equalToConstant: 100),
             resultsButton.widthAnchor.constraint(equalToConstant: 100),
             
             secondColorButton.leadingAnchor.constraint(equalTo: firsColorButton.leadingAnchor),
             secondColorButton.topAnchor.constraint(equalTo: resultsButton.bottomAnchor),
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
    
   
    func colorDistance(color1: UIColor, color2: UIColor) -> CGFloat {
        // Получаем компоненты цвета в RGB
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0
        
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        
        // Извлекаем компоненты цвета
        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        // Вычисляем разницу между компонентами
        let rDiff = r1 - r2
        let gDiff = g1 - g2
        let bDiff = b1 - b2
        
        // Возвращаем расстояние между цветами
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
        // Убедимся, что коэффициент находится в пределах от 0 до 1
        let clampedRatio = min(max(ratio, 0), 1)
        
        // Получаем компоненты цветов
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

        // Смешиваем цвета
        let mixedRed = (red1 * (1 - clampedRatio)) + (red2 * clampedRatio)
        let mixedGreen = (green1 * (1 - clampedRatio)) + (green2 * clampedRatio)
        let mixedBlue = (blue1 * (1 - clampedRatio)) + (blue2 * clampedRatio)
        let mixedAlpha = (alpha1 * (1 - clampedRatio)) + (alpha2 * clampedRatio)

        return UIColor(red: mixedRed, green: mixedGreen, blue: mixedBlue, alpha: mixedAlpha)
    }

    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        guard let selectedButton = selectedButton else { return }
        
        let selectedColor = viewController.selectedColor
        selectedButton.backgroundColor = selectedColor

        // Вычисляем яркость цвета
        let red = selectedColor.cgColor.components?[0] ?? 0
        let green = selectedColor.cgColor.components?[1] ?? 0
        let blue = selectedColor.cgColor.components?[2] ?? 0

        // Вычисление яркости
        let brightness = (0.299 * red + 0.587 * green + 0.114 * blue)

        // Устанавливаем цвет текста в зависимости от яркости
        if brightness < 0.5 {
            selectedButton.setTitleColor(.white, for: .normal) // Темный фон - светлый текст
        } else {
            selectedButton.setTitleColor(.black, for: .normal) // Светлый фон - темный текст
        }

        // Находим ближайший цвет и обновляем название кнопки
        let closestColorName = nearestColor(to: selectedColor)
        
        selectedButton.setTitle(closestColorName, for: .normal)
        
        // Сохраняем цвет в соответствующую переменную
        if selectedButton.tag == 0 {
            color1 = selectedColor
        } else if selectedButton.tag == 1 {
            color2 = selectedColor
            
        }
        
        // Обновляем цвет результата, если хотя бы один цвет выбран
        if let c1 = color1 ?? color2 {
            let resultColor: UIColor
            if let c2 = color2 {
                resultColor = mixColors(color1: c1, color2: c2)
            } else {
                // Если выбран только один цвет, используем его как результат
                resultColor = c1
            }
            let resultclosestColorName = nearestColor(to: resultColor)
            resultsButton.backgroundColor = resultColor
            resultsButton.setTitle(resultclosestColorName, for: .normal)
            resultsButton.setTitleColor(.white, for: .normal)
        }
    }
}
