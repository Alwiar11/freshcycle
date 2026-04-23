import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Belum punya akun? ', style: theme.textTheme.bodyMedium),
        InkWell(
          onTap: () {
            context.go('/register');
          }, // TODO: navigate to register
          child: Text(
            'Daftar sekarang',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
