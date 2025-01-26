import 'package:flutter/material.dart';

class MenuPrincipalWidget extends StatefulWidget {
  const MenuPrincipalWidget({Key? key}) : super(key: key);

  @override
  State<MenuPrincipalWidget> createState() => _MenuPrincipalWidgetState();
}

class _MenuPrincipalWidgetState extends State<MenuPrincipalWidget> {
  bool _isInitialLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _isInitialLoading = false;
      });
    });
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
        child: Column(
          children: [
            // Header
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

            // Section Title
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

            // Scenarios List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildScenarioCard(
                    icon: Icons.meeting_room,
                    title: 'Meeting Request',
                    subtitle: 'Learn to schedule meetings professionally',
                    color: Colors.teal,
                    onTap: () {Navigator.pushNamed(context, '/escenarios'); },
                  ),
                  _buildScenarioCard(
                    icon: Icons.analytics,
                    title: 'Project Update',
                    subtitle: 'Report progress effectively to stakeholders',
                    color: Colors.orange,
                    onTap: () {Navigator.pushNamed(context, '/escenarios'); },
                  ),
                  _buildScenarioCard(
                    icon: Icons.person_add,
                    title: 'Client Introduction',
                    subtitle: 'Make great first impressions via email',
                    color: Colors.red,
                    onTap: () {Navigator.pushNamed(context, '/escenarios'); },
                  ),
                  _buildScenarioCard(
                    icon: Icons.email,
                    title: 'Follow-up Email',
                    subtitle: 'Master the art of professional follow-ups',
                    color: Colors.blue,
                    onTap: () {Navigator.pushNamed(context, '/escenarios'); },
                  ),
                  _buildScenarioCard(
                    icon: Icons.card_giftcard, 
                    title: 'Thank You Note',
                    subtitle: 'Express gratitude professionally',
                    color: const Color.fromARGB(255, 227, 104, 145),
                    onTap: () {Navigator.pushNamed(context, '/escenarios'); },
                  ),
                  _buildScenarioCard(
                    icon: Icons.report_problem, 
                    title: 'Apology Email',
                    subtitle: 'Address mistakes professionally',
                    color: const Color.fromARGB(255, 128, 77, 182),
                    onTap: () {Navigator.pushNamed(context, '/escenarios'); },
                  ),
                  _buildScenarioCard(
                    icon: Icons.attach_money, 
                    title: 'Sales Pitch',
                    subtitle: 'Create compelling business proposals',
                    color: const Color.fromARGB(255, 88, 177, 84),
                    onTap: () {Navigator.pushNamed(context, '/escenarios'); },
                  ),
                  _buildScenarioCard(
                    icon: Icons.people, 
                    title: 'Networking',
                    subtitle: 'Build professional relationships',
                    color: const Color.fromARGB(255, 13, 29, 43),
                    onTap: () {Navigator.pushNamed(context, '/escenarios'); },
                  ),                   
                ],
              ),
            ),
          ],
        ),
      ),
   bottomNavigationBar: BottomAppBar(
  color: Colors.white, 
  elevation: 4.0, 
  child: Container(
    height: 60,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.red),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
            const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.black, // Color del texto
                fontSize: 14.0, // Tamaño del texto
                fontWeight: FontWeight.w500, // Peso del texto
              ),
            ),
          ],
        ),
      ],
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
}