//
//  PatientDetailView.swift
//  TestProject
//
//  Created by Shamit Surana on 1/20/25.
//

import SwiftUI

struct PatientDetailView: View {
    @Binding var patient: Patient
    @State private var showPrescribeMedication = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            List {
                // Patient details section
                Section(header: Text("Patient Details")) {
                    Text("Name: \(patient.firstName) \(patient.lastName)")
                    Text("Age: \(patient.age) years")
                    Text("Medical Record Number: \(patient.medicalRecordNumber)")
                    Text("Height: \(patient.height) cm")
                    Text("Weight: \(patient.weight) g")
                    Text("Blood Type: \(patient.bloodType?.rawValue ?? "Unknown")")
                }

                // Active medications section
                Section(header: Text("Active Medications")) {
                    if patient.activeMedications().isEmpty {
                        Text("No active medications")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(patient.activeMedications(), id: \.name) { medication in
                            VStack(alignment: .leading) {
                                Text(medication.name)
                                    .font(.headline)
                                Text(medication.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("\(patient.firstName) \(patient.lastName)")
            .toolbar {
                // Button to prescribe medication
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showPrescribeMedication = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibility(identifier: "prescribeMedicationButton")
                }
            }
            .sheet(isPresented: $showPrescribeMedication) {
                PrescribeMedicationView(patient: $patient, onSave: { result in
                    switch result {
                        case .success:
                            showPrescribeMedication = false
                        case .failure(let error):
                            errorMessage = error.localizedDescription
                    }
                })
            }
            .alert("Error", isPresented: Binding<Bool>(
                get: { errorMessage != nil },
                set: { if !$0 { errorMessage = nil } }
            )) {
                Button("OK", role: .cancel) { }
            } message: {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                }
            }
            .accessibility(identifier: "patientDetailView")
        }
    }
}
