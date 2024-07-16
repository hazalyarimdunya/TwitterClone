//
//  ProfileHeaderUIView.swift
//  TwitterClone
//
//  Created by PC on 29.06.2024.
//

import UIKit

//enum for getting indexes of menus on profile page
private enum SectionTabs:String{
    case tweets = "Tweets"
    case tweetsAndRepplies = "Tweets&Replies"
    case media = "Media"
    case likes = "Likes"
    
    var index : Int{
        switch self{
        case .tweets: return 0
        case .tweetsAndRepplies: return 1
        case .media: return 2
        case .likes: return 3
        }
    }
}

class ProfileHeaderUIView: UIView {
        
    private let profileHeaderImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.clipsToBounds = true //gorsel, belirlenen sinirin disina cikamaz.
        imageView.image = UIImage(named: "twitterBioImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let profileAvatarImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds =  true
        imageView.layer.cornerRadius = 40 // Köşeleri yuvarlama dereecsi
        imageView.layer.masksToBounds =  true // Alt katmanların ana katmanın sınırlarının dışına çıkmasını engelle
        imageView.image = UIImage(systemName: "person")
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    private let displayNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Hazal Yarimdunya"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "@hazel_yd"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let profileBioLabel : UILabel = {
        let label = UILabel()
        label.text = "Hazal Yarimdunya's bio, open to everybody try to type something that discripe you 's bio, open to everybody try to type something that discripe you"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0

        return label
    }()
    
