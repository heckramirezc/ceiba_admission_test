//
//  PostCollectionViewCell.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 26/04/22.
//

import UIKit
import smooth_feed
import Lottie

class PostCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: PostCollectionViewCell.self)
        
    @IBOutlet weak var avatar: UIView!
    @IBOutlet weak var title: UILabel!
    var post: Post? {
        didSet {
            title.text = post?.title
            title.attributedText = attributedText(name: post!.title!, text: post!.body!)
        }
    }
    var avatarId: Int? {
        didSet {
            var avatarAnimationView:AnimationView
            
            switch avatarId {
                case 1:
                    avatarAnimationView = AnimationView(name: "avatarA")
                    break
                case 2:
                    avatarAnimationView = AnimationView(name: "avatarB")
                    break
                case 3:
                    avatarAnimationView = AnimationView(name: "avatarC")
                    break
                case 4:
                    avatarAnimationView = AnimationView(name: "avatarD")
                    break
                case 5:
                    avatarAnimationView = AnimationView(name: "avatarE")
                    break
                case 6:
                    avatarAnimationView = AnimationView(name: "avatarF")
                    break
                default:
                    avatarAnimationView = AnimationView(name: "avatarA")
                    break
            }
            avatarAnimationView.loopMode = .loop
            avatarAnimationView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            avatarAnimationView.contentMode = .scaleAspectFill
            
            for view in avatar.subviews {
                view.removeFromSuperview()
            }
            avatar.addSubview(avatarAnimationView)
            avatarAnimationView.play()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func attributedText(name: String, text: String) -> NSAttributedString {
        let font = UIFont(name: "Montserrat-Medium", size: 10)
        let string = "\(name)  \(text)"
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3
        let attributedString = NSMutableAttributedString(
            string: string,
            attributes: [.font: font as Any,
                         .foregroundColor: UIColor.black,
                         .paragraphStyle: style]
        )
        
        guard let argumentRange = string.range(of: name) else { return attributedString }
        let argumentFontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Montserrat-SemiBold", size: 12) as Any,
            .foregroundColor: UIColor.black
        ]
        attributedString.addAttributes(argumentFontAttributes, range: NSRange(argumentRange, in: string))
        return attributedString
    }
}

extension PostCollectionViewCell: SmoothFeedCollectionReusableView {

    func heightFitting(width: CGFloat) -> CGFloat {
        return systemLayoutSizeFitting(
            CGSize(width: width, height: 100),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        ).height
    }
}
