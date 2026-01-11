import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final supabase = Supabase.instance.client;

  Map<String, dynamic>? profile;
  bool loading = true;

  // TEMP: replace with actual roll no source later
  final String rollNo = "12345";

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final data = await supabase
          .from('profiles')
          .select()
          .eq('roll_no', rollNo)
          .single();

      if (!mounted) return;

      setState(() {
        profile = data;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (profile == null) {
      return const Center(
        child: Text(
          "Profile not found",
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "User Profile",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),

          _ProfileTile("Role", profile!['role']),
          _ProfileTile("Region", profile!['region']),
          _ProfileTile("System", profile!['system']),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final String title;
  final String value;
  const _ProfileTile(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
