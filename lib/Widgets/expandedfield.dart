import 'package:flutter/material.dart';

class Expandedfield extends StatelessWidget {
  const Expandedfield({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated ListTile Example'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return AnimatedListTile(
            title: 'Item $index',
            subtitle: 'Tap to see more',
            expandedContent:
                'This is the additional content for Item $index. You can put more details here.',
          );
        },
      ),
    );
  }
}

class AnimatedListTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String expandedContent;

  AnimatedListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.expandedContent,
  });

  @override
  _AnimatedListTileState createState() => _AnimatedListTileState();
}

class _AnimatedListTileState extends State<AnimatedListTile> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(widget.subtitle),
        onExpansionChanged: (expanded) {
          _toggleExpansion();
        },
        children: <Widget>[
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.expandedContent,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
