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
    private let colors = [UIColor.blue, UIColor.yellow]
    
    override func awakeFromNib() {
        setupCollectionViews()
    }
    
    // MARK: - UICollecitonView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.categoryCollectionView {
            let categoryCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath)
            categoryCell.backgroundColor = colors[indexPath.row]
            return categoryCell
        } else {
            let contentCell = contentCollectionView.dequeueReusableCell(withReuseIdentifier: "contentCell", for: indexPath)
            contentCell.backgroundColor = colors[indexPath.row].withAlphaComponent(0.5)
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
    
    func setupCollectionViews() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        
        categoryCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        contentCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "contentCell")
        
    }
}
