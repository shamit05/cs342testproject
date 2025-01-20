//
//  PrescribeMedicationView.swift
//  TestProject
//
//  Created by Shamit Surana on 1/20/25.
//
import SwiftUI
import SwiftUI

struct PrescribeMedicationView: View {
    @Binding var patient: Patient
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var dose = ""
    @State private var route: Route = .byMouth
    @State private var frequency = ""
    @State private var duration = ""
    @State private var errorMessage: String?
    
    var onSave: (Result<Void, Error>) -> Void

    var isFormValid: Bool {
        !name.isEmpty && !dose.isEmpty && !frequency.isEmpty && !duration.isEmpty
    }

    var body: some View {
        NavigationStack {
            medicationForm()
                .navigationTitle("Prescribe Medication")
                .toolbar {
                    saveButton()
                }
                .alert("Error", isPresented: Binding(
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

    @ViewBuilder
    private func medicationForm() -> some View {
        Form {
            Section(header: Text("Medication Details")) {
                medicationFields()
            }
        }
    }

    @ViewBuilder
    private func medicationFields() -> some View {
        TextField("Name", text: $name).accessibility(identifier: "medicationNameField")
        TextField("Dose (mg)", text: $dose).accessibility(identifier: "medicationDoseField")
            .keyboardType(.decimalPad)
        Picker("Route", selection: $route) {
            ForEach(Route.allCases, id: \.self) { route in
                Text(route.rawValue.capitalized).tag(route)
            }
        }
        TextField("Frequency (times/day)", text: $frequency)
            .keyboardType(.numberPad).accessibility(identifier: "medicationFrequencyField")
        TextField("Duration (days)", text: $duration)
            .keyboardType(.numberPad).accessibility(identifier: "medicationDurationField")
    }

    @ToolbarContentBuilder
    private func saveButton() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Save") {
                saveMedication()
            }
            .disabled(!isFormValid).accessibility(identifier: "medicationSaveButton")
        }
    }

    private func saveMedication() {
        guard let doseValue = Float(dose),
              let frequencyValue = Int(frequency),
              let durationValue = Int(duration) else {
            errorMessage = "Please enter valid numeric values."
            return
        }

        let medication = Medication(
            datePrescribed: Date(),
            name: name,
            dose: doseValue,
            route: route,
            frequency: frequencyValue,
            duration: durationValue
        )

        do {
            try addMedicationToPatient(medication)
            onSave(.success(()))
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
            onSave(.failure(error))
        }
    }

    private func addMedicationToPatient(_ medication: Medication) throws {
        if patient.medications.contains(where: { $0.name == medication.name && !$0.isCompleted }) {
            throw PatientError.duplicateMedicine
        }
        patient.medications.append(medication)
    }
}
