import 'package:flutter/material.dart';
import 'package:todd_coin_ui/models/domain/organization.dart';

class ViewOrganization extends StatefulWidget {
  final Organization organization;

  const ViewOrganization({Key? key, required this.organization})
      : super(key: key);

  @override
  State<ViewOrganization> createState() => _ViewOrganizationState();
}

class _ViewOrganizationState extends State<ViewOrganization> {
  @override
  Widget build(BuildContext context) {
    Organization organization = widget.organization;

    return Scaffold(
      appBar: AppBar(title: const Text('View a Organization')),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'ID',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(organization.id ?? "Unknown")
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(organization.name ?? "Unknown")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
