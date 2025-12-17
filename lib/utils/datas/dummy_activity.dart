import 'package:flutter/material.dart';
import 'package:cobain_dulu/models/activity_model.dart';

final List<ActivityModel> dummyActivities = [
  ActivityModel(
    title: 'New campaign created',
    time: '2 min ago',
    icon: Icons.add_circle,
  ),
  ActivityModel(
    title: 'Campaign "Summer Sale" approved',
    time: '15 min ago',
    icon: Icons.check_circle,
  ),
  ActivityModel(
    title: 'Report generated',
    time: '1 hour ago',
    icon: Icons.description,
  ),
  ActivityModel(
    title: 'New advertiser registered',
    time: '2 hours ago',
    icon: Icons.person_add,
  ),
];