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
    fileprivate let genreCellId = "genreCellId"
    fileprivate let nowPlayingCellId = "nowPlayingCellId"
    fileprivate var isPaginating: Bool = false
    fileprivate var isDonePaginating: Bool = false
    fileprivate var counter: Int = 1
    fileprivate var didComeFromAnotherViewController = false
    
    lazy var refresher: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
        refresh.tintColor = .sunnyOrange
        return refresh
    }()
    
    
    var movieGroup: MovieGroup?
    var nowPlaying: MovieGroup?
    var movie: Movie?

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
//        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
        self.tabBarController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        didComeFromAnotherViewController = true
    }
    
    //FIXME: Move Genres Networking , Here!
    func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIClient.shared.fetchGenres { (movieGenre, error) in
            dispatchGroup.leave()
            guard let result = movieGenre else { return }
            self.movie = result
        }
        
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
        collectionView.register(GenreContainerCell.self, forCellWithReuseIdentifier: genreCellId)
        collectionView.register(NowPlayingCellContainer.self, forCellWithReuseIdentifier: nowPlayingCellId)
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
        navigationItem.title = "Genres"
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = #imageLiteral(resourceName: "movieIcon")
        imageView.image = image
        navigationItem.titleView = imageView
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
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
            return footer
        }
        return UICollectionReusableView()
    }

}

//MARK: Footer
extension HomeFeedController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        //If you're at the end of pagination footer size set to 0
        if section == 0 || section == 1{
            return CGSize.zero
        }
        let height: CGFloat = isDonePaginating ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
}

//MARK: CollectionView
extension HomeFeedController: UICollectionViewDelegateFlowLayout {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
        return movieGroup?.results.count ?? 0
        } else if section == 1 {
            return 1
        }
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: genreCellId, for: indexPath) as! GenreContainerCell
            cell.genreController.movie = movie
            cell.genreController.collectionView.reloadData()
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nowPlayingCellId, for: indexPath) as! NowPlayingCellContainer
            cell.nowPlayingController.nowPlaying = nowPlaying
            cell.nowPlayingController.collectionView.reloadData()
            return cell
        } else if indexPath.section == 2 {
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
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return .init(width: view.frame.width - 10, height: 120)
        } else if indexPath.section == 1 {
            
            return .init(width: view.frame.width - 10, height: 450)
            
        }
        
        return .init(width: (view.frame.width / 3) - 8, height: view.frame.height / 4.5)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 || section == 1 {
            return .init(top: 3, left: 0, bottom: 3, right: 0)
        }
        return .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieGroup = movieGroup?.results[indexPath.item] else { return }
        
        switch indexPath.section {
            
        case 2:
            let movieDetailController = MovieDetailController(movieId: movieGroup.id)
            movieDetailController.modalPresentationStyle = .overFullScreen
            movieDetailController.modalTransitionStyle = .crossDissolve
            movieDetailController.title = movieGroup.title
            self.present(movieDetailController, animated: true)
        default:
            print("none")
        }
    }
}

extension HomeFeedController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if !didComeFromAnotherViewController {
            self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            
        } else {
            didComeFromAnotherViewController = false
        }
        
    }
}
