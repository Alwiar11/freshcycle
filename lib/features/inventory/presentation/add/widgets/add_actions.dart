import 'package:flutter/material.dart';
import 'package:freshcycle/core/widgets/app_primary_button.dart';

class AddActions extends StatelessWidget {
  final VoidCallback onSubmit;

  const AddActions({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(label: 'Simpan Item', onPressed: onSubmit);
  }
}
