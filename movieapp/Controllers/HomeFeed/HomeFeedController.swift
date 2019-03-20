//
//  HomeFeedController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/10/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class HomeFeedController: BaseListController {

    fileprivate let menuController = MenuController()
    fileprivate let cellId = "cellId"
    fileprivate let testId = "testId"
    fileprivate let entertainment = ["Upcoming Movies", "Upcoming Tv-Shows"]
    var movieGroup = [MovieGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavController()
        setupLayout()
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: testId)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .blueDark1
        collectionView.allowsSelection = true
        collectionView.showsHorizontalScrollIndicator = false
        
        menuController.delegate = self
        menuController.collectionView.selectItem(at: [0,0], animated: true, scrollPosition: .centeredHorizontally)
        
        fetchData()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        collectionView.frame = view.safeAreaLayoutGuide.layoutFrame
//    }
    
    func fetchData() {
        var group1: MovieGroup?
        var group2: MovieGroup?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIClient.shared.fetchUpcomingMovies { (movieGroup, error) in
            dispatchGroup.leave()
            group1 = movieGroup
        }
        dispatchGroup.enter()
        APIClient.shared.fetchUpcomingTvShows { (movieGroup, error) in
            dispatchGroup.leave()
            group2 = movieGroup
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Tasks are completed")
            
            if let group = group1 {
                self.movieGroup.append(group)
            }
            
            if let group = group2 {
                self.movieGroup.append(group)
            }
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
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        let menuView = menuController.view!
        
        view.addSubview(menuView)
        menuView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        leading: view.leadingAnchor,
                        bottom: nil,
                        trailing: view.trailingAnchor,
                        size: .init(width: 0, height: 40))
        
        collectionView.anchor(top: menuView.safeAreaLayoutGuide.bottomAnchor,
                              leading: view.leadingAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 0 , left: 0, bottom: 0, right: 0))
        
    }

}

extension HomeFeedController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieGroup.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        
            cell.categoryTypeLabel.text = entertainment[indexPath.item]
            let groups = movieGroup[indexPath.item]
            cell.movieController.movieGroup = groups
            cell.movieController.collectionView.reloadData()
        return cell
      
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height - 60 - 44 - UIApplication.shared.statusBarFrame.height)
    }
}

extension HomeFeedController: MenuControllerDelegate {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let offset = x / 2
        menuController.menuBar.transform = CGAffineTransform(translationX: offset, y: 0)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let item = x / view.frame.width
        let indexPath = IndexPath(item: Int(item), section: 0)
        menuController.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func didTapMenuItem(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

