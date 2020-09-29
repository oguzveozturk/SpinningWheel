//
//  ViewController.swift
//  SpinningWheel
//
//  Created by Oguz on 26.06.2020.
//  Copyright © 2020 Oguz. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var numbers = [Int]()
    
    private lazy var collection: UICollectionView = {
        let layout = WheelLayout()
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .systemTeal
        c.showsVerticalScrollIndicator = false
        c.register(Cell.self, forCellWithReuseIdentifier: "cell")
        c.dataSource = self
        c.delegate = self
        c.layer.borderColor = UIColor.systemTeal.cgColor
        c.layer.borderWidth = 8
        c.alwaysBounceVertical = true
        c.layer.cornerRadius = view.frame.width*0.48
        c.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
        return c
    }()
    
    private lazy var addButton: UIButton = {
        let v = UIButton(type: .system)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemGreen
        v.setTitle("+", for: .normal)
        v.titleLabel?.font = .systemFont(ofSize: 45)
        v.tintColor = .white
        v.contentVerticalAlignment = .bottom
        v.layer.cornerRadius = view.frame.width*0.08
        v.addTarget(self, action: #selector(add), for: .touchUpInside)
        return v
    }()
    
    private lazy var removeButton: UIButton = {
        let v = UIButton(type: .system)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemRed
        v.setTitle("-", for: .normal)
        v.titleLabel?.font = .systemFont(ofSize: 45)
        v.tintColor = .white
        v.contentVerticalAlignment = .bottom
        v.layer.cornerRadius = view.frame.width*0.08
        v.addTarget(self, action: #selector(remove), for: .touchUpInside)
        return v
    }()
    
    private lazy var restartButton: UIButton = {
        let v = UIButton(type: .system)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemPink
        v.setTitle("Restart", for: .normal)
        v.tintColor = .white
        v.layer.cornerRadius = view.frame.width*0.04
        v.addTarget(self, action: #selector(restartData), for: .touchUpInside)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    @objc func add() {
        if let last = numbers.last {
            numbers.append(last+1)
        } else {
            numbers.append(0)
        }
        let indexPath = IndexPath(item: max(0,numbers.count-1), section: 0)
        collection.insertItems(at: [indexPath])
    }
    
    @objc func remove() {
        if numbers.count > 0 {
            let randomNumber = Int.random(in: 0..<(max(1,numbers.count-1)))
            numbers.remove(at: randomNumber)
            UIView.performWithoutAnimation {
                collection.deleteItems(at: [IndexPath(item: randomNumber, section: 0)])
            }
        }
    }
    
    @objc func restartData() {
        numbers.removeAll()
        collection.reloadData()
    }
}
//MARK: - UICollectionView Methods
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell else {  return UICollectionViewCell() }
        cell.label.text = "\(numbers[indexPath.item])"
        return cell
    }
}
//MARK: - Setup Layouts
extension MainViewController {
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.96),
            collection.heightAnchor.constraint(equalTo: collection.widthAnchor),
            collection.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collection.centerXAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant:  -10),
            addButton.widthAnchor.constraint(equalTo: collection.widthAnchor, multiplier: 0.16),
            addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor)
        ])
        
        view.addSubview(removeButton)
        NSLayoutConstraint.activate([
            removeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            removeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant:  -10),
            removeButton.widthAnchor.constraint(equalTo: collection.widthAnchor, multiplier: 0.16),
            removeButton.heightAnchor.constraint(equalTo: removeButton.widthAnchor)
        ])
        
        view.addSubview(restartButton)
        NSLayoutConstraint.activate([
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            restartButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            restartButton.heightAnchor.constraint(equalTo: restartButton.widthAnchor, multiplier: 0.4)
        ])
    }
}

