//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by PC on 27.06.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //profil ekraninin tamamini kapsayacak bir tablo generate edilir.
    private let profileTableView:UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        navigationItem.title = "Profile"
        view.addSubview(profileTableView)
        
        //Profil ekranina bir header alani icin view generate edileccek.
        let headerView = ProfileHeaderUIView(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 350))
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.tableHeaderView = headerView //profil ekranindaki tabloya yaratilan header alani atanacak.
       // profileTableView.contentInsetAdjustmentBehavior = .never //scroll ederken kenar bosluklarini otomotik ayarla. Never: İçerik eklemeleri otomatik olarak ayarlanmaz manuel olarak ayarlamalıdır.
       // navigationController?.navigationBar.isHidden = true // navbar gozukmeyecek.
        configureConstraints()

    }
    
    private func configureConstraints(){
        let profileTableViewConstraints = [
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ]
        NSLayoutConstraint.activate(profileTableViewConstraints)
    }

}

extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
