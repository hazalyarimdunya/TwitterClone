//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by PC on 25.06.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    //Bir tablo tanimlanir.
    private let timelineTableView : UITableView = {
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell") //tablonun icinde hucre olacagini bildiriyoruz.
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timelineTableView) //sub view olarak tabloyu ekliyoruz
        
        //tabloya veri gondermek icin bazi protokoller(interface) olusturulur.(dataSource,delegate)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
    }
    
    // tablonun ekranda gozukmesi icin
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.frame
    }
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "hello"
        return cell
    }
}
