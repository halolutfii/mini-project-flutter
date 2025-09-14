import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/admin_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../routes.dart';
import '../../../models/user.dart';

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
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
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
                      return _employeeTile(context, employee, provider);
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addEmployee);
        },
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Text("Admin Panel", style: TextStyle(fontSize: 18)),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {
                await authProvider.signOut();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget _employeeTile(BuildContext context, Users employee, AdminProvider provider) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade100,
        child: const Icon(Icons.person, color: Colors.blue),
      ),
      title: Text(employee.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("${employee.email}\nRole: ${employee.role}"),
      isThreeLine: true,
      trailing: PopupMenuButton<String>(
        onSelected: (value) async {
          if (value == 'edit') {
            // buka form edit employee
            Navigator.pushNamed(context, AppRoutes.updateProfile, arguments: employee);
          } else if (value == 'delete') {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Hapus Employee"),
                content: Text("Yakin hapus ${employee.name}?"),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Batal")),
                  ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text("Hapus")),
                ],
              ),
            );
            if (confirm == true) {
              await provider.deleteEmployee(employee.uid);
            }
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'edit', child: Text("Edit")),
          const PopupMenuItem(value: 'delete', child: Text("Delete")),
        ],
      ),
    ),
  );
}