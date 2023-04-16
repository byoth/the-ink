//
//  Collection+Similarity.swift
//  wwdc23-ssc
//
//  Created by byo on 2023/04/16.
//

import Foundation

extension Collection where Element: Equatable {
    func getSimilarity(_ comparedArray: [Element]) -> CGFloat {
        guard count == comparedArray.count else {
            return 0
        }
        let matchingCount = zip(self, comparedArray)
            .reduce(0) { $0 + ($1.0 == $1.1 ? 1 : 0) }
        return CGFloat(matchingCount) / CGFloat(count)
    }
}