    private let joinedDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .secondaryLabel
        return imageView
    }()
    
    private let joinedDateLabel:UILabel = {
        let label = UILabel()
        label.text = "27-07-1999 joined"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    private let followingCountLabel:UILabel = {
        let label = UILabel()
        label.text = "1M"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    private let followingTextLabel:UILabel = {
        let label = UILabel()
        label.text = "Following"
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private let followersCountLabel:UILabel = {
        let label = UILabel()
        label.text = "123B"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followersTextLabel:UILabel = {
        let label = UILabel()
        label.text = "Followers"
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    //Profile page menus(tweets,replies,media vs)
    //map:bir koleksiyonun (dizi, set, sözlük vb.) her bir öğesi üzerinde aynı işlemi gerçekleştirerek yeni bir koleksiyon oluşturmanızı sağlar.
    private var tabs:[UIButton] = ["Tweets","Tweets&Replies","Media","Likes"].map{ buttonTitles in
        let button = UIButton(type: .system)
        button.setTitle(buttonTitles, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    //staackView:subviewlari yatay ve dikey duzenlemeyi saglar.
    private lazy var sectionStack : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs) //buton tipindeki subviewlari stack icine ekleme
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var selectedTab:Int = 0 {
        didSet{
            for i in 0..<tabs.count{ //menulerin altindaki cizgi icinn bir annimasyon kurruyoruz.
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
                    self?.sectionStack.arrangedSubviews[i].tintColor = i == self?.selectedTab ? .label : .secondaryLabel
                    // Eger i selectedTab a esitse, secilen tabin rengi '.label' olur, geriye kalan tablar '.secondaryLabel' olur.
                    self?.myLeadingAnchors[i].isActive = i == self?.selectedTab ? true  : false
                    self?.myTrailingAnchors[i].isActive = i == self?.selectedTab ? true  : false
                    self?.layoutIfNeeded()
                } completion: { _ in }
            }
        }
    }
    
    private let indicator:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        return view
    }()
    
    private var myLeadingAnchors:[NSLayoutConstraint] = []
    private var myTrailingAnchors:[NSLayoutConstraint] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileHeaderImageView)
        addSubview(profileAvatarImageView)
        addSubview(displayNameLabel)
        addSubview(usernameLabel)
        addSubview(profileBioLabel)
        addSubview(joinedDateImageView)
        addSubview(joinedDateLabel)
        addSubview(followersTextLabel)
        addSubview(followingTextLabel)
        addSubview(followersCountLabel)
        addSubview(followingCountLabel)
        addSubview(sectionStack)
        addSubview(indicator)
        configureConstraints()
        configureStackButton()
    }
    
    private func configureStackButton(){
        //enumareted(): bir dizi veya başka bir sıralı koleksiyonun her bir öğesinin indexini(i) ve degerini(buttons) içeren bir sekans döndürür.
        for(i,buttons) in sectionStack.arrangedSubviews.enumerated(){
            guard let button = buttons as? UIButton else{return }
            if i == selectedTab {
                button.tintColor = .label
            }
            else{
                button.tintColor = .secondaryLabel
            }
            button.addTarget(self, action: #selector(didTapTaps(_:)), for: .touchUpInside)
            
        }
    }
    @objc private func didTapTaps(_ sender:UIButton){
        guard let label = sender.titleLabel?.text else {return} //cliklenen her butonun textini label degiskenine atiyoruz.
        switch label { //butonlarin rawValue degeri yani title degeri label degiskeni ile ayniysa ona gore caseler calisir.
        case SectionTabs.tweets.rawValue:
            selectedTab = 0
        case SectionTabs.tweetsAndRepplies.rawValue:
            selectedTab = 1
        case SectionTabs.media.rawValue:
            selectedTab = 2
        case SectionTabs.likes.rawValue:
            selectedTab = 3
        default:
            selectedTab = 4
        }
        
    }
    
    private func configureConstraints(){
       let profileHeaderImageViewConstraints = [
        profileHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        profileHeaderImageView.topAnchor.constraint(equalTo: topAnchor),
        profileHeaderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        profileHeaderImageView.heightAnchor.constraint(equalToConstant: 120)
        ]
        let profileAvatarImageViewConstraints = [
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImageView.centerYAnchor.constraint(equalTo: profileHeaderImageView.bottomAnchor), //Y ekseninde headerImagein bottomina gore avatari ortala
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80)
        ]
        let displayNameConstraints = [
            displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor, constant: 10)
        ]
        let usernameLabelConstraints = [
            usernameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 10)
        ]
        let profileBioLabelConstraints = [
            profileBioLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            profileBioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            profileBioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ]
        let joinedDateImageViewConstraints = [
            joinedDateImageView.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            joinedDateImageView.topAnchor.constraint(equalTo: profileBioLabel.bottomAnchor, constant: 10)
        ]
        let joinedDateLabelConstraints = [
            joinedDateLabel.leadingAnchor.constraint(equalTo: joinedDateImageView.trailingAnchor, constant: 5),
            joinedDateLabel.centerYAnchor.constraint(equalTo: joinedDateImageView.centerYAnchor)
        ]
        let followingCountLabelConstraints = [
            followingCountLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            followingCountLabel.topAnchor.constraint(equalTo: joinedDateImageView.bottomAnchor, constant: 10),
        ]
        let followingTextLabelConstraints = [
            followingTextLabel.leadingAnchor.constraint(equalTo: followingCountLabel.trailingAnchor, constant: 5),
            followingTextLabel.topAnchor.constraint(equalTo: joinedDateImageView.bottomAnchor, constant: 10)
        ]
        let followersCountLabelConstraints = [
            followersCountLabel.leadingAnchor.constraint(equalTo: followingTextLabel.trailingAnchor, constant: 10),
            followersCountLabel.topAnchor.constraint(equalTo: joinedDateImageView.bottomAnchor, constant: 10)
        ]
        let followersTextLabelConstraints = [
            followersTextLabel.leadingAnchor.constraint(equalTo: followersCountLabel.trailingAnchor, constant: 5),
            followersTextLabel.bottomAnchor.constraint(equalTo: followersCountLabel.bottomAnchor)
        ]
        let sectionStackConstraints = [
            sectionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            sectionStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            sectionStack.topAnchor.constraint(equalTo: followersTextLabel.bottomAnchor, constant: 10),
            sectionStack.heightAnchor.constraint(equalToConstant: 30),
            sectionStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
        ]
        
        for i in 0..<tabs.count{  //indictorun(menu alt cizgisi) leading ve trailingi butonun leading ve trailingine esitlendi. ve diziye eklendi.
            let leadingAnchor = indicator.leadingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[i].leadingAnchor)
            myLeadingAnchors.append(leadingAnchor)
            let trailingAnchors = indicator.trailingAnchor.constraint(equalTo: sectionStack.arrangedSubviews[i].trailingAnchor)
            myTrailingAnchors.append(trailingAnchors)
        }
        let indicatorConstraints = [
            myLeadingAnchors[0],
            myTrailingAnchors[0],
            indicator.topAnchor.constraint(equalTo: sectionStack.arrangedSubviews[0].bottomAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 5)
        ]
        
        
        
        NSLayoutConstraint.activate(profileHeaderImageViewConstraints)
        NSLayoutConstraint.activate(profileAvatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameConstraints)
        NSLayoutConstraint.activate(usernameLabelConstraints)
        NSLayoutConstraint.activate(profileBioLabelConstraints)
        NSLayoutConstraint.activate(joinedDateImageViewConstraints)
        NSLayoutConstraint.activate(joinedDateLabelConstraints)
        NSLayoutConstraint.activate(followersTextLabelConstraints)
        NSLayoutConstraint.activate(followingTextLabelConstraints)
        NSLayoutConstraint.activate(followingCountLabelConstraints)
        NSLayoutConstraint.activate(followersCountLabelConstraints)
        NSLayoutConstraint.activate(sectionStackConstraints)
        NSLayoutConstraint.activate(indicatorConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
