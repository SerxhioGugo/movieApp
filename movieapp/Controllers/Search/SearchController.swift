//
//  SearchController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/10/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class SearchController: BaseListController, UISearchBarDelegate {
    
    fileprivate let cellId = "cellId"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var searchResult = [SearchResult]()
    fileprivate var timer: Timer?
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "🔍 Please enter a movie above..."
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 20)
        label.numberOfLines = 0
        label.textColor = UIColor.sunnyOrange
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.blueDark3
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.centerInSuperview()
        
        setupSearchBar()
        setupNavController()
    }
    
    fileprivate func setupNavController() {
        navigationController?.navigationBar.barTintColor = UIColor.blueDark3
        navigationController?.navigationBar.prefersLargeTitles = false
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.sunnyOrange]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.backgroundColor = .clear
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search movies..."
        searchController.searchBar.isTranslucent = false
        searchController.searchBar.barStyle = .blackTranslucent
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        timer?.invalidate()
        guard let text = searchBar.text else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            guard let url = Service.requests(.query(searchTerm: text)) else { return }
            Service.fetchJSON(url: url) { (request: Search?, error) in
                if let error = error {
                    print("Error fetching data: ", error)
                }
                guard let request = request?.results else { return }
                self.searchResult = request
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.searchResult.removeAll()
            self.collectionView.reloadData()
        }
        
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (_) in
//            guard let url = Service.requests(.query(searchTerm: searchText)) else { return }
//            Service.fetchJSON(url: url) { (request: Search?, error) in
//                if let error = error {
//                    print("Error fetching data: ", error)
//                }
//                guard let request = request?.results else { return }
//                self.searchResult = request
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//            }
//        })
//    }
}

extension SearchController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = searchResult.count != 0
        return searchResult.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        cell.dataSource = searchResult[indexPath.item]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.50) {
            cell.alpha = 1.0
        }
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
