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
    fileprivate let creditsId = "creditsId"
    fileprivate let videoId = "videoId"
    var movieDetails: MovieDetail?
    
    fileprivate let movieId: Int
    
    //DI
    init(movieId: Int) {
        self.movieId = movieId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let aiv: UIActivityIndicatorView = {
       let aiv = UIActivityIndicatorView()
        aiv.backgroundColor = .myBlack
        aiv.color = .sunnyOrange
        aiv.startAnimating()
        return aiv
    }()
    
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.50)
        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleDissmiss), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDissmiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(aiv)
        aiv.fillSuperview()
        
        setupCollectionView()
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, size: .init(width: 50, height: 50))

        fetchData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .myBlack
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(MovieDetailCell.self, forCellWithReuseIdentifier: movieDetailId)
        collectionView.register(CreditsCell.self, forCellWithReuseIdentifier: creditsId)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: videoId)
    }
    
    fileprivate func fetchData() {
        print("here is my app id : \(movieId)")
        
        let urlString = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=acb5063b86a8efb1ba814b6ad605f578&append_to_response=videos,credits,images"
        
        APIClient.shared.fetchGenericJSONData(urlString: urlString) { (request: MovieDetail?, error) in
            
            if let error = error {
                print("Error fetching data: ", error)
                return
            }
            
            let movie = request
            DispatchQueue.main.async {
                self.movieDetails = movie
                self.collectionView.reloadData()
                self.aiv.stopAnimating()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieDetailId, for: indexPath) as! MovieDetailCell
            cell.dataSource = movieDetails
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: creditsId, for: indexPath) as! CreditsCell
            cell.creditsController.movieDetail = self.movieDetails
            cell.creditsController.collectionView.reloadData()
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoId, for: indexPath) as! VideoCell
            cell.trailerController.movieDetail = self.movieDetails
            cell.trailerController.collectionView.reloadData()
            return cell
            
        default:
            return UICollectionViewCell()
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: 0, height: 80)
    }
}

extension MovieDetailController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            let dummyCell = MovieDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.overviewLabel.text = movieDetails?.overview
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            return .init(width: view.frame.width, height: estimatedSize.height)
        case 1:
            return .init(width: view.frame.width, height: view.frame.height / 3.2)
            
        case 2:
            return .init(width: view.frame.width, height: view.frame.height / 4.2)
        default:
            return CGSize(width: 0, height: 0)
        }

    }
    
}
