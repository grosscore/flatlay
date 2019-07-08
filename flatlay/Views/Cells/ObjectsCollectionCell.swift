//
//  ObjectsCollectionCell.swift
//  flatlay
//
//  Created by Gross on 8/7/19.
//  Copyright © 2019 Oleksii Gnilov. All rights reserved.
//

import UIKit
import SceneKit

class ObjectsCollectionCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var objectsCollectionView: UICollectionView!
    var objects = [Preview]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        self.objects = SCNReferenceNode.availableObjects
        objectsCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = objectsCollectionView.dequeueReusableCell(withReuseIdentifier: "objectCell", for: indexPath) as! ObjectCell
        cell.preview.image = objects[indexPath.row].image
        cell.nameLabel.text = objects[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    private func setupCollectionView() {
        objectsCollectionView.delegate = self
        objectsCollectionView.dataSource = self
        objectsCollectionView.register(UINib(nibName: "ObjectCell", bundle: nil), forCellWithReuseIdentifier: "objectCell")
    }
}
