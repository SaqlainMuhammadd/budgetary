// import 'package:budgetary_your_personal_finance_manager/signin.dart';
// import 'package:flutter/material.dart';

// class forgottenScreen extends StatefulWidget {
//   const forgottenScreen({super.key});

//   @override
//   State<forgottenScreen> createState() => _forgottenScreenState();
// }

// class _forgottenScreenState extends State<forgottenScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SigninScreen(),
//                     ));
//               },
//               child: Container(
//                 height: height * 0.05,
//                 width: width * 0.09,
//                 child: Center(
//                   child: Icon(
//                     Icons.keyboard_arrow_left_rounded,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                     color: Colors.teal, borderRadius: BorderRadius.circular(8)),
//               ),
//             ),
//             SizedBox(
//               height: height * 0.1,
//             ),
//             Text(
//               'Forget \nPassword',
//               style: Theme.of(context).textTheme.displayLarge,
//             ),
//             SizedBox(
//               height: height * 0.05,
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.person),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                 hintText: 'Usrename or Email',
//                 labelText: 'Usrename or Email',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: height * 0.005,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                   '* We will send you a message to set \n  or reset your new password'),
//             ),
//             SizedBox(
//               height: height * 0.03,
//             ),
//             Center(
//               child: Container(
//                 width: width * 0.4,
//                 height: height * 0.06,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20))),
//                     onPressed: () {},
//                     child: Text(
//                       "SUBMIT",
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
