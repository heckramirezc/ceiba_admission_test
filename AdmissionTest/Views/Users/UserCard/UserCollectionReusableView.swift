//
//  UserCollectionReusableView.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 26/04/22.
//

import UIKit
import Lottie

class UserCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = String(describing: UserCollectionReusableView.self)
    
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var scrollPostsView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    var user: User? {
        didSet {
            self.name.text = user?.name
            self.email.text = user?.email
            self.phone.text = user?.phone
            var avatarAnimationView:AnimationView
            
            switch user?.avatar {
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
            avatarAnimationView.frame = CGRect(x: 0, y: 0, width: 95, height: 95)
            avatarAnimationView.contentMode = .scaleAspectFill
            
            for view in avatarView.subviews {
                view.removeFromSuperview()
            }
            avatarView.addSubview(avatarAnimationView)
            avatarAnimationView.play()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 85
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        let animationView = AnimationView(name: "scrolldown")
        animationView.loopMode = .loop
        animationView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        animationView.contentMode = .scaleAspectFill
        
        scrollPostsView.addSubview(animationView)
        animationView.play()

    }
    
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
