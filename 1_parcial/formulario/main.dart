import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // darkTheme: ThemeData.dark(),
      home:const HomePage() ,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController plastlController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  bool nameExist = false;
  bool lastExist = false;
  bool plastlExist = false;
  bool phoneExist = false;
  bool emailExist = false;
  bool ageExist = false;

  void _submit(){
    final isValid = formKey.currentState!.validate();
    if (!isValid){
      return;
    }
    formKey.currentState!.save();
  }

  saveData() async{
    final SharedPreferences prefs = await _prefs;
    prefs.setString("name", nameController.text.trim());
    prefs.setString("last", lastController.text.trim());
    prefs.setString("plast", plastlController.text.trim());
    prefs.setString("phone", phoneController.text.trim());
    prefs.setString("email", emailController.text.trim());
    prefs.setString("age", ageController.text.trim());  
    //print("Tu email es: " + emailController.text.trim());
  }

  Future<void> readData() async{
    final SharedPreferences prefs = await _prefs;
    final String? email = prefs.getString("email");
    final String? name = prefs.getString("name");
    final String? last = prefs.getString("last");
    final String? plast = prefs.getString("plast");
    final String? phone = prefs.getString("phone");
    final String? age = prefs.getString("age");
    if(email != null && name != null && last != null && plast != null && phone != null && age != null && context.mounted){
      setState((){
        nameExist = true;
        lastExist = true;
        plastlExist = true;
        phoneExist = true;
        emailExist = true;
        ageExist = true;
      });
      if(nameExist && lastExist && plastlExist && phoneExist && emailExist && ageExist){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LandingPage(
              userEmail: email,
              userName: name,
              userLast: last,
              userPlast: plast,
              userPhone: phone,
              userAge: age,

              )),
        );
      }
      //print(email);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
    /*if(emailExist){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LandingPage(
          userEmail: emailController.text.trim(),
          userName: nameController.text.trim(),
          userLast: lastController.text.trim(),
          userAge: ageController.text.trim(),
          userPhone: phoneController.text.trim(),
          userPlast: plastlController.text.trim()
        )),
      );
    }*/

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login Page",
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Center(child: Text("Login Page", style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              )),
              const SizedBox(
                height: 5,
              ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                //valida pues
                onFieldSubmitted: (value){
                  print(value);
                },
                validator:(value){
                  if(value!.isEmpty||!!RegExp(r"^[a-zA-Z0-9, a-zA-Z0-9.!#$%&'*+-/=?^_ {|}~]+@[a-zA-Z0-9]+\-[a-zA-Z]+")
                  .hasMatch(value)){
                    return "Escribe tu nombre";
                  }
                  return null;
                },
                controller: nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Nombre(s)"),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                //valida pues parte 2
                onFieldSubmitted: (value){
                  print(value);
                },
                validator:(value){
                  if(value!.isEmpty||value.length<8){
                    return "Escribe minimo 8 caracteres";
                  }
                  return null;
                },
                obscureText: true,
                controller: lastController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "contraseña"),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(

                onFieldSubmitted: (value){
                  print(value);
                },
                validator: (value){
                  if(value!.isEmpty||!!RegExp(r"^[a-zA-Z0-9, a-zA-Z0-9.!#$%&'*+-/=?^_ {|}~]+@[a-zA-Z0-9]+\-[a-zA-Z]+")
                  .hasMatch(value)){
                    return "Escribe tu nombre";
                  }
                  return null;
                },
                // obscureText: true, para ocultar contraseñas
                controller: phoneController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Telefono"),
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onFieldSubmitted: (value){
                  print(value);
                },
                validator: (value){
                  if(value!.isEmpty||!!RegExp(r"^[a-zA-Z0-9, a-zA-Z0-9.!#$%&'*+-/=?^_ {|}~]+@[a-zA-Z0-9]+\-[a-zA-Z]+")
                  .hasMatch(value)){
                    return "Escribe tu nombre";
                  }
                  return null;
                },
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Correo Electronico"),
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onFieldSubmitted: (value){
                  print(value);
                },
                validator: (value){
                  if(value!.isEmpty||!!RegExp(r"^[a-zA-Z0-9, a-zA-Z0-9.!#$%&'*+-/=?^_ {|}~]+@[a-zA-Z0-9]+\-[a-zA-Z]+")
                  .hasMatch(value)){
                    return "Escribe tu nombre";
                  }
                  return null;
                },
                controller: ageController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Edad"),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ElevatedButton(
                  onPressed: () {
                    _submit();
                    saveData();
                    final isValid = formKey.currentState!.validate();
                    if(isValid){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                          LandingPage(
                          userName: nameController.text.trim(), 
                          userLast: lastController.text.trim(),
                          userPlast: plastlController.text.trim(), 
                          userPhone: phoneController.text.trim(),
                          userEmail: emailController.text.trim(),
                          userAge: ageController.text.trim(),
                          )
                          ),
                      ).then((res){
                        nameController.clear();
                        lastController.clear();
                        plastlController.clear();
                        phoneController.clear();
                        emailController.clear();
                        ageController.clear();
                      });
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )),
            )
          ],
        ),
        ));
  }
}
