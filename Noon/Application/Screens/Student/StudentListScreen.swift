//
//  StudentList.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 01/07/23.
//
import SwiftUI
import UIKit

struct StudentListScreen: View {
    @EnvironmentObject var studentVM: StudentViewModel
    @State private var alertDeleteStudent: Bool = false
    @State private var displayExportOption: Bool = false
    @State private var adsOrSubscribe: Bool = false
    @State private var watchAds: Bool = false
    @State private var studentToDelete: StudentEntity?
    @State private var fileURL: URL? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                if studentVM.students.isEmpty {
                    setupStudentSection
                } else {
                    List {
                        ForEach(studentVM.students.sorted { $0.name < $1.name}) { student in
                            StudentListRowView(student: student) {
                                studentToDelete = student
                                alertDeleteStudent.toggle()
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Students")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("\(studentVM.students.count)")
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        studentVM.presentNewStudentSheet = true
                    } label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                    }
                    Button {
                            displayExportOption.toggle()
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            .sheet(isPresented: $studentVM.presentNewStudentSheet) {
                StudentEditorScreen()
            }
            .sheet(
                isPresented: $displayExportOption,
                onDismiss: {
                    if let url = fileURL {
                        FileManagerFinder.shareFile(fileURL: url)
                        fileURL = nil
                    }
                }
            ) {
                    ExportOptionView(
                        displayExportOption: $displayExportOption,
                        fileUrl: $fileURL,
                        students: studentVM.students
                    )
            }
            .alert("Delete", isPresented: $alertDeleteStudent) {
                Button(role: .destructive) {
                    if let student = studentToDelete {
                        studentVM.deleteStudent(id: student.id) { result in
                            // Handle delete completion if needed
                        }
                    }
                    studentToDelete = nil
                } label: {
                    Text("Delete")
                }
                Button(role: .cancel) {
                    studentToDelete = nil
                } label: {
                    Text("Cancel")
                }
            } message: {
                    Text("All data related to \(studentToDelete?.name ?? "") will be permanently deleted. Are you sure you want to proceed?")
            }
        }
    }
    
//    private var mainView: some View {
//        
//    }
    private var setupStudentSection: some View {
        Section {
            Text("You currently haven't added any students yet. Please add students to enjoy the mutabaah feature.")
                .font(.headline)
                .padding()
            Button {
                studentVM.presentNewStudentSheet = true
            } label: {
                Text("Add new student")
            }
        }
    }
}
