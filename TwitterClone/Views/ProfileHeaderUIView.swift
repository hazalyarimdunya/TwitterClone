//
//  ProfileHeaderUIView.swift
//  TwitterClone
//
//  Created by PC on 29.06.2024.
//

import UIKit

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
        label.text = "Hazal Yarimdunya's bio, open to everybody"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)

        return label
    }()
    
    private let joinedDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 13))
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
        configureConstraints()
    }
    
    private func configureConstraints(){
       let profileHeaderImageViewConstraints = [
        profileHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        profileHeaderImageView.topAnchor.constraint(equalTo: topAnchor),
        profileHeaderImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        profileHeaderImageView.heightAnchor.constraint(equalToConstant: 150)
        ]
        let profileAvatarImageViewConstraints = [
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileAvatarImageView.centerYAnchor.constraint(equalTo: profileHeaderImageView.bottomAnchor, constant: 5),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80)
        ]
        let displayNameConstraints = [
            displayNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor, constant: 20)
        ]
        let usernameLabelConstraints = [
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 10)
        ]
        let profileBioLabelConstraints = [
            profileBioLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileBioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10)
        ]
        let joinedDateImageViewConstraints = [
            joinedDateImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            joinedDateImageView.topAnchor.constraint(equalTo: profileBioLabel.bottomAnchor, constant: 10)
        ]
        let joinedDateLabelConstraints = [
            joinedDateLabel.leadingAnchor.constraint(equalTo: joinedDateImageView.trailingAnchor, constant: 5),
            joinedDateLabel.bottomAnchor.constraint(equalTo: joinedDateImageView.bottomAnchor)
        ]
        let followingCountLabelConstraints = [
            followingCountLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
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
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
