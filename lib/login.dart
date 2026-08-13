import 'package:flutter/material.dart';
import 'footer.dart';
import 'package:provider/provider.dart';
import 'providers/login_provider.dart';
import 'providers/user_provider.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String message = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


   
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText:"name",
              border: OutlineInputBorder(),
            ),

            validator:(value){
              if(value==null || value.isEmpty){
                return "please Enter name";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),
          
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText:"password",
              border: OutlineInputBorder(),
            ),
            validator:(value){
              if(value==null || value.isEmpty){
                return "please Enter password";
              }
              if(value.length<8){
                return "password must be 8 character";
              }
              return null;
            },
           
          ),
          const SizedBox(height: 20),


          
        Consumer<LoginProvider>(
          builder: (context,loginProvider,child){
            return ElevatedButton(onPressed: 
            loginProvider.isLoading ? null :()async{
              if(_formKey.currentState!.validate()){
                final success = await loginProvider.login(nameController.text,
                passwordController.text,);

                if(success && context.mounted){
                 
  await Provider.of<UserProvider>(
    context,
    listen: false,
  ).getCurrentUser();

  if (context.mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FooterPage(),
      ),
    );
  }
}
              }
              },
             
           
            child: loginProvider.isLoading
            ? const CircularProgressIndicator():
            const Text("Login"),
            );
          },
        
          ),

         // Image.network("https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTExL3JtNTUxLTExLW1hY2Jvb2stMTFhLnBuZw.png"),
         //Image.asset("assets/images/img19.png"),

        ],),
     
      ),
      ),
    );
  }
}