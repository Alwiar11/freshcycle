import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sudah punya akun? ', style: tt.bodyMedium),
        InkWell(
          onTap: () {
            context.go('/login');
          }, // TODO: navigate to login
          child: Text(
            'Masuk',
            style: tt.labelMedium?.copyWith(color: cs.primary),
          ),
        ),
      ],
    );
  }
}
