//
//  extensionUITableView.swift
//  tutorialtabella
//
//  Created by ESANNICDS on 21/04/22.
//

import Foundation
import UIKit

extension UITableView {
    func registerNibWithClassType<T: AnyObject>(type _: T.Type) {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(T.self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        register(UINib(nibName: className, bundle: Bundle.main), forCellReuseIdentifier: className)
    }
}
