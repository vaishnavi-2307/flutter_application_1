import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/notes.dart';
import 'package:flutter_application_1/models/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: camel_case_types
class Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[600],
     appBar: AppBar(
         titleSpacing: 0.0,
       toolbarHeight: 200,
       title: Image.network("https://media.istockphoto.com/photos/timeline-planning-checklist-or-business-plan-with-calendar-date-on-picture-id1211255735?k=20&m=1211255735&s=612x612&w=0&h=eT_yt1ZzUGw053m8ycranQWs8-kL0VDv67DrqfxNGxw=",fit: BoxFit.cover,)
     ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NotesProviders>(
          builder: (context,NotesProviders data,child){
            // ignore: prefer_is_empty
            return data.getNotes.length !=0 ? ListView.builder(
              itemCount: data.getNotes.length,
              itemBuilder: (context,index){
                return CardList(data.getNotes[index],index);
              },
            ): GestureDetector(onTap: (){
              showAlertDialog(context);
            },child: const Center(child: Text("ADD SOME NOTES NOW",style: TextStyle(color: Colors.white,),)));
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {
        showAlertDialog(context);
      },
          backgroundColor: Colors.white,
          child: const Icon(Icons.add,color: Colors.black,),
      ),
    );

  }

}

// ignore: must_be_immutable
class CardList extends StatelessWidget {
  final Notes notes;
  int index;

  CardList(this.notes,this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child:Slidable(
        actionPane: const SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
     
          decoration:const BoxDecoration(
            color: Colors.white,
            
            borderRadius: BorderRadius.only(
              bottomLeft:  Radius.circular(10),
              topLeft: Radius.circular(10),

            )
          ),
          child: ListTile(
           leading:const Icon(Icons.note),
              title: Text(notes.title),
            subtitle: Text(notes.description),
            trailing:const Icon(Icons.arrow_forward_ios,color: Colors.black26,),
          ),
        ),

        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: (){
              print("HELLO DELETED");
              Provider.of<NotesProviders>(context,listen: false).removeNotes(index);
            }
          ),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {

  TextEditingController _Title = TextEditingController();
  TextEditingController _Description = TextEditingController();
  // Create button
  Widget okButton = FlatButton(
    child: Text("ADD NOTE"),
    onPressed: () {
      Provider.of<NotesProviders>(context,listen: false).addNotes(_Title.text, _Description.text);
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("ADD A NEW NOTE "),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _Title,
          decoration:const InputDecoration(hintText: "Enter Title"),
        ),
        TextField(
          controller: _Description,
          decoration:const InputDecoration(hintText: "Enter Description"),
        ),
      ],
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
