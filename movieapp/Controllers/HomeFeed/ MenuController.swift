//
//   MenuController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/13/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

protocol MenuControllerDelegate {
    func didTapMenuItem(indexPath: IndexPath)
}

class MenuController: BaseListController {

    fileprivate let cellId = "cellId"
    fileprivate let entertainmentType = ["Movies", "TV-Shows"]
    
    var delegate: MenuControllerDelegate?
    
    let menuBar: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
        view.addSubview(menuBar)
        menuBar.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor,trailing: nil, size: .init(width: 0, height: 5))
        menuBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
    }

}

extension MenuController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapMenuItem(indexPath: indexPath)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.label.text = entertainmentType[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        
        return .init(width: width / 2, height: view.frame.height)
    }
}
