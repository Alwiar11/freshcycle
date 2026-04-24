import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freshcycle/features/recipe_ai/domain/models/recipe_model.dart';
import 'package:go_router/go_router.dart';

class RecipeDetailHeader extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeDetailHeader({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_buildBackground(context), _buildBackButton(context)],
    );
  }

  Widget _buildBackground(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.25),
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(36.r)),
      ),
      child: Stack(
        children: [
          _buildDecorativeCircle(
            top: -20.h,
            right: -30.w,
            size: 180.w,
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.08),
          ),
          _buildDecorativeCircle(
            bottom: 30.h,
            left: -20.w,
            size: 120.w,
            color: Theme.of(
              context,
            ).colorScheme.tertiary.withValues(alpha: 0.06),
          ),
          Center(
            child: Hero(
              tag: 'recipe-emoji-${recipe.id}',
              child: Material(
                color: Colors.transparent,
                child: Text(recipe.emoji, style: TextStyle(fontSize: 100.sp)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeCircle({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required Color color,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      top: 16.h,
      left: 16.w,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        child: InkWell(
          onTap: () => context.pop(),
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Icon(
              Icons.arrow_back_rounded,
              size: 20.r,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
