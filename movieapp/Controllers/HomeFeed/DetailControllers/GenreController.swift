//
//  GenreController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 6/13/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class GenreController: BaseListController {
    
    fileprivate let cellId = "cellId"
    fileprivate let footerId = "footerId"
    fileprivate var isPaginating: Bool = false
    fileprivate var isDonePaginating: Bool = false
    fileprivate var counter: Int = 1
    
    var genre : MovieGroup?
    
    fileprivate let genreId: Int
    
    //DI
    init(genreId: Int) {
        self.genreId = genreId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let genreLabel: UILabel = {
       let label = UILabel()
        label.text = "  Comedy"
        label.font = UIFont(name: Fonts.latoBold, size: 24)
        label.textColor = .sunnyOrange
        label.textAlignment = .center
        return label
    }()
    
    let dismissButton: UIButton = {
       let button = UIButton()
        button.setTitle("X", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 40/2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleDissmiss), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDissmiss() {
        print("dismiss tapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .myBlack
        collectionView.backgroundColor = .myBlack
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 5), size: .init(width: 40, height: 40))
        
        view.addSubview(genreLabel)
        genreLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: dismissButton.leadingAnchor, size: .init(width: 0, height: 60))
        
        collectionView.anchor(top: genreLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        collectionView.register(MovieGenreCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HomeFeedLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        
        fetchMoviesPerGenre()
    }
    
    func fetchMoviesPerGenre() {
        let urlString = "https://api.themoviedb.org/3/genre/\(genreId)/movies?api_key=acb5063b86a8efb1ba814b6ad605f578"
        
        APIClient.shared.fetchGenericJSONData(urlString: urlString) { (result: MovieGroup?, error) in
            
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.genre = result
                self.collectionView.reloadData()
            }
        }
    }


}

extension GenreController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        //If you're at the end of pagination footer size set to 0

        let height: CGFloat = isDonePaginating ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
}

extension GenreController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genre?.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieGenreCell
        cell.dataSource = genre?.results[indexPath.item]
        //MARK: Pagination
        if indexPath.item == (genre?.results.count ?? 0) - 1 && !isPaginating {
            
            isPaginating = true
            counter += 1
            
            let jsonUrl = "https://api.themoviedb.org/3/genre/\(genreId)/movies?api_key=acb5063b86a8efb1ba814b6ad605f578&page=\(counter)"
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
            APIClient.shared.fetchGenericJSONData(urlString: jsonUrl) { (request: MovieGroup?, error) in
                if let error = error {
                    print("Error paginating data: ", error)
                    return
                }
                
                if request?.results.count == 0 {
                    self.isDonePaginating = true
                }
                
                guard let result = request?.results else { return }
                self.genre?.results += result
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
                self.isPaginating = false
                }
            }
        }
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        guard let movieId = genre?.results[indexPath.item] else { return }
        
        let movieDetailController = MovieDetailController(movieId: movieId.id)
        movieDetailController.modalPresentationStyle = .overFullScreen
        movieDetailController.modalTransitionStyle = .crossDissolve
        movieDetailController.title = movieId.title
        self.present(movieDetailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.frame.width / 3) - 8, height: view.frame.height / 4.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
