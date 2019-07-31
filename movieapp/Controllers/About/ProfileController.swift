//
//  AboutController.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/10/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
import SDWebImage

class SettingsController: UITableViewController {
    
    fileprivate let cellId = "cellId"
    var user: User?
    
//    let dummyUser: [String: String] = [name: "Your Name", email: "Your email"]
    var dummyUser: [String:String] = ["name":"Your Name", "email":"Your Email"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UserInfoCell.self, forCellReuseIdentifier: cellId)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleLogOut))
        setupNavController()
        fetchCurrentUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            fetchCurrentUser()
            tableView.reloadData()
            print("tableView is reloading")
        } else {
            self.user = User(dictionary: dummyUser)
            tableView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if Auth.auth().currentUser != nil {
            fetchCurrentUser()
            tableView.reloadData()
            print("tableView is reloading")
        } else {
            self.user = User(dictionary: dummyUser)
            tableView.reloadData()
        }
    }
    
    fileprivate func setupNavController() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor.blueDark3
        navigationController?.navigationBar.prefersLargeTitles = false
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.sunnyOrange]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    //MARK: Actions
    fileprivate func fetchCurrentUser() {
        //Pulling current user
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print("Failed fetching current user", err)
                return
            }
            guard let dictionary = snapshot?.data() else { return }
            self.user = User(dictionary: dictionary)
            self.tableView.reloadData()
            
        }
    }
    
    @objc fileprivate func handleLogOut() {
        print("Attempting to log out")
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("user signed out")
        }
        
        let signInController = SignInController()
        self.present(signInController, animated: true)
    }
}

extension SettingsController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserInfoCell
        cell.emailProfile.text = user?.email
        cell.nameProfile.text = user?.name
        cell.imageProfile.sd_setImage(with: URL(string: user?.imageUrl ?? "") )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
