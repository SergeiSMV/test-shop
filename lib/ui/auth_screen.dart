
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:test_shop/constants/text_styles.dart';
import 'package:test_shop/riverpod/bottom_nav_bar_provider.dart';

import '../constants/auth_data.dart';
import '../data/hive_implements/hive_implements.dart';
import '../riverpod/product_provider.dart';
import '../widgets_global/scaffold_messenger.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthState();
}

class _AuthState extends ConsumerState<AuthScreen> {

  final HiveImplements hive = HiveImplements();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool isHided = true;
  

  @override
  void initState(){
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    _loginController.text = 'tesla@mail.com';
    _passController.text = 'tesla10071856';
  }

  @override
  void dispose(){
    _loginController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void changeVisiblePass(){
    setState(() {
      isHided = !isHided;
    });
  }

  bool emailValidate(String email){
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email) || email.isEmpty){
      return false;
    } else {
      return true;
    }
  }

  Future<bool> authenticateUser(String email, String pass) async {
    for (var user in users) {
      if (user['email'] == email && user['pass'] == pass) {
        await hive.saveUserData(user['name'], user['id']);
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      barrierColor: Colors.white.withOpacity(0.7),
      padding: const EdgeInsets.all(20.0),
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Opacity(opacity: 0.6, child: Text('TEST', style: black(50, FontWeight.w800),)),
                            Text('SHOP', style: brand(50, FontWeight.w800),),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          width: 240,
                          child: Opacity(opacity: 0.6, child: Text('need a part-time job', style: black(10),))
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),

                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 280
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 45,
                            child: TextFormField(
                              controller: _loginController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black54, width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintStyle: grey(16),
                                hintText: 'Email',
                                prefixIcon: Icon(MdiIcons.at, color: Colors.black54, size: 20,),
                                isCollapsed: true
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            height: 45,
                            child: TextFormField(
                              controller: _passController,
                              textAlignVertical: TextAlignVertical.center,
                              obscureText: isHided,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black54, width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintStyle: grey(16),
                                hintText: 'пароль',
                                prefixIcon: Icon(MdiIcons.lockOutline, color: Colors.black54, size: 20,),
                                suffixIcon: InkWell(
                                  onTap: changeVisiblePass,
                                  child: isHided ? Icon(MdiIcons.eyeOffOutline, color: Colors.black54, size: 20,)
                                    : Icon(MdiIcons.eyeOutline, color: Colors.black54, size: 20,)
                                ),
                                isCollapsed: true
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: 280,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber.shade800,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                if (!emailValidate(_loginController.text)) {
                                  GlobalScaffoldMessenger.instance.showSnackBar("введите корректный email", 'error');
                                } else if (_passController.text.isEmpty) {
                                  GlobalScaffoldMessenger.instance.showSnackBar("введите пароль", 'error');
                                } else {
                                  FocusScope.of(context).unfocus();
                                  final progress = ProgressHUD.of(context);
                                  progress?.showWithText('авторизуемся');
                                  bool authResult = await authenticateUser(_loginController.text, _passController.text);
                                  Future.delayed(const Duration(seconds: 2)).then((_){
                                    authResult ? 
                                      {
                                        GoRouter.of(context).go('/'),
                                        ref.read(visibleNavbarProvider.notifier).toogle(),
                                        ref.refresh(baseFavoriteIdProvider)
                                      } 
                                      : GlobalScaffoldMessenger.instance.showSnackBar("не верный логин или пароль", 'error');
                                    progress?.dismiss();
                                  });

                                }
                              }, 
                              child: Text('авторизоваться', style: black54(16),)
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}