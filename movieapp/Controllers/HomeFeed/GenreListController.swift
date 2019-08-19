//
//  GenreListController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 5/2/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class GenreListController: BaseListController {
    
    private let cellId = "cellId"
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchGenres()
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {

        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: cellId)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
}

extension GenreListController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie?.genres.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GenreCell
        let genre = movie?.genres[indexPath.item]
        cell.genreLabel.text = genre?.name
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let genre = movie?.genres[indexPath.item] else { return }
        let genreController = GenreController(genreId: genre.id!)
        genreController.genreLabel.text = "   \(genre.name!)"
        genreController.modalPresentationStyle = .overFullScreen
        genreController.modalTransitionStyle = .crossDissolve
        self.present(genreController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.frame.width / 3) - 8, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 5, bottom: 5, right: 5)
    }
}
