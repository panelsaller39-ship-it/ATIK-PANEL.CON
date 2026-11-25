import 'package:flutter/material.dart';

void main() => runApp(const AtikPanelApp());

const bg = Color(0xFF050B16);
const panel = Color(0xFF0D1929);
const cyan = Color(0xFF00D9F5);
const blue = Color(0xFF168BFF);
const muted = Color(0xFF8FA6BC);

class AtikPanelApp extends StatelessWidget {
  const AtikPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ATIK PANEL.COM',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: cyan, secondary: blue, surface: panel,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const DashboardPage(),
    );
  }
}

class ServiceItem {
  final String title, subtitle, tag, icon;
  final Color color;
  const ServiceItem(this.title, this.subtitle, this.tag, this.icon, this.color);
}

const services = [
  ServiceItem('GAME SETUP GUIDE', 'Recommended settings & setup', 'AVAILABLE', '🎮', cyan),
  ServiceItem('HUD PRESETS', 'Layout guides for supported games', 'POPULAR', '🎯', Color(0xFF9C63FF)),
  ServiceItem('PERFORMANCE GUIDE', 'Device performance tips', 'UPDATED', '⚡', Color(0xFF39D98A)),
  ServiceItem('PROFILE DESIGN', 'Custom gamer profile service', 'AVAILABLE', '👑', Color(0xFFFFC247)),
  ServiceItem('ACCOUNT SUPPORT', 'Help with account questions', 'SUPPORT', '🛡️', Color(0xFF36B8FF)),
  ServiceItem('DEVICE GUIDE', 'Safe device settings information', 'AVAILABLE', '📱', Color(0xFFFF6DB2)),
];

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int tab = 0;
  final List<String> orders = [];
  final List<String> codes = [];

  void order(ServiceItem item) {
    setState(() => orders.insert(0, item.title));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.title} added to My Orders')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      homePage(),
      simplePage('MY ORDERS', orders, 'No orders yet'),
      fundsPage(),
      simplePage('MY CODES', codes, 'No codes available'),
      accountPage(),
    ];
    return Scaffold(
      body: SafeArea(child: Column(children: [
        header(),
        Expanded(child: pages[tab]),
      ])),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF091321),
        indicatorColor: cyan.withOpacity(.15),
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), label: 'My Orders'),
          NavigationDestination(icon: Icon(Icons.add_circle_outline), label: 'Add Funds'),
          NavigationDestination(icon: Icon(Icons.card_giftcard), label: 'My Codes'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }

  Widget header() => Container(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
    decoration: BoxDecoration(
      color: const Color(0xFF081321),
      border: Border(bottom: BorderSide(color: cyan.withOpacity(.35))),
      boxShadow: [BoxShadow(color: cyan.withOpacity(.08), blurRadius: 18)],
    ),
    child: Row(children: [
      Container(width: 42, height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          gradient: const LinearGradient(colors: [cyan, blue]),
        ),
        child: const Center(child: Text('AP', style: TextStyle(color: bg, fontWeight: FontWeight.w900, fontSize: 17))),
      ),
      const SizedBox(width: 10),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('ATIK PANEL.COM', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: .6)),
        Text('GAMING RESELLER PANEL', style: TextStyle(fontSize: 9, color: muted, letterSpacing: 1.6)),
      ])),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: const Color(0xFF063A3A), borderRadius: BorderRadius.circular(30), border: Border.all(color: cyan.withOpacity(.5))),
        child: const Row(children: [Icon(Icons.account_balance_wallet_outlined, size: 16, color: cyan), SizedBox(width: 5), Text('৳ 0', style: TextStyle(fontWeight: FontWeight.bold))]),
      ),
      const SizedBox(width: 9),
      CircleAvatar(radius: 18, backgroundColor: blue, child: const Text('A', style: TextStyle(fontWeight: FontWeight.bold))),
    ]),
  );

  Widget homePage() => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [Color(0xFF102B48), Color(0xFF17133A)]),
          border: Border.all(color: cyan.withOpacity(.35)),
        ),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('WELCOME TO', style: TextStyle(color: cyan, letterSpacing: 2, fontSize: 10, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text('ATIK PANEL.COM', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
          SizedBox(height: 5),
          Text('Your gaming services dashboard', style: TextStyle(color: muted)),
        ]),
      ),
      const SizedBox(height: 20),
      Row(children: [
        const Expanded(child: Text('OUR SERVICES', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1))),
        Text('${services.length} SERVICES', style: const TextStyle(color: cyan, fontSize: 10, fontWeight: FontWeight.bold)),
      ]),
      const SizedBox(height: 12),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: services.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: .78,
        ),
        itemBuilder: (context, i) {
          final s = services[i];
          return Container(
            decoration: BoxDecoration(
              color: panel, borderRadius: BorderRadius.circular(18),
              border: Border.all(color: s.color.withOpacity(.42)),
              boxShadow: [BoxShadow(color: s.color.withOpacity(.07), blurRadius: 14)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  decoration: BoxDecoration(color: s.color.withOpacity(.13), borderRadius: BorderRadius.circular(20)),
                  child: Text(s.tag, style: TextStyle(color: s.color, fontSize: 9, fontWeight: FontWeight.w900)),
                ),
                const Spacer(),
                Center(child: Text(s.icon, style: const TextStyle(fontSize: 42))),
                const Spacer(),
                Text(s.title, maxLines: 2, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                const SizedBox(height: 4),
                Text(s.subtitle, maxLines: 2, style: const TextStyle(color: muted, fontSize: 10)),
                const SizedBox(height: 10),
                SizedBox(width: double.infinity, child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: blue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 8)),
                  onPressed: () => order(s),
                  child: const Text('VIEW SERVICE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                )),
              ]),
            ),
          );
        },
      ),
      const SizedBox(height: 12),
      const Center(child: Text('Safe gaming guides and services only', style: TextStyle(color: muted, fontSize: 10))),
    ],
  );

  Widget simplePage(String title, List<String> items, String empty) => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 1)),
      const SizedBox(height: 16),
      if (items.isEmpty)
        Container(padding: const EdgeInsets.all(28), decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(18)),
          child: Center(child: Text(empty, style: const TextStyle(color: muted))))
      else
        ...items.map((e) => Card(color: panel, child: ListTile(leading: const Icon(Icons.check_circle_outline, color: cyan), title: Text(e), subtitle: const Text('Request created on this device')))),
    ],
  );

  Widget fundsPage() => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('ADD FUNDS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
    const SizedBox(height: 16),
    Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(18), border: Border.all(color: cyan.withOpacity(.3))),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Current balance', style: TextStyle(color: muted)),
        SizedBox(height: 5),
        Text('৳ 0.00', style: TextStyle(fontSize: 30, color: cyan, fontWeight: FontWeight.w900)),
        SizedBox(height: 10),
        Text('Payment setup is not connected yet. Add your verified payment provider before accepting real payments.', style: TextStyle(color: muted)),
      ])),
  ]);

  Widget accountPage() => ListView(padding: const EdgeInsets.all(18), children: [
    const Center(child: CircleAvatar(radius: 38, backgroundColor: blue, child: Icon(Icons.person, size: 42))),
    const SizedBox(height: 12),
    const Center(child: Text('ATIK PANEL USER', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18))),
    const Center(child: Text('Guest account • Local preview', style: TextStyle(color: muted))),
    const SizedBox(height: 20),
    for (final row in [
      ('Profile information', Icons.person_outline),
      ('Notifications', Icons.notifications_none),
      ('Help & support', Icons.support_agent),
      ('About ATIK PANEL.COM', Icons.info_outline),
    ])
      Card(color: panel, child: ListTile(leading: Icon(row.$2, color: cyan), title: Text(row.$1), trailing: const Icon(Icons.chevron_right))),
  ]);
}
