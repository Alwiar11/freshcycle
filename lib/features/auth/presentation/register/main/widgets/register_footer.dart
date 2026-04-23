import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sudah punya akun? ', style: theme.textTheme.bodyMedium),
        InkWell(
          onTap: () {
            context.go('/login');
          }, // TODO: navigate to login
          child: Text(
            'Masuk',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
