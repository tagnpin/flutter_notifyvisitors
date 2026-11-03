import 'package:flutter/material.dart';
import 'package:nv_flutter_sdk_app/client/screens/client_home_screen.dart';

class ClientRouter extends StatelessWidget {
  const ClientRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClientHomeScreen();
  }
}



// import 'package:flutter/material.dart';
// import 'package:nv_flutter_sdk_app/client/screens/client_home_screen.dart';
// import 'package:nv_flutter_sdk_app/client/screens/feature_action_screen.dart';
// import 'route_names.dart';

// class ClientRouter {
//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case RouteNames.clientHome:
//         return MaterialPageRoute(
//           builder: (_) => const ClientHomeScreen(),
//         );

//       case RouteNames.featureAction:
//         final args = settings.arguments as FeatureActionArgs;
//         return MaterialPageRoute(
//           builder: (_) => FeatureActionScreen(args: args),
//         );

//       default:
//         return MaterialPageRoute(
//           builder: (_) => const Scaffold(
//             body: Center(child: Text('Route not found')),
//           ),
//         );
//     }
//   }
// }
