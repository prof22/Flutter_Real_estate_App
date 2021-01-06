
import 'package:flutter/material.dart';
import 'package:real_estate_app/models/Properties.dart';
import 'package:real_estate_app/repository/declarations.dart';
import 'package:real_estate_app/screen/searchResult_screen.dart';
import 'package:real_estate_app/services/properties_service.dart';
import 'package:real_estate_app/widget/show_dialog.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Properties> _propertiesList = List<Properties>();
  List<Properties> _bedpropertiesList = List<Properties>();
  List<Properties> _bathpropertiesList = List<Properties>();
  PropertiesService _propertiesService = PropertiesService();
   TextEditingController _txtCity = new TextEditingController();
  TextEditingController _txtMin = new TextEditingController();
  TextEditingController _txtMax = new TextEditingController();

  final List _apartment = ['House', 'Apartment'];
  final List _purpose = ['Rent', 'Sale'];
  String _apartmentSelected;
  String __purposeSelected;
  int _bedroomSelected;
  int _bathroomSelected;
  bool searchResult = false;

  @override
  void initState() {
    super.initState();
    _getBedroomProperties();
    _getBathroomProperties();

  }

  @override
  void dispose() {
    _getBedroomProperties();
    _getBathroomProperties();
    // search();
    super.dispose();
  }

  _getBedroomProperties() async {
    var responseJson = await _propertiesService.bedroom();
    if (responseJson == null ||
        responseJson == 'Unauthenticated' ||
        responseJson == 'SocketException' ||
        responseJson == 'NetworkError') {
      // var result = json.decode(responseJson.body);
      // print(result);
    } else {
      responseJson['data'].forEach((data) {
        var model = Properties();
        model.bedroom = data['bedroom'];
        if (mounted) {
          setState(() {
            _bedpropertiesList.add(model);
          });
        }
      });
    }
  }

  _getBathroomProperties() async {
    var responseJson = await _propertiesService.bathroom();
    if (responseJson == null ||
        responseJson == 'Unauthenticated' ||
        responseJson == 'SocketException' ||
        responseJson == 'NetworkError') {
      // var result = json.decode(responseJson.body);
      // print(result);
    } else {
      responseJson['data'].forEach((data) {
        var model = Properties();
        model.bathroom = data['bathroom'];
        if (mounted) {
          setState(() {
            _bathpropertiesList.add(model);
          });
        }
      });
    }
  }

  search() async{
  //   if(_txtCity.text.isEmpty || _txtMax.text.toString().isEmpty || _txtMin.text.toString().isEmpty ||  _apartmentSelected == null  || __purposeSelected == null || _bedroomSelected == null || _bathroomSelected == null){
  //   _txtCity.text = "";
  //   _txtMin.text = "";
  //   _txtMax.text = "";
  //    _apartmentSelected = "";
  //   __purposeSelected = "";
  //  _bedroomSelected = 0;
  //  _bathroomSelected = 0;
  // }
 var responseJson = await _propertiesService.search(
   _txtCity.text.trim(),
   _apartmentSelected.toString().replaceAll('null', ''),
 __purposeSelected.toString().replaceAll('null', ''),
 int.parse(_bedroomSelected.toString().replaceAll('null', '0')),
  int.parse(_bathroomSelected.toString().replaceAll('null', '0')),
   _txtMin.text.toString(), 
   _txtMax.text.toString());
    if (responseJson == 'null' ||
        responseJson == 'Unauthenticated' ||
        responseJson == 'SocketException' ||
        responseJson == 'NetworkError') {
      // var result = json.decode(responseJson.body);
      // print(result);
    } else {
      responseJson['data'].forEach((data) {
         print(data);
        var model = Properties();
       model.id = data['id'];
        model.title = data['title'];
        model.price = data['price'];
        model.purpose = data['purpose'];
        model.type = data['type'];
        model.image = Imgurl.imageUrl + data['image'];
        model.bedroom = data['bedroom'];
        model.bathroom = data['bathroom'];
        model.address = data['address'];
        model.city = data['city'];
        model.area = data['area'];
        model.slug = data['slug'];
        model.description = data['description'];
        model.floorPlan = data['floor_plan'];
        model.nearBy = data['nearby'];
        model.agentId = data['agent_id'];
        if (mounted) {
          setState(() {
           _propertiesList.add(model);
           searchResult = true;
          });
        }
      });
  }
   showdialog(
       context, "Search Result", "No result found",
      );
  }
  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(color: Colors.transparent),
    );
    // searchResult ? Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //                                                 HomeAllProperties(
    //                                                   // propertiesList:
    //                                                   //     _propertiesList,
    //                                                 )))
    // :__purposeSelected = __purposeSelected; _apartmentSelected = _apartmentSelected; 
    return Scaffold(
        body: searchResult ? ResultScreen(propertiesList: _propertiesList):
        ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width,
              // color: Colors.pink[200].withOpacity(.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(300.0, 50.0),
                    bottomLeft: Radius.elliptical(300.0, 50.0)),
                color: Colors.pink[200].withOpacity(.5),
              ),
            ),
            Positioned(
              bottom: 50.0,
              right: 150.0,
              child: Container(
                width: 400.0,
                height: 400.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200.0),
                    color: Colors.pink[100].withOpacity(.5)),
              ),
            ),
            Positioned(
              bottom: 100.0,
              left: 150.0,
              child: Container(
                width: 400.0,
                height: 400.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200.0),
                    color: Colors.pink[100].withOpacity(.5)),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Text(
                    "Find\nThe Best Property",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                ),
                SizedBox(height: 18.0),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0),
                  child: Material(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: TextField(
                      controller: _txtCity,
                      style: TextStyle(fontSize: 12.0, color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon:
                              Icon(Icons.search, color: Colors.grey[400]),
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                          border: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          hintText: "Enter City or State"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:Center(
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width/2,
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).primaryColor,
                        ),
                      child: new DropdownButton(
                          iconDisabledColor: Theme.of(context).primaryColor,
                          hint: Text("Select Type", style: TextStyle(
                            color: Colors.white,
                            // backgroundColor: Colors.white,
                          )),
                        items: _apartment.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item.toString()),
                            value: item.toString(),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _apartmentSelected = newVal;
                            // print(_apartmentSelected);
                          });
                        },
                        value: _apartmentSelected,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                 child: Center(
                   child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width/2,
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).primaryColor,
                        ),
                      child: new DropdownButton(
                          iconDisabledColor: Theme.of(context).primaryColor,
                          hint: Text("Select Purpose", style: TextStyle(
                            color: Colors.white,
                            // backgroundColor: Colors.white,
                          )),
                        items: _purpose.map((items) {
                          return new DropdownMenuItem(
                            child: new Text(items.toString()),
                            value: items.toString(),
                          );
                        }).toList(),
                        onChanged: (newVal2) {
                          setState(() {
                            __purposeSelected = newVal2;
                            print(__purposeSelected);
                          });
                        },
                        value: __purposeSelected,
                      ),
                    ),
                 ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                 child: Center(
                   child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: new DropdownButton(
                         iconDisabledColor: Theme.of(context).primaryColor,
                        hint: Text("Select Bedroom", style: TextStyle(
                          color: Colors.white,
                          // backgroundColor: Colors.white,
                        )),
                        items: _bedpropertiesList.map((item) {
                          return new DropdownMenuItem(
                            
                            child: new Text(item.bedroom.toString()),
                            value: item.bedroom,
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _bedroomSelected = newVal;
                          });
                        },
                        value: _bedroomSelected,
                      ),
                    ),
                 ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width/2,
                      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: new DropdownButton(
                        iconDisabledColor: Theme.of(context).primaryColor,
                        style: TextStyle(
                          color: Colors.white,
                          // backgroundColor: Colors.white,
                        ),
                        elevation: 3,
                        hint: Text("Select Bathroom", style: TextStyle(
                          color: Colors.white,
                          // backgroundColor: Colors.white,
                        )),
                        items: _bathpropertiesList.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item.bathroom.toString()),
                            value: item.bathroom,
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _bathroomSelected = newVal;
                          });
                        },
                        value: _bathroomSelected,
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, bottom: 16.0),
                      child: Container(
                         alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width/2.5,
                        child: Material(
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          child: TextField(
                            controller: _txtMin,
                            style: TextStyle(fontSize: 12.0),
                            decoration: InputDecoration(
                                suffixIcon:
                                    Icon(Icons.attach_money, color: Colors.grey[400]),
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.0),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                                hintText: "Min Price"),
                          ),
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(
                         left: 10.0, bottom: 16.0),
                      child: Container(
                         alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width/2.5,
                        child: Material(
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          child: TextField(
                            controller: _txtMax,
                            style: TextStyle(fontSize: 12.0),
                            decoration: InputDecoration(
                                suffixIcon:
                                    Icon(Icons.attach_money, color: Colors.grey[400]),
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.0),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: outlineInputBorder,
                                hintText: "Max Price"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width/2,
                      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: new FlatButton(
                        onPressed:(){
                          search();
                        },
                       child: Text("Search")),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    ));
  }
}
