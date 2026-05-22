import 'package:flutter/material.dart';

class SDKInfoCard extends StatelessWidget {
  final String status;
  final String sdkVersion;
  final String appVersion;
  final String platform;
  final String deviceId;
  final String pushToken;
  final String? adID;

  const SDKInfoCard({
    super.key,
    required this.status,
    required this.sdkVersion,
    required this.appVersion,
    required this.platform,
    required this.deviceId,
    required this.pushToken,
    this.adID,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(theme, colors),
            const SizedBox(height: 12),
            _row(theme, 'SDK Version', sdkVersion),
            _row(theme, 'App Version', appVersion),
            _row(theme, 'Platform', platform),
            _selectableRow(theme, 'Device ID', deviceId),
            _selectableRow(theme, 'Push Token', pushToken),
            _row(theme, 'AdID', adID ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _header(ThemeData theme, ColorScheme colors) {
    final statusColor =
        status.toLowerCase() == 'initialized' ? colors.primary : colors.error;

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'SDK Status: $status',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _row(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectableRow(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              maxLines: 2,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class SDKInfoCard extends StatelessWidget {
//   final String status;
//   final String sdkVersion;
//   final String appVersion;
//   final String platform;
//   final String deviceId;
//   final String pushToken;

//   const SDKInfoCard({
//     super.key,
//     required this.status,
//     required this.sdkVersion,
//     required this.appVersion,
//     required this.platform,
//     required this.deviceId,
//     required this.pushToken,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colors = theme.colorScheme;

//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: theme.colorScheme.primary,
//         ),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'SDK Info',
//             style: theme.textTheme.titleMedium
//                 ?.copyWith(fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 12),
//           _row('Status', 'Initialized ✅'),
//           _row('SDK Version', sdkVersion),
//           _row('App Version', appVersion),
//           _row('Platform', platform),
//           _selectableRow('Device ID', deviceId),
//           _selectableRow('Push Token', pushToken),
//         ],
//       ),
//     );
//   }

//   Widget _row(String key, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 110,
//             child: Text(
//               key,
//               style: const TextStyle(fontWeight: FontWeight.w500),
//             ),
//           ),
//           Expanded(
//             child: Text(value),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _selectableRow(String key, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 110,
//             child: Text(
//               key,
//               style: const TextStyle(fontWeight: FontWeight.w500),
//             ),
//           ),
//           Expanded(
//             child: SelectableText(
//               value,
//               maxLines: 2,
//               toolbarOptions: const ToolbarOptions(
//                 copy: true,
//                 selectAll: true,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
