class FieldConfig {
  final String key;
  final String type;
  final String label;
  final String placeholder;
  final int renderOrder;

  FieldConfig({
    required this.key,
    required this.type,
    required this.label,
    required this.placeholder,
    required this.renderOrder,
  });
}

final List<FieldConfig> searchConfig = [
  FieldConfig(
    key: 'firstName',
    type: 'text',
    label: 'First Name',
    placeholder: 'Enter first name',
    renderOrder: 1,
  ),
  FieldConfig(
    key: 'lastName',
    type: 'text',
    label: 'Last Name',
    placeholder: 'Enter last name',
    renderOrder: 2,
  ),
  FieldConfig(
    key: 'dateOfBirth',
    type: 'date',
    label: 'Date of Birth',
    placeholder: 'Select date',
    renderOrder: 3,
  ),
];
