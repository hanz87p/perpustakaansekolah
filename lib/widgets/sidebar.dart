import 'package:flutter/material.dart';

class SidebarItem {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  SidebarItem({required this.icon, required this.label, this.onTap});
}

class Sidebar extends StatelessWidget {
  final List<SidebarItem> items;
  final int selectedIndex;
  final Color color;
  final String userName;
  final String userNis;
  final String roleLabel;

  const Sidebar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.color,
    required this.userName,
    required this.userNis,
    required this.roleLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: color,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Icon(Icons.menu_book, color: Colors.white, size: 32),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('PUSTAKARA', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                    Text(roleLabel, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: items.length,
              itemBuilder: (context, i) {
                final item = items[i];
                final isActive = selectedIndex == i;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  child: Material(
                    color: isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: item.onTap,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Icon(item.icon, color: Colors.white, size: 20),
                            const SizedBox(width: 12),
                            Text(item.label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: Text(userName[0].toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                      Text(userNis, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}