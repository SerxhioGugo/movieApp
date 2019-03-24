////
////  MovieController.swift
////  movieapp
////
////  Created by Serxhio Gugo on 3/19/19.
////  Copyright © 2019 Serxhio Gugo. All rights reserved.
////
//
//import UIKit
//import SDWebImage
//
//class MovieHorizontalController: BaseListController {
//    
//    fileprivate let cellId = "cellId"
//    var movieGroup: MovieGroup?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        collectionView.backgroundColor = .clear
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
//        
//        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .vertical
//            layout.minimumLineSpacing = 0
//        }
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return movieGroup?.results.count ?? 0
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCell
//        let movie = movieGroup?.results[indexPath.item]
//        cell.posterImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w300\(movie?.posterPath ?? "")"))
//        return cell
//    }
//}
//
//extension MovieHorizontalController: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return .init(width: (view.frame.width / 3), height: view.frame.height / 1.1)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .init(top: 5, left: 5, bottom: 5, right: 5)
//    }
//}