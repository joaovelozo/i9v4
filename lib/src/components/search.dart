import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final void Function(String)? onChanged;
  final String? hintText;
  const Search({super.key, this.onChanged, this.hintText});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        autofocus: false,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.search),
            hintText: widget.hintText),
      ),
    );
  }
}
