import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/config/router.dart';
import 'package:login/core/theme/app_colors.dart';
import 'package:login/core/theme/app_string.dart';
import 'package:login/core/theme/app_text_style.dart';
import 'package:login/core/utils/app_responsive.dart';
import 'package:login/core/utils/app_database.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _bioController = TextEditingController();
  bool isLoading = true;
  final AppDatabase _db = AppDatabase();

  @override
  void initState() {
    super.initState();
    _loadExistingData();
  }

  Future<void> _loadExistingData() async {
    final extraData = await _db.getExtraData();
    if (extraData != null) {
      setState(() {
        _ageController.text = extraData['age'] ?? '';
        _bioController.text = extraData['bio'] ?? '';
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      await _db.insertOrUpdateExtraData(
        age: _ageController.text.trim(),
        bio: _bioController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppStrings.dataSavedSuccess,
              style: AppTextStyle.ts14normal,
            ),
            backgroundColor: AppColors.primaryColor,
          ),
        );
        context.go(AppRouters.profileScreen);
      }
    }
  }

  @override
  void dispose() {
    _ageController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.formTitle,
          style: AppTextStyle.ts14normal.copyWith(
            color: AppColors.backgroundColor,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go(AppRouters.profileScreen),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppResponsive.height(context) * 0.02),
                    
                    Center(
                      child: Text(
                        AppStrings.addExtraData,
                        style: AppTextStyle.ts21bold.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: AppResponsive.height(context) * 0.04),
                    
                    // Age Field
                    Text(
                      AppStrings.ageLabel,
                      style: AppTextStyle.ts14normal.copyWith(
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: AppStrings.ageHint,
                        hintStyle: AppTextStyle.ts12Regular.copyWith(
                          color: AppColors.secondaryTextColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.hintColore,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.errorColor,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.ageRequired;
                        }
                        final age = int.tryParse(value);
                        if (age == null || age <= 0 || age > 150) {
                          return AppStrings.ageInvalid;
                        }
                        return null;
                      },
                    ),
                    
                    SizedBox(height: AppResponsive.height(context) * 0.03),
                    
                    // Bio Field
                    Text(
                      AppStrings.bioLabel,
                      style: AppTextStyle.ts14normal.copyWith(
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _bioController,
                      maxLines: 4,
                      maxLength: 200,
                      decoration: InputDecoration(
                        hintText: AppStrings.bioHint,
                        hintStyle: AppTextStyle.ts12Regular.copyWith(
                          color: AppColors.secondaryTextColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.hintColore,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.errorColor,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.bioRequired;
                        }
                        if (value.length < 5) {
                          return AppStrings.bioTooShort;
                        }
                        return null;
                      },
                    ),
                    
                    SizedBox(height: AppResponsive.height(context) * 0.04),
                    
                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _saveData,
                        child: Text(
                          AppStrings.saveButton,
                          style: AppTextStyle.ts14normal.copyWith(
                            color: AppColors.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
