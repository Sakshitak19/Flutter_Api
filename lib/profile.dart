import 'package:api/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Consumer<UserProvider>(builder: (context,userProvider,child){
        if(userProvider.isLoading){
          return const Center(child: CircularProgressIndicator(),
          );
        }

        if(userProvider.user.isEmpty){
          return const Center(
            child: Text("No user"),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("First name:${userProvider.user["firstName"]}",
            style: const TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text("Last name:${userProvider.user["lastName"]}",
            style: TextStyle(fontSize:18),
            ),
            SizedBox(height: 10,),

            Text("Email:${userProvider.user["email"]}",
            style: TextStyle(fontSize:18),
            ),
            SizedBox(height: 10,),

             Text("Age:${userProvider.user["age"]}",
            style: TextStyle(fontSize:18),
            ),
            SizedBox(height: 10,),

            ElevatedButton(onPressed: () {
              userProvider.updateUser();
            }, child: Text("Update"),
            ),
            SizedBox(height: 10,),

            ElevatedButton(onPressed: (){
              userProvider.deleteUser();
            }, child: Text("Delete User"),

            ),
          ],
        );
        

      })
    );
  }
}