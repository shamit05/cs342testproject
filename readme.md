# TestProject

This is a Swift-based project that demonstrates a foundational data model for an Electronic Medical Record system. It includes types and functionalities to manage patient data, medications, and other related features.

---

## Features

- **Custom Data Types**:
  - `Medication`: Represents prescribed medications, including details like dose, frequency, route, and duration.
  - `BloodType`: An enumeration for different blood types (e.g., A+, O-, AB+).
  - `Patient`: Represents a patient's profile with properties like medical record number, name, date of birth, height, weight, blood type, and a list of medications.

- **Methods**:
  - `Patient`:
    - Retrieve the full name and age of a patient.
    - Fetch a list of active medications (i.e., those not yet completed).
    - Add a new medication with duplicate prevention and error handling.
    - Determine compatible blood types for transfusion.

- **Swift Features Used**:
  - Classes, structs, enums, and computed properties.
  - Protocol conformance with `CustomStringConvertible`.
  - Initializers with default values.
  - Error handling with `throws`.
  - Unit testing using a custom test suite style.
