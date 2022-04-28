//
//  UsersViewController.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation
import UIKit
import smooth_feed
import RealmSwift
import Lottie

class UsersViewController: UIViewController, UsersViewable {
    var presenter: UsersPresenterable?
    var collectionView: UICollectionView?
    var searchBar: UISearchBar?
    var items: [[FeedItem]] = []
    var data: [[FeedItem]] = []
    var users: [User]?
    var usersEntity: [User]?
    var emptyView: UIView?
    var emptyLabel: UILabel?
    var animationView: AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = SmoothFeedCollectionViewLayout()
        layout.estimatedItemHeight = 100
        layout.itemsInSectionMaxHeight = 404
        layout.footerHeight = 80
        layout.headerHeight = UIScreen.main.bounds.width/1.5
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 113, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 113), collectionViewLayout: layout)
        collectionView?.collectionViewLayout = layout
        collectionView?.register(UINib(nibName: PostCollectionViewCell.reuseIdentifier, bundle: nil),
                                forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)
        collectionView?.register(UINib(nibName: PostsInfoCollectionViewCell.reuseIdentifier, bundle: nil),
                                forCellWithReuseIdentifier: PostsInfoCollectionViewCell.reuseIdentifier)
        collectionView?.register(UINib(nibName: UserCollectionReusableView.reuseIdentifier, bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: UserCollectionReusableView.reuseIdentifier)
        collectionView?.register(UINib(nibName: UserFooterCollectionReusableView.reuseIdentifier, bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: UserFooterCollectionReusableView.reuseIdentifier)
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.dataSource = self
        
        emptyView = UIView(frame: CGRect(x: 0, y: 113, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 113))
        emptyView?.isHidden = true
        emptyView?.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.1098039216, blue: 0.2392156863, alpha: 1)
        
        searchBar = UISearchBar(frame:CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 50))
        searchBar?.placeholder = "Filter by name, email & phone"
        searchBar?.searchTextField.font = UIFont(name: "Montserrat-Medium", size: 12)
        searchBar?.delegate = self
        searchBar?.showsSearchResultsButton = true
        view.addSubview(searchBar!)
        view.addSubview(collectionView!)
        view.addSubview(emptyView!)
        view.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.1098039216, blue: 0.2392156863, alpha: 1)
        title = "Admission Test - Ceiba Software"
        addEmptyItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.present(Views.Loading, animated: true, completion: nil)
    }
    
    func setData(items: [[FeedItem]]) {
        self.items = items
        self.data = items
    }
    
    func reloadCollection() {
        self.collectionView?.reloadData()
    }
    
    func updateEntity(users: [User]) {
        self.users = users
        self.usersEntity = users
    }
    
    func addEmptyItems(){
        animationView = AnimationView(name: "empty")
        animationView!.loopMode = .loop
        animationView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
        animationView!.contentMode = .scaleAspectFill
        animationView!.center = self.emptyView!.center
        
        self.emptyView!.addSubview(animationView!)
        
        emptyLabel = UILabel()
        emptyLabel?.font = UIFont(name: "Montserrat-Medium", size: 16)
        emptyLabel?.textColor = .white
        emptyLabel?.textAlignment = .center
        emptyLabel?.numberOfLines = 0
        self.emptyView!.addSubview(emptyLabel!)

        emptyLabel!.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: emptyLabel!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)

        let verticalConstraint = NSLayoutConstraint(item: emptyLabel!, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: emptyLabel!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width)
        let heightConstraint = NSLayoutConstraint(item: emptyLabel!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UsersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.section][indexPath.item]
        switch item {
        case .posts(let count):
            let reuseIdentifier = PostsInfoCollectionViewCell.reuseIdentifier
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                          for: indexPath) as! PostsInfoCollectionViewCell
            cell.posts.text = "\(count) posts"
            return cell
        case .post(let post):
            let reuseIdentifier = PostCollectionViewCell.reuseIdentifier
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                          for: indexPath) as! PostCollectionViewCell
            cell.post = post
//            cell.avatarId =  users?[indexPath.section].avatar
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let reuseIdentifier: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            reuseIdentifier = UserCollectionReusableView.reuseIdentifier
        case UICollectionView.elementKindSectionFooter:
            reuseIdentifier = UserFooterCollectionReusableView.reuseIdentifier
        default:
            fatalError("unexpected kind")
        }
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                    withReuseIdentifier: reuseIdentifier,
                                                                    for: indexPath)

        let card = cell as? UserCollectionReusableView
        card?.user = users?[indexPath.section]

        return cell
    }
}

extension UsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.items.removeAll()
        self.users?.removeAll()
        self.items = searchText.trimmingCharacters(in: .whitespaces).isEmpty ? self.data : []
        self.users = searchText.trimmingCharacters(in: .whitespaces).isEmpty ? self.usersEntity : []
        
        for (index, user) in self.usersEntity!.enumerated() {
            if (user.name!.range(of: searchText.trimmingCharacters(in: .whitespaces), options: .caseInsensitive, range: nil, locale: nil) != nil) {
                self.items.append(self.data[index])
                self.users?.append(self.usersEntity![index])
            } else if (user.email!.range(of: searchText.trimmingCharacters(in: .whitespaces), options: .caseInsensitive, range: nil, locale: nil) != nil) {
                self.items.append(self.data[index])
                self.users?.append(self.usersEntity![index])
            } else if (user.phone!.range(of: searchText.trimmingCharacters(in: .whitespaces), options: .caseInsensitive, range: nil, locale: nil) != nil) {
                self.items.append(self.data[index])
                self.users?.append(self.usersEntity![index])
            }
        }
        self.collectionView!.reloadData()
        if(self.items.isEmpty){
            emptyLabel?.text = "List is empty!\nNo results for \(searchText)"
            animationView!.play()
            emptyView?.isHidden = false
        } else {
            animationView!.stop()
            emptyView?.isHidden = true
        }
    }
}
