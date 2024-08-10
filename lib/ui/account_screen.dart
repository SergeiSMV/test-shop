
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:test_shop/constants/text_styles.dart';

import '../data/hive_implements/hive_implements.dart';


class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<AccountScreen> {

  final HiveImplements hive = HiveImplements();

  @override
  void initState(){
    super.initState();
  }

  Future<String> fetchData() async {
    Map userData = await hive.getUserData();
    String name = userData['name'];
    return name;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Opacity(opacity: 0.6, child: Text('ЛИЧНЫЙ ', style: black(30, FontWeight.w800),)),
                    Text('КАБИНЕТ', style: brand(30, FontWeight.w800),),
                  ],
                ),
              ),
              FutureBuilder(
                future: fetchData(), 
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox.shrink();
                  } else if (snapshot.hasError) {
                    return Text('Ошибка: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return Text(snapshot.data!, style: black54(25, FontWeight.w800));
                  } else {
                    return Text('Нет данных', style: black54(25, FontWeight.w800));
                  }
                }
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    GoRouter.of(context).go('/auth');
                  },
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(MdiIcons.exitToApp, size: 50, color: Colors.amber.shade800,),
                        Text('выход', style: black54(20, FontWeight.w800),)
                      ],
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}