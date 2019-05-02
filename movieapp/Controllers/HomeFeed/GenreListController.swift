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
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        //        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        //        blurEffectView.contentView.addSubview(vibrancyView)
        return blurEffectView
    }()
    
    let genreLabel: UILabel = {
       let label = UILabel()
        label.text = "Genres"
        label.textColor = .sunnyOrange
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.latoHeavy, size: 35)
        return label
    }()
    
    let dismissButton: UIButton = {
       let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.myBlack, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 60 / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleDissmiss), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        fetchGenres()
        view.backgroundColor = .myBlack
        collectionView.backgroundColor = .myBlack
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    fileprivate func fetchGenres() {
        let jsonUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key=acb5063b86a8efb1ba814b6ad605f578"
        
        APIClient.shared.fetchGenericJSONData(urlString: jsonUrl) { (result: Movie?, error) in
            
            if let error = error {
                print("Error fetching genres", error)
                return
            }
            
            self.movie = result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func handleDissmiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupLayout() {
        
        collectionView.centerInSuperview(size: .init(width: view.frame.width , height: view.frame.height / 1.6))
        view.addSubview(dismissButton)
        NSLayoutConstraint.activate([
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            dismissButton.heightAnchor.constraint(equalToConstant: 60),
            dismissButton.widthAnchor.constraint(equalToConstant: 60)
            ])
        
        view.addSubview(genreLabel)
        genreLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: collectionView.topAnchor, trailing: view.trailingAnchor)
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
        let genre = movie?.genres[indexPath.item]
        print(genre?.id)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }
}
