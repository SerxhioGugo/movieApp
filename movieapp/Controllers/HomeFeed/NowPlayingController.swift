//
//  NowPlayingController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/25/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class NowPlayingController: BaseListController {
    
    fileprivate let cellId = "cellId"
    var nowPlaying = [MovieResults]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .blueDark1
        collectionView.isPagingEnabled = true
        collectionView.register(NowPlayingCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsHorizontalScrollIndicator = false
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
}

extension NowPlayingController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlaying.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NowPlayingCell
        let nowPlayingMovies = nowPlaying[indexPath.item]
        cell.dataSource = nowPlayingMovies
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
