import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  List screens = [CounterScreen(),Direction()];
  int index = 0;
  _onTabTapped(i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //primarySwatch: Colors.black,
        accentColor: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(0, 40, 89, 1),
        body: screens[index],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(0, 40, 89, 1),
            selectedItemColor: Colors.white,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            onTap: _onTabTapped,
            currentIndex: index,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), title: Text("Members")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.note_add), title: Text("COVID Rules")),
            ]),

      ),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int count=0;

  Firestore firebaseFirestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          Container(
            margin: EdgeInsets.symmetric(horizontal: 60,vertical: 60),
            width: double.infinity,
            height: 200,
            child: Image.asset('assets/logo.png',fit: BoxFit.fill,color: Colors.white,),
          ),


          StreamBuilder(
            stream: firebaseFirestore.collection('people').document('count').snapshots(),
            builder: (BuildContext context,snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }

              int Data = snapshot.data['count'];
              return CircleAvatar(
                  radius: 80,
                  backgroundColor: Data<= 65 ? Colors.green : (Data>65 && Data<=80) ? Colors.yellow : (Data>80 && Data<=90) ? Colors.orange :Colors.red,
                  child: Text(Data.toString(),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black)));
            },),



        ],
      ),
    );
  }
}



class Direction extends StatefulWidget {
  @override
  _DirectionState createState() => _DirectionState();
}

class _DirectionState extends State<Direction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset('assets/Direction.jpg'),
    );
  }
}

