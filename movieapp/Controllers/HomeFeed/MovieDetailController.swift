//
//  MovieDetailController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/31/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailController: BaseListController {
    
    fileprivate let movieDetailId = "movieDetailId"
    var movieDetails: MovieDetail?
    
    var movieId: Int! {
        didSet {
            print("here is my app id : \(movieId ?? 0)")
            let urlString = "https://api.themoviedb.org/3/movie/\(movieId ?? 0)?api_key=acb5063b86a8efb1ba814b6ad605f578&append_to_response=videos,credits,images"
            
            APIClient.shared.fetchGenericJSONData(urlString: urlString) { (request: MovieDetail?, error) in
                
                if let error = error {
                    print("Error fetching data: ", error)
                    return
                }
                
                let movie = request
                DispatchQueue.main.async {
                    self.movieDetails = movie
                    self.collectionView.reloadData()
                }
                
            }
        }
    }
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.75)
        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleDissmiss), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDissmiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(MovieDetailCell.self, forCellWithReuseIdentifier: movieDetailId)
        
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 50, height: 50))
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieDetailId, for: indexPath) as! MovieDetailCell
        cell.dataSource = movieDetails
        return cell
    }
}

extension MovieDetailController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
    
}
