//
//  quranNumberData.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 15/07/23.
//

import Foundation

struct JuzDataModel: Hashable {
    var juzNumber: Int
    var totalPages: Int
    var pageStartNumber: Int
    var pageEndNumber: Int
}

struct PageData: Hashable {
    var pageNumber: Int
    var pageOrder: Int
}

class JuzData: ObservableObject {
    @Published var juzData: [JuzDataModel]
    init() {
        self.juzData = [JuzDataModel]()
        var juzNumber = 1
        var totalPages = 21
        var pageStartNumber = 1
        var pageEndNumber = pageStartNumber + totalPages - 1
        for _ in 0..<29 {
            juzData.append(
                JuzDataModel(
                    juzNumber: juzNumber,
                    totalPages: totalPages,
                    pageStartNumber: pageStartNumber,
                    pageEndNumber: pageEndNumber
                )
            )
            juzNumber += 1
            pageStartNumber += totalPages
            pageEndNumber = pageStartNumber + totalPages - 1
            totalPages = 20
        }
        juzData.append(
            JuzDataModel(
                juzNumber: juzNumber,
                totalPages: 23,
                pageStartNumber: pageStartNumber,
                pageEndNumber: 604
            )
        )
    }
    func getPageDetailNumber(selectedJuz: Int) -> [PageData] {
        guard let juzData = self.juzData.first(where: { $0.juzNumber == selectedJuz }) else { return [] }
        return (1...juzData.totalPages).map { page in
            PageData(pageNumber: page, pageOrder: (page + juzData.pageStartNumber - 1))
        }
    }
    func isLastPageInJuz(juzNumber: Int, pageNumber: Int) -> Bool {
        if let juz = juzData.first(where: { $0.juzNumber == juzNumber }) {
            return juz.totalPages == pageNumber
        }
        return false
    }
}
