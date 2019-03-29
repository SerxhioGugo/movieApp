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
    
    var movieGroup = [MovieResults]()
    var nowPlaying = [MovieResults]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavController()
        setupLayout()
        setupCollectionView()
        
        fetchData()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HomeFeedHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(HomeFeedLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        collectionView.backgroundColor = .blueDark1
        collectionView.allowsSelection = true
        collectionView.showsHorizontalScrollIndicator = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "upArrow"), style: .plain, target: self, action: #selector(handleScrollToTop))
    }
    
    @objc func handleScrollToTop() {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredVertically, animated: true)
    }
    
    func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIClient.shared.fetchUpcomingMovies { (movieGroup, error) in
            dispatchGroup.leave()
            guard let result = movieGroup?.results else { return }
            self.movieGroup = result
        }
        
        dispatchGroup.enter()
        APIClient.shared.fetchNowPlayingMovies { (movieGroup, error) in
            dispatchGroup.leave()
            guard let result = movieGroup?.results else { return }
            self.nowPlaying = result
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Tasks are complete")
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func setupNavController() {
        navigationController?.navigationBar.barTintColor = UIColor.blueDark3
        navigationController?.navigationBar.prefersLargeTitles = false
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
        return movieGroup.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        let movie = movieGroup[indexPath.item]
        cell.imageDataSource = movie
        
        if indexPath.item == movieGroup.count - 1 && !isPaginating {
            
            isPaginating = true
            counter += 1
            
            let jsonUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=acb5063b86a8efb1ba814b6ad605f578&page=\(counter)"
            
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
                    self.movieGroup += result
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
}

