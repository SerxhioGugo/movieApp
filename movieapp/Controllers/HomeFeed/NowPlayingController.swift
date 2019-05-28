//
//  NowPlayingController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/25/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit
import CHIPageControl

class NowPlayingController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UPCarouselFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sideItemScale = 0.9
        layout.sideItemAlpha = 2
        layout.spacingMode = .fixed(spacing: 0.5)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = true
        return cv
    }()
    
    fileprivate let cellId = "cellId"
    var nowPlaying: MovieGroup?

    lazy var pageControl: CHIBasePageControl = {
       let pc = CHIPageControlJalapeno()
        pc.numberOfPages = 20
        pc.progress = 0
        pc.radius = 4
        pc.tintColor = .sunnyOrange
        return pc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.backgroundColor = .myBlack
        collectionView.register(NowPlayingCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        

        
//        view.addSubview(pageControl)
//        pageControl.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 55, right: 0))
    }
    
//     func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let x = targetContentOffset.pointee.x
//        pageControl.set(progress: Int(x / view.frame.width), animated: true)
//    }
    
}

extension NowPlayingController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlaying?.results.count ?? 0
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NowPlayingCell
        let nowPlayingMovies = nowPlaying?.results[indexPath.item]
        cell.dataSource = nowPlayingMovies
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 100 , height: view.frame.height - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 0, bottom: 10, right: 0)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}

//CollectionView Delegate
extension NowPlayingController: UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movie = nowPlaying?.results[indexPath.item] else { return }
        print(indexPath.item)
        let movieDetailController = MovieDetailController(movieId: movie.id)
        movieDetailController.modalPresentationStyle = .overFullScreen
        movieDetailController.modalTransitionStyle = .crossDissolve
        movieDetailController.title = movie.title
        self.present(movieDetailController, animated: true)
    }
}
