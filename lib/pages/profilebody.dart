import 'package:flutter/material.dart';

class Profilebody extends StatelessWidget {
  const Profilebody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    width: double.infinity,
    child: Column(
      children: const [
        CircleAvatar(
          backgroundImage: AssetImage('assets/ambatukam.jpg'),
          radius: 50.0,
        ),
        Text('Filipus Susanto'),
        Text('FilipusViper@gmail.com'),
        Text('06373274508'),
      ],
    ),
    );
  }
}