// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;

// class SignupScreen extends StatefulWidget {
//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();

//   String _errorMessage = '';

//   Future<void> signUp() async {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();

//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Send email verification link
//       await userCredential.user!.sendEmailVerification();

//       // Navigate to email verification screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => EmailVerificationScreen()),
//       );
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Signup Error: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Signup'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//               ),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//               ),
//               obscureText: true,
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: signUp,
//               child: Text('Sign Up'),
//             ),
//             Text(
//               _errorMessage,
//               style: TextStyle(color: Colors.red),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EmailVerificationScreen extends StatefulWidget {
//   @override
//   _EmailVerificationScreenState createState() =>
//       _EmailVerificationScreenState();
// }

// class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Listen for changes in the user's authentication state
//     _auth.authStateChanges().listen((User? user) {
//       if (user != null && user.emailVerified) {
//         // Email is verified, navigate to the home screen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen1()),
//         );
//       }
//     });

//     // Send verification email if the user is still logged in and the email is not verified
//     sendVerificationEmail();
//   }

//   Future<void> sendVerificationEmail() async {
//     User user = _auth.currentUser!;
//     await user.sendEmailVerification();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Verification email sent. Please check your inbox.'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Email Verification'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Your email is not verified.',
//               style: TextStyle(fontSize: 18),
//             ),
//             ElevatedButton(
//               onPressed: sendVerificationEmail,
//               child: Text('Resend Verification Email'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HomeScreen1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Center(
//         child: Text('Welcome to the Home Screen!'),
//       ),
//     );
//   }
// }
