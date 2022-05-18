//
//  extensionUIVIew.swift
//  tutorialtabella
//
//  Created by ESANNICDS on 21/04/22.
//

import Foundation
import UIKit

public extension UIView {
    func viewFromNibForClass(bundle: Bundle? = nil) -> UIView {
    
        var localBundle = Bundle(for: type(of: self))
        if let bundle = bundle {
            localBundle = bundle
        }

        let nib = UINib(nibName: String(describing: type(of: self)), bundle: localBundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Nib name must be the same of the file owner: \(String(describing: type(of: self)))")
        }
        
    
        view.backgroundColor = .clear
        return view
    }
}

extension UIView {
    /// addSubiew to each side with zero margin
    func addSubviewFull(childView: UIView) {
        childView.frame = bounds
        childView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(childView)

        addConstraints([
            childView.topAnchor.constraint(equalTo: topAnchor),
            childView.rightAnchor.constraint(equalTo: rightAnchor),
            childView.bottomAnchor.constraint(equalTo: bottomAnchor),
            childView.leftAnchor.constraint(equalTo: leftAnchor),
            childView.widthAnchor.constraint(equalTo: widthAnchor),
        ])

        layoutIfNeeded()
    }
}
