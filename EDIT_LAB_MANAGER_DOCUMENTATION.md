# Edit Lab Manager Feature - Implementation Complete ✅

## 📋 Overview
Feature كامل لتعديل معلومات المختبرات بطريقة آمنة وفعّالة مع دعم التحديثات الجزئية (Partial Updates).

**API Endpoint:** `POST /api/admin/labs/{labId}`  
**Response:** `BaseResponseModel` (success) or `AppFailure` (error with field-level details)

---

## 📁 Files Created (11 Total)

### Domain Layer
| File | Purpose |
|------|---------|
| `edit_lab_manager_entity.dart` | Entity with optional fields for partial updates |
| `edit_lab_manager_repository.dart` | Abstract repository interface |
| `edit_lab_manager_use_case.dart` | Business logic use case |

### Data Layer
| File | Purpose |
|------|---------|
| `edit_lab_manager_remote_data_source.dart` | HTTP client (Dio) for API calls |
| `edit_lab_manager_repository_impl.dart` | Repository implementation with error mapping |

### Presentation Layer
| File | Purpose |
|------|---------|
| `edit_lab_manager_cubit_state.dart` | Form state management (local validation) |
| `edit_lab_manager_cubit.dart` | Form state mutations & initialization |
| `edit_lab_manager_bloc_event.dart` | Remote operation events |
| `edit_lab_manager_bloc_state.dart` | Remote operation state |
| `edit_lab_manager_bloc.dart` | Remote API handler |
| `edit_info_lab_dialog.dart` | **UPDATED** - Full UI with Bloc/Cubit integration |

---

## 🚀 Usage

### 1. Opening the Dialog
```dart
// From table actions or a button in manage_labs_header
final result = await showDialog<bool>(
  context: context,
  barrierDismissible: false,
  builder: (_) => EditInfoLabDialog(
    labId: labEntity.id,           // Required
    labName: labEntity.name,       // Optional - pre-fills form
    managerName: labEntity.manager?.name,
    email: labEntity.manager?.email,
    phone: labEntity.phone,
    location: labEntity.location,  // LocationEntity optional
  ),
);

if (result == true) {
  // Success - refresh list
  context.read<ManageLabsBloc>().add(ManageLabsFetchRequested(...));
} else if (result == false) {
  // Failure - error was shown in dialog's snackbar
}
```

### 2. Form Behavior
- **Pre-filled Data:** Dialog initializes with existing lab data
- **Optional Fields:** User can modify 0, 1, or multiple fields
- **Validation:** Requires at least ONE field to be changed
- **Location Picker:** Click on location field to open map picker
- **Password Toggle:** Eye icon to show/hide password

### 3. Submission Process
```
1. User modifies fields → Cubit state updates
2. User clicks "Save Changes"
3. Cubit validates: at least ONE field changed + formats are correct
4. If valid: Bloc submits to API with only non-empty fields
5. API response handling:
   - Success: Close dialog (true) → Caller refreshes list
   - Failure: Extract field errors → Show detailed snackbar → Close dialog (false)
```

---

## 📊 Architecture

### State Management Stack
```
UI (TextField, Location Picker, Submit Button)
  ↓
EditLabManagerCubit (Form State)
  ├─ Manages: labName, managerName, email, phone, password, location
  ├─ Validates: Optional fields (only if user entered something)
  ├─ Methods: updateLabName(), updateEmail(), initializeWithData(), etc.
  └─ Emits: EditLabManagerCubitState with all field values + errors

EditLabManagerBloc (Remote State)
  ├─ Events: EditLabManagerSubmitted, EditLabManagerReset
  ├─ States: loading, success, failure
  └─ Uses: EditLabManagerUseCase to call repository

EditLabManagerUseCase
  └─ Repository.call(EditLabManagerEntity) → Either<AppFailure, BaseResponseModel>

EditLabManagerRepository (Impl)
  ├─ Calls: EditLabManagerRemoteDataSource
  ├─ Error Mapping: AppException → AppFailure (with field errors)
  └─ Returns: Either<AppFailure, BaseResponseModel>
```

---

## ✨ Key Features

### Partial Updates
```dart
// Only modified fields are sent in request
{
  "email": "newemail@lab.com",  // Modified
  "phone": "09XXXXXXXX",         // Modified
  // Other unchanged fields NOT included
}
```

### Field Error Extraction
```dart
// Server returns: { "email": ["Email already exists"], "phone": ["Invalid format"] }
// Dialog extracts and shows:
// ❌ Error
// Email already exists
// Invalid format
```

