//
//  NewPatientForm.swift
//  TestProject
//
//  Created by Shamit Surana on 1/20/25.
//

import SwiftUI

struct NewPatientForm: View {
    @Environment(\.dismiss) var dismiss
    
    var onSave: (Result<Void, Error>) -> Void
    
    @Bindable var patientManager: PatientManager
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dateOfBirth = Date()
    @State private var height = ""
    @State private var weight = ""
    @State private var bloodType: BloodType?
    @State private var errorMessage: String?

    var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !height.isEmpty && !weight.isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Required Information")) {
                    TextField("First Name", text: $firstName).accessibilityIdentifier("firstNameField")
                    TextField("Last Name", text: $lastName).accessibilityIdentifier("lastNameField")
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date).accessibilityIdentifier("dateOfBirthPicker")
                    TextField("Height (cm)", text: $height)
                        .keyboardType(.numberPad).accessibilityIdentifier("heightField")
                    TextField("Weight (g)", text: $weight)
                        .keyboardType(.numberPad).accessibilityIdentifier("weightField")
                }

                Section(header: Text("Optional Information")) {
                    Picker("Blood Type", selection: $bloodType) {
                        Text("None").tag(BloodType?.none)
                        ForEach(BloodType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type as BloodType?)
                        }
                    }
                }
            }
            .accessibilityIdentifier("addNewPatientForm")
            .navigationTitle("Add New Patient")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        do {
                            let heightValue = Int(height) ?? 0
                            let weightValue = Int(weight) ?? 0
                            let newPatient = try Patient(
                                firstName: firstName,
                                lastName: lastName,
                                dateOfBirth: dateOfBirth,
                                height: heightValue,
                                weight: weightValue,
                                bloodType: bloodType
                            )
                            patientManager.patients.append(newPatient)
                            dismiss()
                        } catch {
                            errorMessage = error.localizedDescription
                        }
                    }
                    .disabled(!isFormValid)
                    .accessibilityIdentifier("savePatientButton")
                }
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
        }
    }
}
