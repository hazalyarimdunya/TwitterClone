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
        tableview.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier) //tablonun icinde hucre olacagini bildiriyoruz.Bu hucreleri TweetTableViewCell den cekecek.
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
    // TweetTableViewCell icerisine tanimlanan UI elemanlari tablomuzda cagirmak icin ID sini buraya veriyoruz.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self // TweetTableViewCellDelegate e bu tablodan veri gondermek icin. TweetTableViewCellDelegate Protokolunu dinliyoruz
        return cell
    }
 
}

// TweetTableViewCell uzerindeki butonlarin aksiyonlarini homeVC de ormek icin delegateini burada cagiriyoruz.
extension HomeViewController:TweetTableViewCellDelegate{
    func TweetTableViewCellDidTapReply() {
        print("Reply")
    }
    
    func TweetTableViewCellDidTapShare() {
        print("Share")
    }
    
    func TweetTableViewCellDidTapLike() {
        print("Like")
    }
    
    func TweetTableViewCellDidTapRetweet() {
        print("Retweet")
    }
    
    
}
