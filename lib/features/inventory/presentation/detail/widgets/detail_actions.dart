import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/core/widgets/app_action_button.dart';
import 'package:freshcycle/features/inventory/domain/models/inventory_item.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DetailActions extends StatelessWidget {
  const DetailActions({super.key, required this.item});

  final InventoryItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: AppActionButton(
            label: 'Hapus',
            icon: Icons.delete_outline_rounded,
            foregroundColor: Theme.of(context).colorScheme.error,
            onPressed: () {
              context.pop();
              _showDeleteConfirmation(context);
            },
          ),
        ),
        Gap(12.w),
        Expanded(
          flex: 3,
          child: AppActionButton(
            label: 'Ubah',
            icon: Icons.edit_outlined,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primary,
            borderColor: Theme.of(context).colorScheme.primary,
            borderWidth: 1.5,
            onPressed: () => context.push('/inventory/edit/', extra: item),
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'Hapus ${item.name}?',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: 18.sp),
        ),
        content: Text(
          'Bahan ini akan dihapus dari daftar inventaris kamu. Tindakan ini tidak bisa dibatalkan.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Batal',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx), // TODO: delete logic
            child: Text(
              'Hapus',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
