import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intellcloud/dao/login_dao.dart';
import 'package:intellcloud/model/login_model.dart';
import 'package:intellcloud/utils/Urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BuildContext _context;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _context = context;
    final double topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: topPadding, left: 50.0, right: 50.0),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/bg_login.png"),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  "能源智云",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              flex: 1,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.greenAccent,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage("images/user.png"),
                        ),
                        Expanded(
                          child: TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                  //输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
                                  contentPadding: EdgeInsets.all(10.0),
                                  hintText: '请输入用户名',
                                  //默认的文字placeholder 占位文字
                                  // border:InputBorder.none,  去掉那条线
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.greenAccent,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage("images/password.png"),
                        ),
                        Expanded(
                          child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  //输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
                                  contentPadding: EdgeInsets.all(10.0),
                                  hintText: '请输入密码',
                                  //默认的文字placeholder 占位文字
                                  // border:InputBorder.none,  去掉那条线
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none)),
                        ),
                      ],
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      margin: EdgeInsets.only(top: 17.0),
                      height: 45.0,
                      child: RaisedButton(
                        color: Colors.teal,
                        splashColor: Colors.tealAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "登录",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        onPressed: _dologin,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _dologin() async {
    String username = _usernameController.text.toString();
    String password = _passwordController.text.toString();
    if (username.isEmpty) {
      Fluttertoast.showToast(msg: "用户名不能为空");
      return;
    }
    if (password.isEmpty) {
      Fluttertoast.showToast(msg: "密码不能为空");
      return;
    }
    Map headers = Map<String, String>();
    headers['Authorization'] = 'Basic YW5kcm9pZDphbmRyb2lk';

    Map params = Map<String, dynamic>();
    params['username'] = username;
    params['password'] = password;
    params['grant_type'] = 'password';
    LoginDao.getLoginModel(Urls.token, params, headers)
        .then((LoginModel loginModel) async {
      Fluttertoast.showToast(msg: "登录成功");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("access_token", loginModel.access_token);
    }).catchError((onError) {
      Fluttertoast.showToast(msg: onError.message);
      print(onError.message);
    });
  }
}
