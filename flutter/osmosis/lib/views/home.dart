import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:osmosis/widgets/diffusion_image.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<String> generate(String query) async {
    Response response;
    var dio = Dio();
    try {
      response = await dio.get('http://localhost:8000/?image_query=$query');
      if (response.statusCode != 200) {
        throw Exception("Something went wrong!");
      }
      debugPrint(response.data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Tooltip(
          message: "v1.0.0",
          child: Text("Osmosis"),
        ),
      ),
      body: FutureBuilder(
        initialData: null,
        future: generate("optimus%20prime%20fighting%20vladamir%20putin"),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return DiffuseImage(data: snapshot.data);
          } else {
            return const CircularProgressIndicator(
              color: Colors.indigo,
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: AnimSearchBar(
        helpText: "What monstrosity would you like to create?",
        color: Colors.white54,
        closeSearchOnSuffixTap: true,
        autoFocus: true,
        width: 600,
        style: const TextStyle(
            color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w700),
        rtl: false,
        animationDurationInMilli: 100,
        textController: _textController,
        onSuffixTap: () {},
      ),
    );
  }
}
