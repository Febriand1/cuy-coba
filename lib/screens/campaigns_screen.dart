import 'package:cobain_dulu/models/campaign_model.dart';
import 'package:cobain_dulu/utils/datas/dummy_campaign.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class CampaignsScreen extends StatefulWidget {
  const CampaignsScreen({super.key});

  @override
  State<CampaignsScreen> createState() => _CampaignsScreenState();
}

class _CampaignsScreenState extends State<CampaignsScreen> {
  int _sidebarIndex = 0;

  final List<Map<String, dynamic>> _itemsCampaigns = [
    {'icon': Icons.list_alt_outlined, 'label': 'All Campaigns'},
    {'icon': Icons.play_circle_outlined, 'label': 'Active'},
    {'icon': Icons.pause_circle_outlined, 'label': 'Paused'},
    {'icon': Icons.drafts_outlined, 'label': 'Drafts'},
    {'icon': Icons.archive_outlined, 'label': 'Archived'},
    {'icon': Icons.schedule_outlined, 'label': 'Scheduled'},
  ];

  // Sidebar khusus untuk Campaigns
  SidebarConfig get _sidebarConfig => SidebarConfig(
    title: 'Campaigns',
    items: _itemsCampaigns.map((item) {
      return SidebarItem(
        icon: item['icon'],
        label: item['label'],
        onTap: () => _showSnackBar(item['label']),
      );
    }).toList(),
  );

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navigating to $message')));
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Campaigns',
      sidebarConfig: _sidebarConfig,
      sidebarSelectedIndex: _sidebarIndex,
      onSidebarItemTap: (index) {
        setState(() => _sidebarIndex = index);
      },
      actions: [
        IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      ],
      floatingActionButton: CustomFab(
        icon: Icons.add,
        label: 'New Campaign',
        isExtended: true,
        onPressed: () {},
      ),
      body: _buildCampaignsList(),
    );
  }

  Widget _buildCampaignsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dummyCampaigns.length,
      itemBuilder: (context, index) {
        final campaign = dummyCampaigns[index];
        return _buildCampaignCard(campaign);
      },
    );
  }

  Widget _buildCampaignCard(CampaignModel campaign) {
    Color statusColor;
    switch (campaign.status) {
      case 'Active':
        statusColor = Colors.green;
        break;
      case 'Paused':
        statusColor = Colors.orange;
        break;
      case 'Scheduled':
        statusColor = Colors.blue;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    campaign.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    campaign.status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetric('Impressions', campaign.impressions),
                _buildMetric('Clicks', campaign.clicks),
                _buildMetric('Budget', campaign.budget),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  text: 'Edit',
                  onPressed: () {},
                  variant: CustomButtonVariant.text,
                  size: CustomButtonSize.small,
                  leadingIcon: Icons.edit_outlined,
                ),
                CustomButton(
                  text: 'Stats',
                  onPressed: () {},
                  variant: CustomButtonVariant.text,
                  size: CustomButtonSize.small,
                  leadingIcon: Icons.bar_chart_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
