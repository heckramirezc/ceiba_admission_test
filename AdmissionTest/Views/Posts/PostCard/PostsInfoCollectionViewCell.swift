//
//  PostsInfoCollectionViewCell.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 26/04/22.
//

import UIKit

class PostsInfoCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: PostsInfoCollectionViewCell.self)
        
    @IBOutlet weak var posts: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


