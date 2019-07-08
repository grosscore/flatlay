//
//  MenuView.swift
//  flatlay
//
//  Created by Gross on 26/6/19.
//  Copyright © 2019 Oleksii Gnilov. All rights reserved.
//

import UIKit

class MenuView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    private let categories = ["OBJECTS", "SETTINGS"]
    private let identifiers = ["objectsCollectionCell", "settingsCollectionCell"]
    
    override func awakeFromNib() {
        setupCollectionViews()
        
    }
    
    // MARK: - UICollecitonView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return identifiers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoryCollectionView {
            let categoryCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionCell", for: indexPath) as! CategoryCollectionViewCell
            categoryCell.categoryLabel.text = categories[indexPath.row]
            return categoryCell
        } else {
            let contentCell = contentCollectionView.dequeueReusableCell(withReuseIdentifier: identifiers[indexPath.row], for: indexPath)
            return contentCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.categoryCollectionView {
            return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.categoryCollectionView {
            contentCollectionView.scrollToItem(at: indexPath, at: [], animated: true)
        }
    }
    
    private func setupCollectionViews() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCollectionCell")
        contentCollectionView.register(UINib(nibName: "ObjectsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "objectsCollectionCell")
        contentCollectionView.register(UINib(nibName: "SettingsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "settingsCollectionCell")
        
    }
    
}
