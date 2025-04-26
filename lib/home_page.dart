import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;    
import 'package:flutter/material.dart';          
import 'package:provider/provider.dart';       

import 'app_state.dart';                        
import 'src/authentication.dart';               
import 'src/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weatherfit'),
      ),
      body: Column(
        children: <Widget>[
          // 将 Header 移到最前面
          const Padding(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Header("Know what to wear for different weather?"),
          ),
          // 添加说明文字，减少上下间距
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Paragraph(
              "Based on the temperature, we recommend the most suitable dressing combination for you!",
            ),
          ),
          // 图片部分减少上下间距
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                'assets/introductionfigure.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          // 使用 SizedBox 替代 Expanded，并添加固定高度
          const SizedBox(height: 40),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
              loggedIn: appState.loggedIn,
              signOut: () => FirebaseAuth.instance.signOut(),
            ),
          ),
          // 添加底部弹性空间
          const Spacer(),
        ],
      ),
    );
  }
}