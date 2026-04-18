// bai4/views/update_user_view.dart

import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class UpdateUserView extends StatefulWidget {
  final int userId;
  const UpdateUserView({super.key, required this.userId});

  @override
  State<UpdateUserView> createState() => _UpdateUserViewState();
}

class _UpdateUserViewState extends State<UpdateUserView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = UserController();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _websiteCtrl;

  UserModel? _user;
  bool _isLoading = true;
  bool _isSaving = false;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _websiteCtrl = TextEditingController();
    _loadUser();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _websiteCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _controller.fetchUser(widget.userId);
      setState(() {
        _user = user;
        _nameCtrl.text = user.name;
        _emailCtrl.text = user.email;
        _phoneCtrl.text = user.phone;
        _websiteCtrl.text = user.website;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMsg = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _save() async {
    if (_user == null || !_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      final updated = await _controller.updateUser(
        _user!.copyWith(
          name: _nameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          phone: _phoneCtrl.text.trim(),
          website: _websiteCtrl.text.trim(),
        ),
      );
      setState(() => _user = updated);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cập nhật thành công'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      setState(() => _errorMsg = e.toString());
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 4: Update User Info - 6451071069'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMsg != null
              ? Center(child: Text(_errorMsg!, style: const TextStyle(color: Colors.red)))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Chỉnh sửa thông tin cá nhân',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        _buildField(_nameCtrl, 'Họ tên', Icons.person),
                        const SizedBox(height: 12),
                        _buildField(_emailCtrl, 'Email', Icons.email,
                            keyboardType: TextInputType.emailAddress),
                        const SizedBox(height: 12),
                        _buildField(_phoneCtrl, 'Số điện thoại', Icons.phone,
                            keyboardType: TextInputType.phone),
                        const SizedBox(height: 12),
                        _buildField(_websiteCtrl, 'Website', Icons.language),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: _isSaving
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white),
                                )
                              : const Icon(Icons.save),
                          label: Text(
                              _isSaving ? 'Đang lưu...' : 'Lưu thay đổi'),
                          onPressed: _isSaving ? null : _save,
                        ),
                        if (_user != null) ...[
                          const SizedBox(height: 24),
                          Card(
                            color: Colors.orange.shade50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Dữ liệu hiện tại từ server:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange)),
                                  const SizedBox(height: 8),
                                  Text('ID: ${_user!.id}'),
                                  Text('Name: ${_user!.name}'),
                                  Text('Email: ${_user!.email}'),
                                  Text('Phone: ${_user!.phone}'),
                                  Text('Website: ${_user!.website}'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildField(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    TextInputType? keyboardType,
  }) =>
      TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
        validator: (v) =>
            (v == null || v.trim().isEmpty) ? 'Vui lòng nhập $label' : null,
      );
}
