import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:login/config/router.dart';
import 'package:login/core/theme/app_colors.dart';
import 'package:login/core/theme/app_string.dart';
import 'package:login/core/theme/app_text_style.dart';
import 'package:login/core/utils/app_connectivity.dart';
import 'package:login/core/utils/app_responsive.dart';
import 'package:login/core/utils/app_database.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  String? userEmail;
  String? userAge;
  String? userBio;
  String? profileImagePath;
  String connectionStatus = 'Checking...';
  bool isLoading = true;
  final AppDatabase _db = AppDatabase();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _checkConnection();
  }

  Future<void> _loadUserData() async {
    final user = await _db.getUser();
    final extraData = await _db.getExtraData();
    final imagePath = await _db.getProfileImage();

    setState(() {
      userName = user?['name'] ?? 'User';
      userEmail = user?['email'] ?? '';
      userAge = extraData?['age'];
      userBio = extraData?['bio'];
      profileImagePath = imagePath;
      isLoading = false;
    });
  }

  Future<void> _checkConnection() async {
    final status = await AppConnectivity.getConnectionStatus();
    setState(() {
      connectionStatus = status;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      await _db.insertOrUpdateProfileImage(pickedFile.path);
      setState(() {
        profileImagePath = pickedFile.path;
      });
    }
  }

  Future<void> _showImagePickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    await _db.clearAll();
    if (mounted) {
      context.go(AppRouters.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.profileTitle,
          style: AppTextStyle.ts14normal.copyWith(
            color: AppColors.backgroundColor,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppResponsive.height(context) * 0.02),
                  
                  // Profile Image
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: AppColors.hintColore,
                        backgroundImage: profileImagePath != null
                            ? FileImage(File(profileImagePath!))
                            : null,
                        child: profileImagePath == null
                            ? const Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      GestureDetector(
                        onTap: _showImagePickerOptions,
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.primaryColor,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: AppResponsive.height(context) * 0.03),
                  
                  // User Name
                  Text(
                    userName ?? 'User',
                    style: AppTextStyle.ts21bold.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  
                  // User Email
                  Text(
                    userEmail ?? '',
                    style: AppTextStyle.ts14normal.copyWith(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                  
                  SizedBox(height: AppResponsive.height(context) * 0.03),
                  
                  // Connection Status
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: connectionStatus == 'Connected'
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: connectionStatus == 'Connected'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          connectionStatus == 'Connected'
                              ? Icons.wifi
                              : Icons.wifi_off,
                          color: connectionStatus == 'Connected'
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          connectionStatus,
                          style: AppTextStyle.ts14normal.copyWith(
                            color: connectionStatus == 'Connected'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: AppResponsive.height(context) * 0.04),
                  
                  // Extra Data Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.aboutMe,
                            style: AppTextStyle.ts16medium.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const Divider(),
                          if (userAge != null && userAge!.isNotEmpty) ...[
                            _buildInfoRow(AppStrings.ageLabel, userAge!),
                            const SizedBox(height: 12),
                          ],
                          if (userBio != null && userBio!.isNotEmpty)
                            _buildInfoRow(AppStrings.bioLabel, userBio!)
                          else
                            Text(
                              AppStrings.noExtraData,
                              style: AppTextStyle.ts14normal.copyWith(
                                color: AppColors.secondaryTextColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: AppResponsive.height(context) * 0.03),
                  
                  // Add Data Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        context.go(AppRouters.formScreen);
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: Text(
                        AppStrings.addExtraData,
                        style: AppTextStyle.ts14normal.copyWith(
                          color: AppColors.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: AppTextStyle.ts14normal.copyWith(
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyle.ts14normal.copyWith(
              color: AppColors.secondaryTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
