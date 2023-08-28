//
//  StudentOverviewViewModel.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 18/08/23.
//

import Foundation
import SwiftUI
import Charts

class StudentOverviewViewModel: ObservableObject {
    @Published var ziyadahChartData: [ChartData]
    @Published var attendanceChartData: [ChartData]
    @Published var presentEditStudentSheet: Bool = false
    var student: StudentEntity?
    
    init(student: StudentEntity? = nil) {
        self.student = student
        ziyadahChartData = StudentViewModel.createChartData(data: student?.ziyadahData ?? [])
        attendanceChartData = StudentViewModel.createChartData(data: student?.attendanceData ?? [])
    }
}

