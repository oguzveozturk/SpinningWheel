//
//  ViewController.swift
//  SpinningWheel
//
//  Created by Oguz on 26.06.2020.
//  Copyright © 2020 Oguz. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let imageList = ["facebook","twitter","instagram","youtube"]
    
    private lazy var collection: UICollectionView = {
        let layout = WheelLayout()
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .yellow
        c.showsVerticalScrollIndicator = false
        c.register(Cell.self, forCellWithReuseIdentifier: "cell")
        c.dataSource = self
        c.delegate = self
        c.clipsToBounds = true
        c.layer.borderWidth = 10
        c.layer.borderColor = UIColor.yellow.cgColor
        return c
    }()
    
    private lazy var centerCircle: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .yellow
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        collection.layer.cornerRadius = collection.frame.width/2
        centerCircle.layer.cornerRadius = centerCircle.frame.width/2
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count*2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell else {  return UICollectionViewCell() }
        cell.data = imageList[indexPath.item % imageList.count]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 170)
    }
}

extension MainViewController {
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            collection.heightAnchor.constraint(equalTo: collection.widthAnchor),
            collection.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collection.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/2)
        ])
        
        view.addSubview(centerCircle)
        NSLayoutConstraint.activate([
            centerCircle.centerXAnchor.constraint(equalTo: collection.centerXAnchor),
            centerCircle.centerYAnchor.constraint(equalTo: collection.centerYAnchor),
            centerCircle.widthAnchor.constraint(equalTo: collection.widthAnchor, multiplier: 0.15),
            centerCircle.heightAnchor.constraint(equalTo: centerCircle.widthAnchor)
        ])
    }
}

