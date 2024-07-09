//
//  TweetTableViewCell.swift
//  TwitterClone
//
//  Created by PC on 26.06.2024.
//

import UIKit

//share, like vs butonlari tiklanma aksiyonlari icin bir interface olusturuyoruz.
protocol TweetTableViewCellDelegate: AnyObject {
    func TweetTableViewCellDidTapReply()
    func TweetTableViewCellDidTapShare()
    func TweetTableViewCellDidTapLike()
    func TweetTableViewCellDidTapRetweet()
}

//tablodaki cell leri ifade edecek.
class TweetTableViewCell: UITableViewCell {

    static let identifier = "TweetTableViewCell" //cell icin bir id tanimlanir
    
    weak var delegate:TweetTableViewCellDelegate? //objesini olusturuyoruz
    
    private let actionSpacing:CGFloat = 60  // share,like vs butonlar arasi boslugu esitleme
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView() // init
        imageView.image = UIImage(systemName: "person")
        imageView.translatesAutoresizingMaskIntoConstraints = false // auto layout engellemek icin false verilir. Sonrasinda kendimiz constraint ekleyecegiz.
        imageView.contentMode = .scaleAspectFill // person resmi tum imageViewin icini kapsayacak
        imageView.layer.cornerRadius = 25 //tam yuvarlak bir image icin.
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hazal"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@hzl_yd"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private let tweetTextContentLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac pharetra massa, nec convallis tellus. Nullam id enim eget velit ultrices convallis. Etiam risus arcu, laoreet eu rutrum et, fringilla quis leo. Duis dictum dui sit amet pharetra hendrerit. Aenean bibendum ut quam at dapibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In hac habitasse platea dictumst. Etiam condimentum tincidunt tortor vitae facilisis."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let replyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.turn.up.left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .darkGray
        return button
    }()
    
    private let shareButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    private let retweetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .darkGray
        button.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(displayNameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(tweetTextContentLabel)
        contentView.addSubview(replyButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(retweetButton)
        
        configureConstraints()
        configureButtons()
    }
    
    
    //addTargetin isaret ettigi fonksiyonlar iccin  delegate cagiriyoruz.
    @objc private func didTapReply(){
        delegate?.TweetTableViewCellDidTapReply()
    }
    @objc private func didTapShare(){
        delegate?.TweetTableViewCellDidTapShare()
    }
    @objc private func didTapLike(){
        delegate?.TweetTableViewCellDidTapLike()
    }
    @objc private func didTapRetweet(){
        delegate?.TweetTableViewCellDidTapRetweet()
    }
    
    //Butonlara tiklanma aksiyonu icin fonksiyon aliyoruz.
    private func configureButtons(){
        replyButton.addTarget(self, action: #selector(didTapReply), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        retweetButton.addTarget(self, action: #selector(didTapRetweet), for: .touchUpInside)
        
    }
    
    
    
    private func configureConstraints(){
        let avatarImageViewConstraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50)
        ]
        let displayNameLabelConstraints = [
            displayNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            displayNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
        ]
        let usernameLabelConstrains = [
            usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.trailingAnchor, constant: 20),
            usernameLabel.centerYAnchor.constraint(equalTo: displayNameLabel.centerYAnchor)
        ]
        let tweetTextContentLabelConstraints = [
            tweetTextContentLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            tweetTextContentLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 10),
            tweetTextContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ]
        let replyButtonConstraints = [
            replyButton.leadingAnchor.constraint(equalTo: tweetTextContentLabel.leadingAnchor),
            replyButton.topAnchor.constraint(equalTo: tweetTextContentLabel.bottomAnchor, constant: 20),
            replyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ]
        let shareButtonConstraints = [
            shareButton.leadingAnchor.constraint(equalTo: replyButton.trailingAnchor, constant: actionSpacing),
            shareButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)
        ]
        let likeButtonConstraints = [
            likeButton.leadingAnchor.constraint(equalTo: shareButton.trailingAnchor, constant: actionSpacing),
            likeButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)

        ]
        let retweetButtonConstraints = [
            retweetButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: actionSpacing),
            retweetButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)
        ]
        
        
        
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLabelConstraints)
        NSLayoutConstraint.activate(usernameLabelConstrains)
        NSLayoutConstraint.activate(tweetTextContentLabelConstraints)
        NSLayoutConstraint.activate(replyButtonConstraints)
        NSLayoutConstraint.activate(shareButtonConstraints)
        NSLayoutConstraint.activate(likeButtonConstraints)
        NSLayoutConstraint.activate(retweetButtonConstraints)
    }
    
    //herhanggi bir hata durumunda appin cokmemesi icin
    required init?(coder: NSCoder) {
        fatalError()
    }

}
