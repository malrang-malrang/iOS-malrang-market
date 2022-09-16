//
//  SystemImage.swift
//  ios-malrang-market
//
//  Created by 김동욱 on 2022/09/16.
//

import UIKit

enum SystemImage {
    enum Atribute {
        static let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .heavy)
    }

    static let back = UIImage(
        systemName: "arrowshape.turn.up.backward.fill",
        withConfiguration: Atribute.configuration
    )

    static let more = UIImage(
        systemName: "ellipsis",
        withConfiguration: Atribute.configuration
    )

    static let check = UIImage(
        systemName: "checkmark.diamond.fill",
        withConfiguration: Atribute.configuration
    )

    static let edit = UIImage(
        systemName: "square.and.pencil",
        withConfiguration: Atribute.configuration
    )

    static let share = UIImage(
        systemName: "square.and.arrow.up",
        withConfiguration: Atribute.configuration
    )

    static let trash = UIImage(systemName: "trash")
}
