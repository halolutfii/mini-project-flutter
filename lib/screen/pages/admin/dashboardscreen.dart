import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/admin_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../routes.dart';
import '../../../models/user.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/drawer.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AdminProvider>().loadEmployees());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminProvider>();
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(
        title: 'Admin Dashboard',
        showDrawer: true,
        onSettings: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 8),
                  Text("Settings Clicked!"),
                ],
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
      drawer: AppDrawer(
        onItemTap: (index) => Navigator.pop(context),
      ),
      body: RefreshIndicator(
        onRefresh: () => provider.loadEmployees(),
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.errorMessage != null
                ? Center(child: Text("Error: ${provider.errorMessage}"))
                : ListView.builder(
                    itemCount: provider.employees.length,
                    itemBuilder: (context, index) {
                      final employee = provider.employees[index];
                      return _employeeTile(context, employee, provider, user);
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2E3A59),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addEmployee),
      ),
    );
  }
}

Widget _employeeTile(
    BuildContext context, Users employee, AdminProvider provider, dynamic user) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white, // ganti gradient jadi putih
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: Colors.grey[200],
          backgroundImage: user?.photoURL != null
              ? NetworkImage(user.photoURL!)
              : (employee.photo != null && employee.photo!.isNotEmpty
                  ? NetworkImage(employee.photo!)
                  : null) as ImageProvider<Object>?,
          child: (user?.photoURL == null &&
                  (employee.photo == null || employee.photo!.isEmpty))
              ? Text(
                  employee.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                )
              : null,
        ),
        title: Text(
          employee.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(employee.email),
            const SizedBox(height: 2),
          ],
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'edit') {
              Navigator.pushNamed(context, AppRoutes.updateProfile,
                  arguments: employee);
            } else if (value == 'delete') {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Hapus Employee"),
                  content: Text("Yakin hapus ${employee.name}?"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Batal")),
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Hapus")),
                  ],
                ),
              );
              if (confirm == true) {
                await provider.deleteEmployee(employee.uid);
              }
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'edit', child: Text("Edit")),
            PopupMenuItem(value: 'delete', child: Text("Delete")),
          ],
        ),
      ),
    ),
  );
}