import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funlife/apiServices/getAllUsers.dart';
import 'package:funlife/constants.dart';
import 'package:funlife/models/userModel.dart';
import 'package:funlife/screens/viset_user_profile.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<User> allUsers = [];
  GetUsersInfo usersInfo = GetUsersInfo();
//------------------------------------------------------------------------------
  getAllUsers() async {
    for (var item in await usersInfo.getAllUsers()) {
      allUsers.add(item);
    }
  }

  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Brother and Sisters remember \"AlAh\" When you Do your Search, Search only about your friends or about good things",
                  style: TextStyle(letterSpacing: 1.2, fontSize: 16),
                ),
              ),
              FlatButton(
                color: kMainColor,
                textColor: Colors.white,
                onPressed: () async {
                  showSearch(
                      context: context,
                      delegate: DataSearch(allUsers: allUsers));
                },
                child: Text("I understand, Start Now"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  List<User> allUsers;
  DataSearch({this.allUsers});
  User searchedUser;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return VisitProfile(
      searchedUser: searchedUser,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<User> searchList = allUsers
        .where((p) => p.userName.startsWith(query.toLowerCase()))
        .toList();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: query == ""
          ? Container()
          : ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchList[index].userName),
                  leading: CircleAvatar(
                    backgroundColor: kMainColor,
                    backgroundImage: searchList[index].userProfileImageUrL !=
                            null
                        ? NetworkImage(searchList[index].userProfileImageUrL)
                        : null,
                  ),
                  onTap: () {
                    query = searchList[index].userName;
                    searchedUser = searchList[index];

                    showResults(context);
                  },
                );
              },
              itemCount: searchList.length,
            ),
    );
  }
}
