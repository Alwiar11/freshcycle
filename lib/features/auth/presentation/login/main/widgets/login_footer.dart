import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Belum punya akun? ', style: tt.bodyMedium),
        InkWell(
          onTap: () {
            context.go('/register');
          }, // TODO: navigate to register
          child: Text(
            'Daftar sekarang',
            style: tt.labelMedium?.copyWith(color: cs.primary),
          ),
        ),
      ],
    );
  }
}
