import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import '../Amplify/AuthService.dart';
import '../escenarios/escenarios_widget.dart';

class MenuPrincipalWidget extends StatefulWidget {
  const MenuPrincipalWidget({Key? key}) : super(key: key);

  @override
  State<MenuPrincipalWidget> createState() => _MenuPrincipalWidgetState();
}


class _MenuPrincipalWidgetState extends State<MenuPrincipalWidget> {
  bool _isInitialLoading = true;
  List<Map<String, String>> scenarios = [];
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _fetchScenarios();

    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _isInitialLoading = false;
      });
    });
  }

  Future<void> _fetchScenarios() async {
    final String apiUrl = 'http://lingualyapp.us-east-2.elasticbeanstalk.com/api/scenarios'; // Reemplaza con tu URL real
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          scenarios = data.map((item) => {
            'id':item['id'].toString() ?? '',
            'title': item['title'].toString() ?? 'Unknown',
            'subtitle': item['subtitle'].toString() ?? '',
            'icon': item['icon'].toString() ?? 'help',
            'description': item['description'].toString() ?? '',
          }).toList();
          _isInitialLoading = false;
        });
      } else {
        throw Exception('Failed to load scenarios');
      }
    } catch (e) {
      print('Error fetching scenarios: $e');
    }
  }

  Future<void> _handleSignOut(BuildContext context) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Perform sign out
      await Amplify.Auth.signOut();

      // Close loading indicator
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully logged out'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to login screen
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    } catch (e) {
      // Close loading indicator if it's showing
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error signing out: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitialLoading) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Center(
          child: Image.asset(
            'assets/images/letter.gif',
            width: 300,
            height: 300,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0F5F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFF3949AB),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Lingualy App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Improve your skills writing formal emails.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // SECTION TITLE
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Select a Scenario',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // SCENARIOS LIST
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: scenarios.length,
                itemBuilder: (context, index) {
                  final scenario = scenarios[index];
                  return _buildScenarioCard(
                    icon: _getIconFromName(scenario['icon'] ?? 'help'),
                    title: scenario['title'] ?? 'Unknown',
                    subtitle: scenario['subtitle'] ?? '',
                    color: _getRandomColor(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EscenariosWidget(
                            title: scenario['title'] ?? 'Unknown',
                            description: scenario['description'] ?? '',
                            id: scenario['id'] ?? '0',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 20), // 🔥 Para evitar que el footer quede pegado
            ],
          ),
        ),
      ),

      bottomNavigationBar: SizedBox(
        height: kToolbarHeight, // 🔥 Asegura que el tamaño sea adecuado
        child: BottomAppBar(
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.red),
                      onPressed: () => _handleSignOut(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),



    );
  }

  static Widget _buildScenarioCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black54,
          size: 20,
        ),
        onTap: onTap,
      ),
    );
  }

  IconData _getIconFromName(String iconName) {
    switch (iconName) {
      case 'meeting_room': return Icons.meeting_room;
      case 'analytics': return Icons.analytics;
      case 'person_add': return Icons.person_add;
      case 'email': return Icons.email;
      case 'card_giftcard': return Icons.card_giftcard;
      case 'report_problem': return Icons.report_problem;
      case 'attach_money': return Icons.attach_money;
      case 'people': return Icons.people;
      default: return Icons.help;
    }
  }

  Color _getRandomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}