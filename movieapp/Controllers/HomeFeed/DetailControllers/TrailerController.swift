//
//  TrailerController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 4/12/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class TrailerController: BaseListController {
    
    fileprivate let cellId = "cellId"
    var videos = [VideoResult]()
    
    
    var movieDetail: MovieDetail? {
        didSet {
            guard
                let videos = movieDetail?.videos?.results else { return }
            self.videos = videos
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(TrailerCell.self, forCellWithReuseIdentifier: cellId)
        
        //FIXME: fix layout
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
}

extension TrailerController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TrailerCell
            cell.videoSource = self.videos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width / 1.5, height: view.frame.height - 20)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .init(top: 0, left: 20, bottom: 0, right: 20)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
