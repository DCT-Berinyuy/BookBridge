import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:book_bridge_app/features/auth/state/auth_provider.dart';
import 'package:go_router/go_router.dart';

import 'package:book_bridge_app/features/locations/state/location_provider.dart';
import 'package:book_bridge_app/features/users/state/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);
    final userModel = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit profile screen
            },
            color: Colors.green,
          ),
        ],
      ),
      body: authState.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('Not logged in'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              // Refresh user data
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Profile header section
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.green.shade50, Colors.green.shade100],
                      ),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: user.photoURL != null
                                    ? NetworkImage(user.photoURL!)
                                    : null,
                                child: user.photoURL == null
                                    ? const Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.grey,
                                      )
                                    : null,
                              ),
                            ),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: Colors.white, width: 3),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user.displayName ?? 'No Name',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user.email ?? 'No Email',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.green[200]!),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.school,
                                size: 16,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Student',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Stats section
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatCard(
                          value: '12',
                          label: 'Listings',
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey[300],
                        ),
                        _StatCard(
                          value: '8',
                          label: 'Sold',
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey[300],
                        ),
                        _StatCard(
                          value: '4',
                          label: 'Active',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Personal details section
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Details',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Locality field
                        userModel.when(
                          data: (userModelData) {
                            final location = ref.watch(
                              locationProvider(userModelData?.localityId ?? ''),
                            );
                            return location.when(
                              data: (locationData) => _ProfileField(
                                label: 'Locality / Campus Area',
                                value: locationData?.name ?? 'N/A',
                                icon: Icons.location_on,
                                iconColor: Colors.green,
                              ),
                              loading: () => _ProfileField(
                                label: 'Locality / Campus Area',
                                value: 'Loading...',
                                icon: Icons.location_on,
                                iconColor: Colors.green,
                              ),
                              error: (error, stack) => _ProfileField(
                                label: 'Locality / Campus Area',
                                value: 'Error loading',
                                icon: Icons.location_on,
                                iconColor: Colors.green,
                              ),
                            );
                          },
                          loading: () => _ProfileField(
                            label: 'Locality / Campus Area',
                            value: 'Loading...',
                            icon: Icons.location_on,
                            iconColor: Colors.green,
                          ),
                          error: (error, stack) => _ProfileField(
                            label: 'Locality / Campus Area',
                            value: 'Error loading',
                            icon: Icons.location_on,
                            iconColor: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // WhatsApp field
                        userModel.when(
                          data: (userModelData) => _ProfileField(
                            label: 'WhatsApp Number',
                            value: userModelData?.whatsappNumber ?? 'Add number',
                            icon: Icons.chat,
                            iconColor: Colors.green[600],
                            helperText: 'Visible only to verified buyers',
                            isEditable: true,
                          ),
                          loading: () => _ProfileField(
                            label: 'WhatsApp Number',
                            value: 'Loading...',
                            icon: Icons.chat,
                            iconColor: Colors.green[600],
                          ),
                          error: (error, stack) => _ProfileField(
                            label: 'WhatsApp Number',
                            value: 'Error loading',
                            icon: Icons.chat,
                            iconColor: Colors.green[600],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // University field (read-only)
                        _ProfileField(
                          label: 'University / School',
                          value: 'Delhi University',
                          icon: Icons.school,
                          iconColor: Colors.blue[600],
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Account settings section
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Settings',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Notifications toggle
                        _SettingsItem(
                          icon: Icons.notifications,
                          iconColor: Colors.green,
                          title: 'Notifications',
                          trailing: Switch(
                            value: true,
                            onChanged: (value) {},
                            activeTrackColor: Colors.green,
                            activeColor: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Privacy settings
                        _SettingsItem(
                          icon: Icons.privacy_tip,
                          iconColor: Colors.blue,
                          title: 'Privacy & Safety',
                          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        // Payment methods
                        _SettingsItem(
                          icon: Icons.payment,
                          iconColor: Colors.purple,
                          title: 'Payment Methods',
                          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Support section
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Support',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Help & Support
                        _SettingsItem(
                          icon: Icons.help,
                          iconColor: Colors.orange,
                          title: 'Help & Support',
                          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        // About
                        _SettingsItem(
                          icon: Icons.info,
                          iconColor: Colors.grey,
                          title: 'About BookBridge',
                          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Action buttons
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () async {
                            await ref.read(authServiceProvider).signOut();
                            if (context.mounted) {
                              context.go('/');
                            }
                          },
                          child: const Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final String? helperText;
  final bool readOnly;
  final bool isEditable;

  const _ProfileField({
    required this.label,
    required this.value,
    required this.icon,
    this.iconColor,
    this.helperText,
    this.readOnly = false,
    this.isEditable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor ?? Colors.grey),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: readOnly ? Colors.grey[500] : null,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (isEditable && !readOnly)
                  IconButton(
                    icon: const Icon(Icons.edit, size: 18, color: Colors.green),
                    onPressed: () {
                      // Handle edit action
                    },
                  ),
              ],
            ),
            if (helperText != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.visibility, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    helperText!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget? trailing;

  const _SettingsItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: trailing,
        onTap: () {
          // Handle item tap
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
