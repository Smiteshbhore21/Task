import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderBar extends StatelessWidget {
  final Color colorPrimary;
  final void Function(String) onSearchChanged;
  final Future<void> Function() onLogout;

  const HeaderBar({
    super.key,
    required this.colorPrimary,
    required this.onSearchChanged,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: colorPrimary,
        child: Stack(
          children: [
            Positioned(
              left: -45,
              bottom: -45,
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(53, 255, 255, 255),
                  borderRadius: BorderRadius.circular(210),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.grid_view_outlined,
                            color: Colors.white),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                            onChanged: onSearchChanged,
                            decoration: InputDecoration(
                              hintText: 'Search tasks',
                              prefixIcon: const Icon(Icons.search,
                                  color: Color.fromARGB(179, 0, 0, 0)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        color: const Color.fromRGBO(249, 250, 251, 1),
                        onSelected: (value) async {
                          if (value == 'logout') await onLogout();
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(
                            value: 'logout',
                            child: Row(
                              children: [
                                Icon(Icons.logout, size: 20),
                                SizedBox(width: 8),
                                Text('Log Out')
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Today, ${DateFormat.MMMd().format(DateTime.now())}",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'My tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
