//
//  HomeFeedController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/10/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class HomeFeedController: BaseListController {
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    fileprivate let footerId = "footerId"
    fileprivate var isPaginating: Bool = false
    fileprivate var isDonePaginating: Bool = false
    fileprivate var counter: Int = 1
    
    lazy var refresher: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
        refresh.tintColor = .sunnyOrange
        return refresh
    }()
    
    var movieGroup: MovieGroup?
    var nowPlaying: MovieGroup?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavController()
        setupLayout()
        setupCollectionView()
        
        fetchData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIClient.shared.fetchUpcomingMovies { (movieGroup, error) in
            dispatchGroup.leave()
            guard let result = movieGroup else { return }
            self.movieGroup = result
        }
        
        dispatchGroup.enter()
        APIClient.shared.fetchNowPlayingMovies { (movieGroup, error) in
            dispatchGroup.leave()
            guard let result = movieGroup else { return }
            self.nowPlaying = result
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Tasks are complete")
            self.collectionView.reloadData()
        }
    }
    
    @objc func handlePullToRefresh() {
        DispatchQueue.main.async {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.collectionView.reloadData()
                self.refresher.endRefreshing()
            })
        }
    }
    
    fileprivate func setupCollectionView() {
        collectionView.refreshControl = self.refresher
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HomeFeedHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(HomeFeedLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        collectionView.backgroundColor = .myBlack
        collectionView.allowsSelection = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    fileprivate func setupNavController() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor.blueDark3
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = true
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.sunnyOrange]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    fileprivate func setupLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
}

//MARK: Header ~ go through please
extension HomeFeedController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind ==  UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HomeFeedHeader
            header.nowPlayingController.nowPlaying = self.nowPlaying
            header.nowPlayingController.collectionView.reloadData()
            
            header.nowPlayingController.didSelectHandler = { [weak self] movieResults in
                let movieDetailController = MovieDetailController(movieId: movieResults.id)
                movieDetailController.navigationItem.title = movieResults.title
            self!.present(movieDetailController, animated: true)
            }
            
            return header
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
            return footer
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: (view.frame.height / 3.1))
    }
}

//MARK: Footer
extension HomeFeedController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        //If you're at the end of pagination footer size set to 0
        let height: CGFloat = isDonePaginating ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
}

//MARK: CollectionView
extension HomeFeedController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieGroup?.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        let movie = movieGroup?.results[indexPath.item]
        cell.imageDataSource = movie
        
        if indexPath.item == (movieGroup?.results.count ?? 0) - 1 && !isPaginating {
            
            isPaginating = true
            counter += 1
            
            let jsonUrl = "https://api.themoviedb.org/3/movie/popular?api_key=acb5063b86a8efb1ba814b6ad605f578&page=\(counter)"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                APIClient.shared.fetchGenericJSONData(urlString: jsonUrl) { (request: MovieGroup?, error) in
                    if let error = error {
                        print("Error paginating data: ", error)
                        return
                    }
                    
                    if request?.results.count == 0 {
                        self.isDonePaginating = true
                    }
                    
                    guard let result = request?.results else { return }
                    self.movieGroup?.results += result
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                    self.isPaginating = false
                }
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.frame.width / 3) - 8, height: view.frame.height / 4.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = movieGroup?.results[indexPath.item] else { return }
        let movieDetailController = MovieDetailController(movieId: movie.id)
        movieDetailController.modalPresentationStyle = .overFullScreen
        movieDetailController.modalTransitionStyle = .crossDissolve
        movieDetailController.title = movie.title
        self.present(movieDetailController, animated: true)
    }
}
