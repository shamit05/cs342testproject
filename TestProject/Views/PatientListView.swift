//
//  PatientView.swift
//  TestProject
//
//  Created by Shamit Surana on 1/20/25.
//

import SwiftUI

struct PatientListView: View {
    @State private var searchText = ""
    @Bindable var patientManager: PatientManager
    @State private var errors: [String] = [] // To track errors
    
    @State private var showNewPatient = false
    @State private var errorMessage: String?

    // Computed property to filter patients based on search text
    private var filteredPatients: [Binding<Patient>] {
        if searchText.isEmpty {
            return $patientManager.patients.filter { _ in true }
        } else {
            return $patientManager.patients.filter {
                $0.wrappedValue.firstName.localizedCaseInsensitiveContains(searchText) ||
                $0.wrappedValue.lastName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                patientSection()
                errorSection()
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Patients")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showNewPatient = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showNewPatient) {
                NewPatientForm(onSave: { result in
                    switch result {
                    case .success:
                        showNewPatient = false
                    case .failure(let error):
                        errorMessage = error.localizedDescription
                    }
                }, patientManager: patientManager)
            }
        }
    }

    @ViewBuilder
    private func patientSection() -> some View {
        Section(header: Text("Patients")) {
            ForEach(filteredPatients) { patient in
                NavigationLink(destination: PatientDetailView(patient: patient)) {
                    VStack(alignment: .leading) {
                        Text("\(patient.wrappedValue.firstName) \(patient.wrappedValue.lastName)")
                            .font(.headline)
                        Text("Age: \(patient.wrappedValue.age)")
                            .font(.subheadline)
                        Text("MRN: \(patient.wrappedValue.medicalRecordNumber)")
                            .font(.caption)
                    }
                }.accessibility(identifier: "patient-\(patient.wrappedValue.id)")
            }
        }
        .accessibility(identifier: "patientList")
    }

    @ViewBuilder
    private func errorSection() -> some View {
        if !errors.isEmpty {
            Section(header: Text("Errors")) {
                ForEach(errors, id: \.self) { error in
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
        }
    }
}
