//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by PC on 25.06.2024.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    //Bir tablo tanimlanir.
    private let timelineTableView : UITableView = {
        let tableview = UITableView()
        tableview.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier) //tablonun icinde hucre olacagini bildiriyoruz.Bu hucreleri TweetTableViewCell den cekecek.
        return tableview
    }()
    
    //naviggation bar tasarlama
    let size:CGFloat = 36
    private func configureNavigationBar(){
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "TwitterLogo")
        
        //logoyu ekranda gormek icin bir subview yaratilmali navbar da.
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(logoImageView)
        navigationItem.titleView = middleView // yaratilan view navbara atanir.
        
        //Profil butonu icin bir UIImage acilir ve icrisine bir BarButton verilir.
        let profileImage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(didTapProfile))
        
    }
    @objc private func didTapProfile(){
        //profile sayfasi yaratmak icin bir vc acilir ve bu fonksiyona objesi eklenir.
        let vc = ProfileViewController()
        //acilan vc navbara pushlanmali
        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timelineTableView) //sub view olarak tabloyu ekliyoruz
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapSignOut))
        
        //tabloya veri gondermek icin bazi protokoller(interface) olusturulur.(dataSource,delegate)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        configureNavigationBar()
    }
    
    @objc private func didTapSignOut(){
         try? Auth.auth().signOut()
        handleAuthantication()
        
    }
    
    // tablonun ekranda gozukmesi icin
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.frame
    }
    
    private func handleAuthantication() {
        if Auth.auth().currentUser == nil{ //Eger suanki kullanici bir sey gondermiyorsa
            let vs = UINavigationController(rootViewController: OnboardingViewController())
            vs.modalPresentationStyle = .fullScreen
            present(vs, animated: false)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden  = false
        handleAuthantication()
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

// TweetTableViewCell uzerindeki butonlarin aksiyonlarini homeVC de gormek icin delegateini burada cagiriyoruz.
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
