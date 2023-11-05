import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqlitedb/convert_utility.dart';
import 'package:sqlitedb/dbManager.dart';
import 'package:sqlitedb/student.dart';
import 'package:sqlitedb/info_page.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Student>>? Studentss;
  TextEditingController telController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController apepaController = TextEditingController();
  TextEditingController apemaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController controlNumController = TextEditingController();
  String? tel = '';
  String? name = '';
  String? email = '';
  String? apepa = '';
  String? apema = '';
  String? photoname = '';

  //Update control
  int? currentUserId;
  final formKey = GlobalKey<FormState>();
  late var dbHelper;
  late bool isUpdating;

  //Metodos de usuario
  refreshList() {
    setState(() {
      Studentss = dbHelper.getStudents();
    });
  }

  pickImageFromGallery() {
    ImagePicker imagePicker = ImagePicker();
    imagePicker
        .pickImage(source: ImageSource.gallery, maxHeight: 480, maxWidth: 640)
        .then((value) async {
      Uint8List? imageBytes = await value!.readAsBytes();
      setState(() {
        photoname = Utility.base64String(imageBytes);
      });
    });
  }

  clearFields() {
    telController.text = '';
    nameController.text = '';
    apepaController.text = '';
    apemaController.text = '';
    emailController.text = '';
    controlNumController.text = '';
    photoname = '';
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBManager();
    refreshList();
    isUpdating = false;
  }

  Widget userForm() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            const SizedBox(height: 10),
            //TextFormField(
            //controller: controlNumController,
            //keyboardType: TextInputType.number,
            //decoration: const InputDecoration(
            //labelText: 'Control Number',
            // ),
            //validator: (val) => val!.isEmpty ? 'Enter Control Number' : null,
            //onSaved: (val) => controlNumController.text = val!,
            // ),
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Escribe tu nombre";
                }
                if (value.length > 50) {
                  return "El nombre no debe tener más de 50 caracteres.";
                }
                return null;
              },
              onSaved: (val) => name = val!,
            ),
            TextFormField(
              controller: apepaController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Apellido Paterno',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Escribe apellido paterno";
                }
                if (value.length > 50) {
                  return "El apellido paterno no debe tener más de 50 caracteres.";
                }
                return null;
              },
              onSaved: (val) => apepa = val!,
            ),
            TextFormField(
              controller: apemaController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Apellido Materno',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Escribe apellido materno";
                }
                if (value.length > 50) {
                  return "El apellido materno no debe tener más de 50 caracteres.";
                }
                return null;
              },
              onSaved: (val) => apema = val!,
            ),
            TextFormField(
              controller: telController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Telefono',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Escribe tu telefono";
                }
                if (value.length != 10) {
                  return "Tu numero de telefono debe ser igual a 10 digitos";
                }
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return "Escribe solo dígitos";
                }
                return null;
              },
              onSaved: (val) => tel = val!,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Escribe tu email";
                }
                if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return "Email no valido";
                }
                if (value.length > 70) {
                  return "El email no debe tener más de 70 caracteres.";
                }
                return null;
              },
              onSaved: (val) => email = val!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: validate,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.lightBlue)),
                  child: Text(isUpdating ? "Actualizar" : "Insertar"),
                ),
                MaterialButton(
                  onPressed: (){
                    pickImageFromGallery();
                  },  
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.lime)),
                  child: const Text("Seleccionar imagen"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView userDataTable(List<Student>? Studentss){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Photo')),
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('A. Paterno')),
          DataColumn(label: Text('A. Materno')),
          DataColumn(label: Text('E-mail')),
          DataColumn(label: Text('Telefono')),
          DataColumn(label: Text('Borrar')),
        ],
        rows: Studentss!.map((student)=>DataRow(cells: [
          DataCell(Container(
          width: 80,
          height: 120,
          child: Utility.ImageFromBase64String(student.photoName!),
          ), onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => InfoPage(student: student),
              ),
            );
          },
          ),
          DataCell(Text(student.name!), onTap: (){
            setState(() {
              isUpdating = true;
              currentUserId = student.controlNum;
            });
            nameController.text = student.name!;
            apepaController.text = student.apepa!;
            apemaController.text = student.apema!;
            emailController.text = student.email!;
            telController.text = student.tel!;
          }),
          DataCell(Text(student.apepa!)),
          DataCell(Text(student.apema!)),
          DataCell(Text(student.email!)),
          DataCell(Text(student.tel!)),
          DataCell(IconButton(
            onPressed: () {
              dbHelper.delete(student.controlNum);
              refreshList();
            },
            icon: const Icon(Icons.delete_forever),
          ))
        ])).toList(),
      ),
    );
  }

  Widget list (){
    return Expanded(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: Studentss,
              builder: (context, AsyncSnapshot<dynamic> snapshot){
                if(snapshot.hasData){
                  print(snapshot.data);
                  return userDataTable(snapshot.data);
                }
                if(!snapshot.hasData){
                  print("Dato no encontrados");
                }
                return const CircularProgressIndicator();
              }),
        ));
  }

  validate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (photoname == '') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Imagen no seleccionada'),
        ));
        return;
      }
      else if(isUpdating) {
        Student student = Student(
            controlNum: currentUserId,
            name: name,
            apepa: apepa,
            apema: apema,
            email: email,
            tel: tel,
            photoName: photoname);
        dbHelper.update(student);
        isUpdating = false;
      } else {
        Student student = Student(
            controlNum: null,
            name: name,
            apepa: apepa,
            apema: apema,
            email: email,
            tel: tel,
            photoName: photoname);
        dbHelper.save(student);
      }
      clearFields();
      refreshList();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('SQLite DB'),   
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: [userForm(),list()],
      ),
    );
  }
}
