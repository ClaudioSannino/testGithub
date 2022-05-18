//
//  CellDequeuer.swift
//  tutorialtabella
//
//  Created by ESANNICDS on 21/04/22.
//

import Foundation
import UIKit

protocol CellDequeuer {
    func dequeueCell<T: UITableViewCell>(tableView: UITableView, indexPath: IndexPath) -> T
    func dequeueCell<T: UICollectionViewCell>(collectionView: UICollectionView, indexPath: IndexPath) -> T
    func dequeueReusableView<T: UICollectionReusableView>(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> T
}

extension CellDequeuer {
    func dequeueCell<T: UITableViewCell>(tableView: UITableView, indexPath: IndexPath) -> T {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(T.self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
            fatalError("\(className) must have the right identifer")
        }

        return cell
    }

    func dequeueComposableCell(tableView: UITableView, indexPath: IndexPath, cellClass: AnyClass) -> UITableViewCell {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(cellClass)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        return tableView.dequeueReusableCell(withIdentifier: className, for: indexPath)
    }

    func dequeueCell<T: UICollectionViewCell>(collectionView: UICollectionView, indexPath: IndexPath) -> T {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(T.self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T else {
            fatalError("\(className) must have the right identifer")
        }

        return cell
    }

    func dequeueReusableView<T: UICollectionReusableView>(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> T {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(T.self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: className, for: indexPath) as? T else {
            fatalError("\(className) must have the right identifer")
        }

        // sectionHeader.titleLabel.text = items[indexPath.section].title //self.readFrom(.recipe_ingredients)
        return reusableView
    }
}

