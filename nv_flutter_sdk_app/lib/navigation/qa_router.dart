import 'package:flutter/material.dart';
import 'package:nv_flutter_sdk_app/qa/screens/qa_home_screen.dart';

// class QARouter extends StatelessWidget {
//   const QARouter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const QAHomeScreen();
//   }
// }

class QARouter extends StatelessWidget {
  const QARouter({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QAHomeScreen(),
    );
  }
}




// import 'package:flutter/material.dart';
// import '../qa/screens/qa_home_screen.dart';

// class QARouter {
//   Widget build() {
//     return Navigator(
//       onGenerateRoute: (settings) {
//         return MaterialPageRoute(
//           builder: (_) => const QAHomeScreen(),
//         );
//       },
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:nv_flutter_sdk_app/qa/screens/qa_home_screen.dart';

// class QARouter extends StatelessWidget {
//   const QARouter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const QAHomeScreen();
//   }
// }
