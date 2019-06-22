//
//  CreditsController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 4/10/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class CreditsController: BaseListController {
    
    fileprivate let cellId = "cellId"
    var cast = [Cast]()
    
    var movieDetail: MovieDetail? {
        didSet {
            guard
                let cast = movieDetail?.credits?.cast else { return }
            self.cast = cast
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .myBlack
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: cellId)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
}

extension CreditsController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CastCell
        cell.castSource = self.cast[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width / 4, height: view.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yellowVc = UIViewController()
        yellowVc.view.backgroundColor = .yellow
        yellowVc.title = cast[indexPath.item].name!
        self.present(yellowVc, animated: true)
    }
}
