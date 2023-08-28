//
//  ZiyadahViewModel.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 10/08/23.
//

import Foundation

class ZiyadahViewModel: ObservableObject {
    @Published var ziyadah: [ZiyadahEntity] = []
    @Published var juz: Int = 1
    @Published var page: Int = 1
    @Published var memorizeValue: String = MemorizeValue.aValue.rawValue
    @Published var recitationValue: String = MemorizeValue.aValue.rawValue
    @Published var createdAt: Date = Date()
    @Published var alertContent: AlertContent?
    private let ziyadahService = ZiyadahService(ziyadahRepository: ZiyadahCDA())
    let juzData = JuzData()
    var student: StudentEntity
    init(student: StudentEntity) {
        self.student = student
        self.ziyadah = getZiyadah()
        setLatestMemorize()
    }
    func setLatestPage() {
        let latestPage = student.ziyadahData
            .filter { $0.juz == self.juz }
            .sorted { $0.page > $1.page }
            .first?.page ?? 0
        var isLatestPage: Bool {
            juzData.isLastPageInJuz(juzNumber: self.juz, pageNumber: latestPage)
        }
        if isLatestPage {
            page = latestPage
        } else {
            page = latestPage + 1
        }
    }
    func setLatestMemorize() {
        guard let latestMemorize = student.ziyadahData.max(by: { $0.createdAt < $1.createdAt }) else { return }
        var isLatestPage: Bool {
            juzData.isLastPageInJuz(juzNumber: latestMemorize.juz, pageNumber: latestMemorize.page)
        }
        switch (isLatestPage, latestMemorize.juz) {
        case (true, _) where latestMemorize.juz != 30:
            self.juz = latestMemorize.juz + 1
            self.page = 1
        case (true, 30):
            self.juz = latestMemorize.juz
            self.page = latestMemorize.page
        default:
            self.juz = latestMemorize.juz
            self.page = latestMemorize.page + 1
        }
    }
    func getZiyadah() -> [ZiyadahEntity] {
        return ziyadahService.getZiyadah()
    }
    func createZiyadah(studentId: UUID, completion: @escaping (Bool) -> Void) {
        let newZiyadah = ZiyadahEntity(
            juz: juz,
            page: page,
            memorizeValue: memorizeValue,
            recitationValue: recitationValue,
            createdAt: createdAt
        )
        
        let isDuplicate = checkDuplicateZiyadah(juz: juz, page: page)
        let isLatestPage = juzData.isLastPageInJuz(juzNumber: juz, pageNumber: page)
        
        if isDuplicate {
            alertContent = AlertContent(
                title: "Failed",
                message: isLatestPage ? "Juz \(juz) has already been completed." : "Juz \(juz) Page \(page) has already been filled out."
            )
            completion(false)
        } else {
            if isLatestPage {
                StudentViewModel.updateCompletedZiyadah(id: student.id, juz: juz) { result in
                    switch result {
                    case .success:
                        self.alertContent = AlertContent(
                            title: "Success",
                            message: "Juz \(self.juz) has been marked as completed. Juz \(self.juz) Page \(self.page) saved successfully."
                        )
                    case .failure(let error):
                        self.alertContent = AlertContent(
                            title: "Failed",
                            message: "\(error)"
                        )
                    }
                    
                }
            }
            ziyadahService.createZiyadah(studentId: studentId, ziyadah: newZiyadah) { success in
                if success {
                    self.alertContent = AlertContent(
                        title: "Success",
                        message: "Juz \(self.juz) Page \(self.page) saved successfully."
                    )
                    completion(success)
                }
            }
        }
    }
    private func checkDuplicateZiyadah(juz: Int, page: Int) -> Bool {
        let duplicates = student.ziyadahData
            .filter { $0.juz == juz && $0.page == page }
        if duplicates.isEmpty {
            return false
        }
        return true
    }
}

extension ZiyadahViewModel {
    static func deleteZiyadah(id: UUID, ziyadahData: [ZiyadahEntity]) {
        guard let indexToDelete = ziyadahData.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        let pageToDelete = ziyadahData[indexToDelete].page
        let juzToDelete = ziyadahData[indexToDelete].juz
        
        let dataToDelete = ziyadahData.filter { $0.page >= pageToDelete && $0.juz == juzToDelete }
        
        let ziyadahService = ZiyadahService(ziyadahRepository: ZiyadahCDA())
        for ziyadah in dataToDelete {
            ziyadahService.deleteZiyadah(id: ziyadah.id) { result in
                print(result)
            }
        }
    }
}

struct AlertContent: Identifiable {
    var id = UUID()
    var title: String
    var message: String
}
