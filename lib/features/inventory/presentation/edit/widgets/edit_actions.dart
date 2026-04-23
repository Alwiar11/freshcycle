import 'package:flutter/material.dart';
import 'package:freshcycle/core/widgets/app_primary_button.dart';

class EditActions extends StatelessWidget {
  final VoidCallback onSave;

  const EditActions({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(label: 'Simpan Perubahan', onPressed: onSave);
  }
}
