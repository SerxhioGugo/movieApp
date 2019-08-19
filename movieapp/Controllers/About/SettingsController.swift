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
    fileprivate let supportSettingsCellId = "supportSettingsCellId"
    fileprivate let profileSettingsCellId = "testCellId"
    fileprivate let copyrightCellId = "copyrightCellId"
    var user: User?
    var dummyUser: [String:String] = ["name":"Your Name", "email":"Your Email"]
    var profileSettings = ["Edit Profile", "Log Out"]
    var supportSettings = ["Contact Us", "Rate TrailersHub" , "Terms and Conditions", "Privacy Policy"]
    
    //Mark: fix log out button
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleLogOut))
        navigationItem.rightBarButtonItem?.isEnabled = true
        setupNavController()
        fetchCurrentUser()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            fetchCurrentUser()
            tableView.reloadData()
            navigationItem.rightBarButtonItem?.isEnabled = true
            print("tableView is reloading")
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.tintColor = .clear
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
        tableView.register(UserInfoCell.self, forCellReuseIdentifier: cellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: profileSettingsCellId)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: supportSettingsCellId)
        tableView.register(CopyrightCell.self, forCellReuseIdentifier: copyrightCellId)
        tableView.separatorStyle = .none
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
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return profileSettings.count
        case 2: return supportSettings.count
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserInfoCell
            cell.selectionStyle = .none
            cell.emailProfile.text = user?.email
            cell.nameProfile.text = user?.name
            cell.imageProfile.sd_setImage(with: URL(string: user?.imageUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "user"))
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: profileSettingsCellId, for: indexPath)
            cell.textLabel?.text = profileSettings[indexPath.row]
            cell.textLabel?.font = UIFont(name: Fonts.latoRegular, size: 16)
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .cgGrayColor
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: profileSettingsCellId, for: indexPath)
            cell.textLabel?.text = supportSettings[indexPath.row]
            cell.textLabel?.font = UIFont(name: Fonts.latoRegular, size: 16)
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .cgGrayColor
            cell.accessoryType = .disclosureIndicator
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: copyrightCellId, for: indexPath) as! CopyrightCell
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 120
        case 1: return 40
        case 3: return 140
        default:
            return 40
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let view = UIView()
            view.backgroundColor = .blueDark3
            
            let title = SettingsHeaderLabel(title: "Social", frame: .zero)
            view.addSubview(title)
            title.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 0))
            return view
            
        case 2:
            let view = UIView()
            view.backgroundColor = .blueDark3
            
            let title = SettingsHeaderLabel(title: "Support", frame: .zero)
            view.addSubview(title)
            title.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 0))
            return view
        case 3:
            let view = UIView()
            view.backgroundColor = .blueDark3
            
            let title = SettingsHeaderLabel(title: "", frame: .zero)
            view.addSubview(title)
            title.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 0))
            return view
        default:
            return UIView()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1: return 40
        case 2: return 40
        case 3: return 40
        default: return 0
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 0 {
            print("go To Edit Profile")
        } else if indexPath.section == 1 && indexPath.row == 1 {
            print("Log out user")
        } else if indexPath.section == 2 && indexPath.row == 0 {
            print("Go to contact us")
        } else if indexPath.section  == 2 && indexPath.row == 1 {
            print("go rate app")
        } else if indexPath.section  == 2 && indexPath.row == 2 {
            print("go to Terms and conditions")
        } else if indexPath.section  == 2 && indexPath.row == 3 {
            print("go to privacy policy")
        }
    }
}

