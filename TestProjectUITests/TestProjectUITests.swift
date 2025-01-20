//
//  TestProjectUITests.swift
//  TestProjectUITests
//
//  Created by Shamit Surana on 1/9/25.
//
import XCTest

final class TestProjectUITests: XCTestCase {


    func testPatientListDisplaysCorrectly() {
        let app = XCUIApplication()
        app.launch()
        
        let patientList = app.staticTexts["patientList"]
        XCTAssertTrue(patientList.exists, "The patient list should be visible.")
        
        let firstPatient = app.staticTexts["John Doe"]
        XCTAssertTrue(firstPatient.exists, "Patient 'John Doe' should be listed.")
    }

    func testSearchFiltersPatients() {
        let app = XCUIApplication()
        app.launch()
        
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Doe")

        let filteredPatient = app.staticTexts["John Doe"]
        XCTAssertTrue(filteredPatient.exists, "The search results should include 'John Doe'.")
    }

    func testNavigateToPatientDetailView() {
        let app = XCUIApplication()
        app.launch()
        
        let firstPatient = app.staticTexts["John Doe"]
        firstPatient.tap()

        let detailViewTitle = app.collectionViews["patientDetailView"]
        XCTAssertTrue(detailViewTitle.exists, "Navigating to patient detail view should display the 'Patient Details' title.")
    }

    func testAddNewPatient() {
        let app = XCUIApplication()
        app.launch()
        
        let addButton = app.buttons["plus"]
        addButton.tap()


        // Fill in the new patient form
        let firstNameField = app.textFields["firstNameField"]
        firstNameField.tap()
        firstNameField.typeText("George")

        let lastNameField = app.textFields["lastNameField"]
        lastNameField.tap()
        lastNameField.typeText("Smith")
        

        let heightField = app.textFields["heightField"]
        heightField.tap()
        heightField.typeText("170")

        let weightField = app.textFields["weightField"]
        weightField.tap()
        weightField.typeText("60000")

        let saveButton = app.buttons["savePatientButton"]
        saveButton.tap()

        XCTAssertTrue(app.staticTexts["George Smith"].exists, "The new patient 'George Smith' should be listed.")
    }
    
    func testAddMedication() {
        let app = XCUIApplication()
        app.launch()

        // Navigate to Patient Detail View
        let patient = app.staticTexts["John Doe"]
        XCTAssertTrue(patient.waitForExistence(timeout: 5), "Patient 'John Doe' should exist.")
        patient.tap()

        // Open Prescribe Medication View
        let prescribeButton = app.buttons["prescribeMedicationButton"]
        XCTAssertTrue(prescribeButton.waitForExistence(timeout: 5), "The 'Prescribe Medication' button should exist.")
        prescribeButton.tap()


        // Interact with TextFields
        let nameField = app.textFields["medicationNameField"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 5), "The 'Medication Name' field should exist.")
        nameField.tap()
        nameField.typeText("Ibuprofen")

        let doseField = app.textFields["medicationDoseField"]
        XCTAssertTrue(doseField.waitForExistence(timeout: 5), "The 'Dose' field should exist.")
        doseField.tap()
        doseField.typeText("200")

        let frequencyField = app.textFields["medicationFrequencyField"]
        frequencyField.tap() // Ensure the field has focus
        frequencyField.typeText("3")

        let durationField = app.textFields["medicationDurationField"]
        durationField.tap() // Ensure the field has focus
        durationField.typeText("7")

        // Save the medication
        let saveButton = app.buttons["medicationSaveButton"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 5), "The 'Save' button should exist.")
        saveButton.tap()

        // Verify medication appears in the list
        let medicationName = app.staticTexts["Ibuprofen"]
        XCTAssertTrue(medicationName.waitForExistence(timeout: 5), "The new medication 'Ibuprofen' should appear in the patient's medication list.")
    }


}
