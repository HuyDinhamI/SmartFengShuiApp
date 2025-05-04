import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/theme.dart';
import '../../providers/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isEmailSent = false;
  
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quên mật khẩu'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLarge),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Icon
                    Icon(
                      _isEmailSent ? Icons.mark_email_read : Icons.lock_reset,
                      size: 80,
                      color: AppTheme.primaryColor,
                    ),
                    
                    const SizedBox(height: AppTheme.spacingLarge),
                    
                    // Title
                    Text(
                      _isEmailSent 
                          ? 'Email đã được gửi!'
                          : 'Đặt lại mật khẩu',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: AppTheme.spacingMedium),
                    
                    // Description
                    Text(
                      _isEmailSent 
                          ? 'Chúng tôi đã gửi hướng dẫn đặt lại mật khẩu đến email của bạn. Vui lòng kiểm tra hộp thư đến hoặc hộp thư spam.'
                          : 'Nhập địa chỉ email của bạn và chúng tôi sẽ gửi cho bạn liên kết để đặt lại mật khẩu.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: AppTheme.spacingXLarge),
                    
                    if (!_isEmailSent) ...[
                      // Email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Nhập địa chỉ email của bạn',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập địa chỉ email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Địa chỉ email không hợp lệ';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: AppTheme.spacingLarge),
                      
                      // Submit button
                      ElevatedButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : () => _resetPassword(context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                          ),
                        ),
                        child: authProvider.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text(
                                'Gửi yêu cầu đặt lại mật khẩu',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ] else ...[
                      // Return to login button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                          ),
                        ),
                        child: const Text(
                          'Quay lại đăng nhập',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: AppTheme.spacingMedium),
                      
                      // Resend email button
                      TextButton(
                        onPressed: authProvider.isLoading
                            ? null
                            : () => _resetPassword(context),
                        child: authProvider.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Gửi lại email'),
                      ),
                    ],
                    
                    // Alternative options
                    const SizedBox(height: AppTheme.spacingLarge),
                    Center(
                      child: Column(
                        children: [
                          const Text('Hoặc vui lòng thử'),
                          TextButton(
                            onPressed: () {
                              _showFeatureInDevelopment(
                                context,
                                'Đặt lại mật khẩu qua SMS',
                                'Tính năng đặt lại mật khẩu qua SMS đang được phát triển',
                              );
                            },
                            child: const Text('Đặt lại mật khẩu qua SMS'),
                          ),
                        ],
                      ),
                    ),
                    
                    // Error message
                    if (authProvider.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: AppTheme.spacingMedium),
                        child: Text(
                          authProvider.errorMessage!,
                          style: const TextStyle(
                            color: AppTheme.errorColor,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void _resetPassword(BuildContext context) async {
    // Hide keyboard
    FocusScope.of(context).unfocus();
    
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      await authProvider.sendPasswordResetEmail(email);
      
      // Nếu không có lỗi, đánh dấu đã gửi email
      if (authProvider.errorMessage == null) {
        setState(() {
          _isEmailSent = true;
        });
      }
    }
  }
  
  // Hiển thị thông báo tính năng đang phát triển
  void _showFeatureInDevelopment(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$title đang phát triển'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }
}
