import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:real_estate_app/models/agent.dart';
import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/services/get_agent_service.dart';
import 'package:real_estate_app/services/sendMessage_service.dart';
import 'package:real_estate_app/widget/show_dialog.dart';

class ContactAgent extends StatefulWidget {
  final int agentId;
  final String propertyImage;
  final int propertyId;
  ContactAgent({this.agentId, this.propertyImage, this.propertyId});

  @override
  _ContactAgentState createState() => _ContactAgentState();
}

class _ContactAgentState extends State<ContactAgent>  with SingleTickerProviderStateMixin{
   GetAgentService _agentService = GetAgentService();
  List<Agent> _agentList = List<Agent>();

    TabController _tabController;
  bool islogin = false;
    final txtfullname = TextEditingController();
  final txtPhone = TextEditingController();
  final txtEmail = TextEditingController();
  final txtMessage = TextEditingController();

    @override
    void initState() { 
      super.initState();
      _getAgentDetails();
        _tabController = TabController(length: 2, vsync: this);
     
    }

    @override
  void dispose() {
    _tabController.dispose();
    _getAgentDetails();
    super.dispose();
  }

   TabBar _getTab() {
    return TabBar(
      tabs: <Widget>[
        Tab(icon: Icon(Icons.person, color: Colors.redAccent)),
        Tab(icon: Icon(Icons.message, color: Colors.redAccent))
      ],
      controller: _tabController,
    );
  }

  TabBarView _getTabBarView(tabs) {
    return TabBarView(
      children: tabs,
      controller: _tabController,
    );
  }
   _getAgentDetails() async {
    var responseJson = await _agentService.getAgentDetails(this.widget.agentId);

    if (responseJson == null ||
        responseJson == 'Unauthenticated' ||
        responseJson == 'SocketException' ||
        responseJson == 'NetworkError') {
  
    } else {
      responseJson['data'].forEach((data) {
        var model = Agent();
        model.id = data['id'];
        model.name = data['name'];
        model.username = data['username'];
        model.image = Imgurl.imageUrl + data['image'];
        model.email = data['email'];
        if(mounted){
          setState(() {
            _agentList.add(model);
          });
        }
      });
    }
  }

  _sendMessageInfo() async {
    Map data = {
    'agent_id':this.widget.agentId.toString(),
    'name': txtfullname.text,
    'email': txtEmail.text,
    'phone':txtPhone.text,
    'message':txtMessage.text,
    };
    var _sendMessageService = SendMessageService();
    var response = await _sendMessageService.sendMessage(data);
    if(response.statusCode == 200){
     var jsonResonse = json.decode(response.body);
     print('Response Status: ${response.statusCode}');
     print('Response body: ${response.body}');
     print(jsonResonse);
     showdialog(
       context, "Sent Message", "Your Message has been Successfully sent",
      );
      if(mounted){
        setState(() {
          txtfullname.clear();
          txtEmail.clear();
          txtPhone.clear();
          txtMessage.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Agent')
      ),
      body: ListView(children: <Widget>[
 // Agent Section
                Column(
                    children: List.generate(this._agentList.length, (i) {
                  return Center(
                      child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Contact Agent"),
                      ),
                      Center(
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(this.widget.propertyImage),
                            ),
                            Text('${this._agentList[i].email}'),
                            Text('${this._agentList[i].name}'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      _getTab(),
                      Container(
                        height: MediaQuery.of(context).size.height/ 1.5,
                        child: _getTabBarView(<Widget>[
                          contactInfo(),
                          sendMessageContainer(),
                        ]),
                      )
                    ],
                  ));
                }))



      ],),
    );
  }
  
  Container contactInfo() {
    return Container(
        child: Column(
      children: List.generate(this._agentList.length, (i) {
        return Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.contacts),
                    SizedBox(width: 10.0),
                    Text('ADDRESS'),
                  ],
                ),
              ),
              Text('13 Airport Road, Lagos \n Lagos, Nigeria'),

              Padding(
                padding: const EdgeInsets.only(bottom:10.0, top: 10.0),
                child: Row(
                  children: <Widget>[
                   Icon(Icons.phone),
                   SizedBox(width: 10.0),
                   Text('PHONE'),
                  ],
                ),
              ),
              Text('08164293279 \n +234817398383'),
             
              
              Padding(
                 padding: const EdgeInsets.only(bottom:10.0, top: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.email),
                    SizedBox(width: 10.0),
                    Text('EMAIL'),
                  ],
                ),
              ),
               Text('${this._agentList[i].email}'),
             
            ],
          ),
        );
      }),
    ));
  }

  Container sendMessageContainer() {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(color: Colors.transparent),
    );
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: List.generate(this._agentList.length, (i) {
            return Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
               
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10.0, bottom: 16.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          child: Material(
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: TextField(
                              controller: txtfullname,
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person,
                                      color: Colors.grey[400]),
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  border: outlineInputBorder,
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputBorder,
                                  hintText: "Fullname"),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10.0, bottom: 16.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          child: Material(
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: TextField(
                              controller: txtPhone,
                              keyboardType:TextInputType.phone,
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone,
                                      color: Colors.grey[400]),
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  border: outlineInputBorder,
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputBorder,
                                  hintText: "Phone"),
                            ),
                          ),
                        ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 16.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: TextField(
                          keyboardType:TextInputType.emailAddress,
                          controller: txtEmail,
                          style: TextStyle(fontSize: 12.0, color: Colors.black),
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.grey[400]),
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.0),
                              border: outlineInputBorder,
                              enabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputBorder,
                              hintText: "Email"),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 16.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: TextField(
                          keyboardType:TextInputType.multiline,
                          controller: txtMessage,
                          style: TextStyle(fontSize: 12.0, color: Colors.black),
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.message, color: Colors.grey[400]),
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16.0),
                              border: outlineInputBorder,
                              enabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputBorder,
                              hintText: "Message"),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: new FlatButton(
                            onPressed: () {
                              _sendMessageInfo();
                            },
                            child: Text("Send")),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}