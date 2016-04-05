//
//  PostDetail2ViewController.swift
//  Training
//
//  Created by Lukasz on 05/04/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit
import Alamofire

class PostDetail2ViewController: UIViewController {
    
//    private var v: PostDetail2View {
//        return view as! PostDetail2View
//    }
    
    private let post: Post
    
    private let userView = UIView()
    private let userNameLabel = UILabel()
    private let userActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = PostDetail2View()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = post.title

        setupView()
        startRequest()
    }
    
    
    // MARK: View
    
    private func setupView() {
        view.backgroundColor = UIColor.whiteColor()
        
        // post title
        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(view).offset(80)
        }
        
        titleLabel.numberOfLines = 0
        titleLabel.text = post.title
        
        // post body
        let bodyLabel = UILabel()
        view.addSubview(bodyLabel)
        
        bodyLabel.snp_makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(titleLabel.snp_bottom).offset(20)
        }
        
        bodyLabel.numberOfLines = 0
        bodyLabel.text = post.body
        
        
        
        // user
        
        view.addSubview(userView)
        userView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(bodyLabel.snp_bottom).offset(20)
        }
        
        // userview is hidden at first until user is loaded
        userView.hidden = true
        
        userView.addSubview(userNameLabel)
        userNameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(userView).offset(20)
            make.right.equalTo(userView).offset(-20)
            make.top.equalTo(userView)
        }
        
        userNameLabel.numberOfLines = 0
        
        
        
        // activity indicator
        // loading at first until the user is loaded
        view.addSubview(userActivityIndicatorView)
        userActivityIndicatorView.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(20)
        }
        userActivityIndicatorView.startAnimating()
    }
    
    private func bindUser(user: User) {
        userNameLabel.text = user.name
        // etc
        
        userView.alpha = 0
        userView.hidden = false
        
        UIView.animateWithDuration(0.6) {
            self.userView.alpha = 1
        }
    }
    
    
    // MARK: Request
    
    private func startRequest() {
        Alamofire.request(.GET, "http://jsonplaceholder.typicode.com/users/\(post.userId)").responseJSON { [weak self]
            (response) in
            
            guard let s = self else { return }
            
            s.userActivityIndicatorView.hidden = true
            
            guard let json = response.result.value as? [String:AnyObject] else {
                return
            }
            
            let user = User(name: json["name"] as? String ?? "", username: json["username"] as? String ?? "")
            
            
            // check fields blank
            // TODO
            
            // then
            s.bindUser(user)
        }
    }
}














