//
//  Viewable.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 25/04/22.
//

import Foundation
import UIKit

protocol Viewable: AnyObject {
    var presenter: Presenterable? { get set }
    
    func push(_ vc: UIViewController, animated: Bool)
    func present(_ vc: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func dismiss(animated: Bool)
    func dismiss(animated: Bool, _completion:  @escaping (() -> Void))
}

extension Viewable where Self: UIViewController {

   func push(_ vc: UIViewController, animated: Bool) {
       self.navigationController?.pushViewController(vc, animated: animated)
   }

   func present(_ vc: UIViewController, animated: Bool) {
       self.present(vc, animated: animated, completion: nil)
   }

   func pop(animated: Bool) {
       self.navigationController?.popViewController(animated: animated)
   }

   func dismiss(animated: Bool) {
       self.dismiss(animated: animated, completion: nil)
   }

   func dismiss(animated: Bool, _completion: @escaping (() -> Void)) {
       self.dismiss(animated: animated, completion: _completion)
   }

   var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .portrait
   }
   var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
       return .portrait
   }
}