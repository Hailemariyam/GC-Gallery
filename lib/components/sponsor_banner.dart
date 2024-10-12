import 'package:flutter/material.dart';

class SponsorBanner extends StatefulWidget {
  const SponsorBanner({super.key});

  @override
  _SponsorBannerState createState() => _SponsorBannerState();
}

class _SponsorBannerState extends State<SponsorBanner> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: _expanded ? 300 : 200,
        height: _expanded ? 150 : 100,
        color: _expanded ? Colors.blue : Colors.green,
        child: Center(
          child: Text(
            'Sponsored by XYZ',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
