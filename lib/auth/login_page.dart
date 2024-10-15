import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('asset/loginbg.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 136),
                child: Image(
                  image: AssetImage('asset/infodev.png'),
                  height: 52,
                  width: 160,
                  filterQuality: FilterQuality.none,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12, left: 20),
                child: Text(
                  'Human Resource System',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.28,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 132, left: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.74,
                      ),
                    ),
                    Text(
                      'Please sign in to continue',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.4,
                          color: Colors.grey[700]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 30),
                      child: Form(
                          key: _formkey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                height: 42,
                                child: TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      prefixIcon: Icon(Icons.person_2_outlined,
                                          color: Color.fromARGB(
                                              255, 187, 162, 162)),
                                      hintText: 'Email or Username',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                height: 42,
                                child: TextField(
                                  autocorrect: true,
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.lock_open_outlined,
                                        color:
                                            Color.fromARGB(255, 187, 162, 162),
                                      ),
                                      hintText: 'Password ',
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.blue,
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const Text('Remember Me')
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text('Forgot Password?'),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.only(left: 30, right: 36, top: 10),
                width: double.infinity,
                height: 40,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboardpage');
                  },
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
