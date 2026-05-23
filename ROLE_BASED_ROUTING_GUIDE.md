# Role-Based Dashboard Implementation

## نظرة عامة
تم تطبيق نظام توجيه مبني على الأدوار (Role-Based Routing) في التطبيق. عند تسجيل الدخول بنجاح، يتم توجيه المستخدم إلى لوحة تحكم مختلفة بناءً على دوره.

## الأدوار المدعومة
1. **System Admin** (`system_admin`)
   - المسار: `/manage-labs`
   - الصفحة الرئيسية: إدارة المختبرات (الموجودة مسبقاً)

2. **Lab Manager** (`lab_manager`)
   - المسار الرئيسي: `/lab-manager`
   - الصفحات: Dashboard، Tests، Patients، Staff، Reports

3. **Receptionist** (`receptionist`)
   - المسار الرئيسي: `/receptionist`
   - الصفحات: Dashboard، Appointments، Patients، Billing، Inquiries

## تدفق العمل

### 1. عملية تسجيل الدخول
```
الدخول → LoginScreen → LoginForm → LoginBloc
  ↓
تتحقق الاستجابة من الخادم من:
  - token: رمز المصادقة
  - user: بيانات المستخدم (الاسم، البريد، إلخ)
  - roles: قائمة الأدوار (النظام يأخذ الدور الأول)
  ↓
حفظ رمز المصادقة في AuthTokenStorage
تعيين دور المستخدم في UserRoleCubit
  ↓
التوجيه بناءً على الدور
```

### 2. نقاط التحكم الرئيسية

#### `lib/core/auth/user_role_cubit.dart`
- إدارة حالة الدور والمستخدم
- يحتفظ بـ:
  - `userRole`: الدور الحالي (system_admin | lab_manager | receptionist)
  - `userName`: اسم المستخدم
  - `userId`: معرف المستخدم
- Helper getters: `isSystemAdmin`, `isLabManager`, `isReceptionist`

#### `lib/features/admin/presentation/pages/login/widgets/login_form.dart`
جزء النجاح يقوم بـ:
1. حفظ رمز المصادقة
2. استخراج الدور من الاستجابة
3. تعيين الدور في UserRoleCubit
4. التوجيه بناءً على الدور

#### `lib/core/navigation/app_router.dart`
يحتوي على:
- `LoginRoute`: `/login` (للجميع)
- `MainShellRoute` + routes: `/manage-labs`, `/profile` (للإدارة)
- `LabManagerShellRoute` + routes: `/lab-manager/*`
- `ReceptionistShellRoute` + routes: `/receptionist/*`

#### Layouts
- `lib/core/navigation/main_layout.dart`: لوحة الإدارة العامة (موجودة مسبقاً)
- `lib/core/navigation/lab_manager_layout.dart`: تخطيط مدير المخبر
- `lib/core/navigation/receptionist_layout.dart`: تخطيط موظف الاستقبال

#### Drawers/SideNav
- `lib/shared/widgets/app_side_nav.dart`: للإدارة (موجود مسبقاً)
- `lib/shared/widgets/app_side_nav_lab_manager.dart`: لمدير المخبر
- `lib/shared/widgets/app_side_nav_receptionist.dart`: لموظف الاستقبال

#### Dashboard Pages
- `lib/features/lab_manager/presentation/pages/lab_manager_dashboard.dart`
  - عنوان ترحيب: "مرحبا [اسم المستخدم]"
  - بطاقات: الاختبارات القادمة، المرضى اليوم، التقارير المنتظرة، الموظفون

- `lib/features/receptionist/presentation/pages/receptionist_dashboard.dart`
  - عنوان ترحيب: "مرحبا [اسم المستخدم]"
  - بطاقات: المواعيد اليوم، المرضى المسجلون، الاستعلامات، الفواتير المعلقة

## الملفات المعدلة

### `lib/core/services/locator.dart`
```dart
// تم إضافة:
locator.registerSingleton<UserRoleCubit>(UserRoleCubit());
```

### `lib/features/admin/presentation/pages/login/widgets/login_form.dart`
تم تعديل جزء النجاح لـ:
1. استخراج الأدوار من الاستجابة
2. تعيينها في UserRoleCubit
3. توجيه مشروط بناءً على الدور

## مثال عملي

### سيناريو: تسجيل دخول كمدير مخبر

```
1. المستخدم يدخل بيانات تسجيل الدخول
2. LoginBloc يرسل الطلب للخادم
3. الخادم يرد بـ:
   {
     "data": {
       "token": "jwt-token-here",
       "user": { "id": 1, "name": "أحمد محمد", ... },
       "roles": ["lab_manager"]
     }
   }
4. login_form يستخرج:
   - role = "lab_manager"
   - userName = "أحمد محمد"
   - userId = 1
5. يحفظ الـ token ويعين الدور في UserRoleCubit
6. يوجه إلى: LabManagerDashboardRoute()
7. يتم عرض: LabManagerLayout + LabManagerDashboard
8. يرى المستخدم: "مرحبا أحمد محمد" + لوحة التحكم الخاصة به
```

## استخدام الدور في الواجهات

### في الـ Dashboard
```dart
BlocBuilder<UserRoleCubit, UserRoleState>(
  builder: (context, userRoleState) {
    final userName = userRoleState.userName ?? 'مستخدم';
    // استخدم البيانات في الواجهة
  },
)
```

### في الـ SideNav
```dart
if (context.read<UserRoleCubit>().isLabManager) {
  // عرض عناصر خاصة بمدير المخبر
}
```

## الخطوات التالية المقترحة

1. **ملء الصفحات الفارغة** (Tests, Patients, Staff, etc.)
   - حالياً بسيطة جداً

2. **إضافة صفحات الإعدادات** لكل دور

3. **اختبار تسجيل الخروج**
   - تأكد من حذف UserRoleCubit عند تسجيل الخروج

4. **إضافة الصور الشخصية** للمستخدمين

5. **تحديث الـ API** إذا لزم الأمر

## ملاحظات مهمة

- UserRoleCubit مسجل كـ **singleton** - يبقى طوال جلسة التطبيق
- سيتم حذف الدور عند تسجيل الخروج (يجب إضافة هذا في LogoutBloc)
- جميع الصفحات تدعم الاتجاه ثنائي الاتجاه (RTL/LTR)
- الواجهات قابلة للاستجابة للأجهزة المختلفة (Mobile/Desktop)
