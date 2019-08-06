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
    let testCellId = "testCellId"
    var dummyUser: [String:String] = ["name":"Your Name", "email":"Your Email"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.register(UserInfoCell.self, forCellReuseIdentifier: cellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: testCellId)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleLogOut))
        setupNavController()
        fetchCurrentUser()
        configureTableView()
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
    
    fileprivate func configureTableView() {
        tableView.rowHeight = 60
        tableView.frame = view.frame
        tableView.tableFooterView = UIView()
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSections(rawValue: section) else { return 0 }
        
        switch section {
        case .Social: return SocialOptions.allCases.count
        case .AboutUs : return AboutUs.allCases.count
        }
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserInfoCell
//        cell.emailProfile.text = user?.email
//        cell.nameProfile.text = user?.name
//        cell.imageProfile.sd_setImage(with: URL(string: user?.imageUrl ?? "") )
//        return cell
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: testCellId, for: indexPath)
//        cell.backgroundColor = .blueDark3
        guard let section = SettingsSections(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Social:
             let social = SocialOptions(rawValue: indexPath.row)
            cell.textLabel?.text = social?.description
        case .AboutUs :
            let aboutUs = AboutUs(rawValue: indexPath.row)
            cell.textLabel?.text = aboutUs?.description
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingsSections(rawValue: indexPath.section) else { return}
        
        switch section {
        case .Social:
            let social = SocialOptions(rawValue: indexPath.row)
            if social == .EditProfile {
                let yellowVC = UIViewController()
                yellowVC.view.backgroundColor = .yellow
                self.present(yellowVC, animated: true)
            } else {
                print("whatever")
            }

        case .AboutUs :
            let aboutUs = AboutUs(rawValue: indexPath.row)
            //add event on tap here
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .blueDark3
        
        let title = UILabel()
        title.font = UIFont(name: Fonts.latoHeavy, size: 20)
        title.textColor = .sunnyOrange
        title.text = SettingsSections(rawValue: section)?.description
        view.addSubview(title)
        title.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

