//
//  ExportOptionView.swift
//  Noon
//
//  Created by Bambang Ardiyansyah on 03/04/24.
//

import SwiftUI

struct ExportOptionView: View {
    @State private var urls: [URL] = []
    @State private var startDate: Date = Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()
    @State private var dueDate: Date = Date()
    
    @Binding var displayExportOption: Bool
    @Binding var fileUrl: URL?
    var students: [StudentEntity]
    
    init(displayExportOption: Binding<Bool>, fileUrl: Binding<URL?>, students: [StudentEntity]) {
        self._displayExportOption = displayExportOption
        self._fileUrl = fileUrl
        self.students = students
        self._urls = State(initialValue: FileManagerFinder.loadFiles())
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: .zero) {
                List {
                    Section {
                        if urls.isEmpty {
                            Text("No document")
                                .font(.footnote)
                                .italic()
                        } else {
                            ForEach(urls.sorted { $0.lastPathComponent > $1.lastPathComponent }, id: \.self) { urlNames in
                                VStack {
                                    HStack(alignment: .center) {
                                        Image(systemName: "doc.text")
                                            .font(.title2)
                                        Text(urlNames.lastPathComponent)
                                            .font(.headline)
                                        Spacer()
                                        Menu {
                                            Button {
                                                displayExportOption = false
                                                fileUrl = urlNames
                                            } label: {
                                                Label("Share",systemImage: "square.and.arrow.up")
                                                
                                            }
                                            Button {
                                                FileManagerFinder.deleteFile(at: urlNames)
                                                if let index = urls.firstIndex(of: urlNames) {
                                                    self.urls.remove(at: index)
                                                }
                                            } label: {
                                                Label("Delete", systemImage: "trash.fill")
                                            }
                                            .tint(Color.red)
                                            
                                        } label: {
                                            Image(systemName: "ellipsis.circle")
                                        }
                                    }
                                }
                            }
                        }
                    } header: {
                            Text("Exported Files")
                    }
                }
                .listStyle(.insetGrouped)
                Spacer()
                VStack {
                    Text("Select Period")
                        .font(.headline)
                    DatePicker(selection: $startDate, displayedComponents: .date) {
                        Label("Start From", systemImage: "calendar")
                            .font(.subheadline)
                            .italic()
                    }
                        .datePickerStyle(.automatic)
                    DatePicker(selection: $dueDate, displayedComponents: .date) {
                        Label("Until", systemImage: "calendar")
                            .font(.subheadline)
                            .italic()
                    }
                        .datePickerStyle(.automatic)
                    Button {
                        ExportUtils.exportCSV(students: students, startDate: startDate, dueDate: dueDate) { res in
                            switch res {
                            case .success(let url):
                                fileUrl = url
                            default:
                                break
                            }
                        }
                        displayExportOption.toggle()
                    } label: {
                        Text("Export to CSV")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .tint(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                    )
                    .padding(.vertical)
//                    Button {
//                        displayExportOption.toggle()
//                    } label: {
//                        Text("Export to PDF")
//                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.1), radius: 10, y: -10)
                        .offset(y: -20)
                )
                .ignoresSafeArea()
            }
            .navigationTitle("Export Data")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