### Pre-filled Form
```dart
// Dialog constructor receives existing data
EditInfoLabDialog(
  labId: 9,
  labName: "Modern Lab",              // ← Displays in TextField
  managerName: "Ahmed Hassan",        // ← Displays in TextField
  email: "manager@lab.com",           // ← Displays in TextField
  ...
)
```

---

## 🔄 Flow Diagram

```
EditInfoLabDialog (Constructor with lab data)
        ↓
MultiBlocProvider Setup
├─ EditLabManagerCubit.initializeWithData(...)
├─ EditLabManagerBloc
└─ SearchLocationBloc
        ↓
Form Display (Pre-filled fields)
        ↓
User Modifies Fields
  ├─ Cubit.updateLabName() → emit new state
  ├─ Cubit.updateEmail() → emit new state
  └─ ...
        ↓
User Clicks "Save Changes"
        ↓
Cubit.validateInputs()
  ├─ Check: At least ONE field changed?
  ├─ Check: Field formats valid? (email contains @, password 6+, etc.)
  └─ Emit state with errors OR success
        ↓
If Valid: Bloc.add(EditLabManagerSubmitted(params))
        ↓
API Call: POST /admin/labs/{labId}
├─ Headers: Authorization: Bearer {token}
├─ Body: { only non-empty fields }
        ↓
Success Response (status: true)
  ├─ Emit success state
  ├─ BlocListener: Navigator.pop(true)
  └─ Caller: show snackbar + refresh list
        ↓
Failure Response (status: false)
  ├─ AppErrorMapper extracts: AppFailure with errors map
  ├─ Emit failure state with AppFailure
  ├─ BlocListener: Navigator.pop(false)
  └─ Show field errors in snackbar
```

---

## 🔌 Integration Checklist

- [x] Domain layer files created
- [x] Data layer files created
- [x] Presentation layer files created
- [x] Dialog UI updated with Bloc/Cubit
- [x] Pre-filled form implementation
- [x] Error handling (field-level extraction)
- [x] Location picker integration
- [x] Password visibility toggle
- [x] Form validation (optional fields)
- [x] Success/Failure snackbar flow
- [ ] **TODO:** Add dialog open trigger in manage_labs_header (edit button)
- [ ] **TODO:** Add dialog open trigger in table (edit icon per row)
- [ ] **TODO:** Add localization strings (if needed)

---

## 🧪 Testing Checklist

- [ ] Open dialog with valid lab data → fields pre-populated
- [ ] Modify one field only → save successfully
- [ ] Modify multiple fields → save successfully
- [ ] Change location via map picker → location saved
- [ ] Type invalid email → show validation error
- [ ] Submit with empty all fields → show validation error
- [ ] Server validation error (400) → show field errors
- [ ] Server auth error (401) → show generic error
- [ ] Close dialog before submit → reset state properly
- [ ] Successful submit → close dialog, show snackbar, refresh list

---

## 📝 Example Integration in manage_labs_header.dart

```dart
// Add button to open edit dialog for each lab
InkWell(
  onTap: () async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => EditInfoLabDialog(
        labId: lab.id,
        labName: lab.name,
        managerName: lab.manager?.name,
        email: lab.manager?.email,
        phone: lab.phone,
        location: lab.location,
      ),
    );

    if (!context.mounted) return;

    if (result == true) {
      // Success - show snackbar + refresh
      final successSnackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'مرحباً',
          message: 'تم تحديث معلومات المختبر بنجاح',
          contentType: ContentType.success,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(successSnackBar);

      Future.delayed(const Duration(milliseconds: 500), () {
        if (context.mounted) {
          context.read<ManageLabsBloc>().add(
            ManageLabsFetchRequested(
              tab: context.read<ManageLabsCubit>().state.selectedTab,
              page: 1,
              perPage: ManageLabsCubit.pageSize,
            ),
          );
        }
      });
    }
  },
  child: const Icon(Icons.edit),
)
```

---

## ⚠️ Important Notes

1. **Optional Fields Only:** Unlike Create, all fields are optional
2. **Partial Updates:** Only non-empty fields sent to server
3. **At Least One:** Validation requires minimum one field to be changed
4. **Location:** Can be null or updated via map picker
5. **Password:** Optional - only send if user wants to change it
6. **Error Extraction:** Field errors automatically extracted from `AppFailure.errors` map

---

## 🎯 Status: ✅ Complete
All 11 files created and verified with **ZERO compilation errors**.  
Ready for integration and testing.
