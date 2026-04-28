import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/constants/app_sizes.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_character.dart';

class NameInputScreen extends ConsumerStatefulWidget {
  const NameInputScreen({super.key});

  @override
  ConsumerState<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends ConsumerState<NameInputScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final name = ref.read(onboardingControllerProvider).profile.name;
    _controller = TextEditingController(text: name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = _controller.text.trim();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: OnboardingCharacter(
                  state: OnboardingCharacterState.happy,
                  height: 200,
                ),
              ),
              const SizedBox(height: 12),
              Text('What should I call you?', style: AppTextStyles.headline),
              const SizedBox(height: 6),
              Text('This helps personalize your lessons.', style: AppTextStyles.bodyMuted),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Your name',
                ),
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) => _continue(context),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Continue',
                onPressed: name.isEmpty ? null : () => _continue(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _continue(BuildContext context) async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    await ref.read(onboardingControllerProvider.notifier).setName(name);
    if (!context.mounted) return;
    context.go('/onboarding/goal');
  }
}

