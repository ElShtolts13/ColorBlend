//
//  ViewController.swift
//  Blend Color
//
//  Created by Надежда Капацина on 20.01.2025.
//

import UIKit

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
    "Turquoise": UIColor(red: 64/255, green: 224/255, blue: 208/255, alpha: 1.0), // Бирюзовый
    "Periwinkle": UIColor(red: 204/255, green: 204/255, blue: 255/255, alpha: 1.0), // Барвинок
    "Sienna": UIColor(red: 160/255, green: 82/255, blue: 45/255, alpha: 1.0), // Сиена
    "Crimson": UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0), // Малиновый
    "Amber": UIColor(red: 255/255, green: 191/255, blue: 0/255, alpha: 1.0), // Янтарный
    "Beige": UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0), // Бежевый
    "Chartreuse": UIColor(red: 127/255, green: 255/255, blue: 0/255, alpha: 1.0), // Шартрез
    "Aqua": UIColor(red: 0/255, green: 255/255, blue: 255/255, alpha: 1.0), // Аквамарин
    "Fuchsia": UIColor(red: 255/255, green: 0/255, blue: 255/255, alpha: 1.0), // Фуксия
    "Khaki": UIColor(red: 240/255, green: 230/255, blue: 140/255, alpha: 1.0), // Хаки
    "Lime": UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0), // Лайм
    "Plum": UIColor(red: 221/255, green: 160/255, blue: 221/255, alpha: 1.0), // Сливовый
    "Orchid": UIColor(red: 218/255, green: 112/255, blue: 214/255, alpha: 1.0), // Орхидея
    "Tomato": UIColor(red: 255/255, green: 99/255, blue: 71/255, alpha: 1.0), // Томато
    "Azure": UIColor(red: 0/255, green: 127/255, blue: 255/255, alpha: 1.0), // Лазурный
    "Mauve": UIColor(red: 224/255, green: 176/255, blue: 255/255, alpha: 1.0), // Розовато-лиловый
    "Peru": UIColor(red: 205/255, green: 133/255, blue: 63/255, alpha: 1.0), // Перуанский
    "Seashell": UIColor(red: 255/255, green: 245/255, blue: 238/255, alpha: 1.0), // Ракушечный
    "Thistle": UIColor(red: 216/255, green: 191/255, blue: 216/255, alpha: 1.0), // Чертополох
    "Wheat": UIColor(red: 245/255, green: 222/255, blue: 179/255, alpha: 1.0) // Пшеничный
]

