import 'package:flutter/material.dart';
// import 'package:fypapp/widgets/constant.dart';
import 'package:get/get.dart';
import 'package:glamify/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final Constant constant = Constant();
  List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recentSearches') ?? [];
    });
  }

  Future<void> _addSearch(String search) async {
    if (search.isNotEmpty && !recentSearches.contains(search)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        recentSearches.add(search);
      });
      await prefs.setStringList('recentSearches', recentSearches);
    }
  }

  Future<void> _removeSearch(String search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches.remove(search);
    });
    await prefs.setStringList('recentSearches', recentSearches);
  }

  Future<void> clearRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches.clear();
    });
    await prefs.remove('recentSearches');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 5),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: constant.primaryColor,
                        )),
                    Text("Search",
                        style: GoogleFonts.manrope(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 20), // For balance
                  ],
                ),
                const SizedBox(height: 18),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search salon or service..",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black54),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onSubmitted: (value) {
                      _addSearch(value);
                    },
                    onTap: () {
                      setState(() {}); // Refresh the state to show recent searches
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent",
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        onTap: clearRecentSearches,
                        child: Text(
                          "Clear All",
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: constant.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                recentSearches.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: recentSearches.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.history, color: Colors.grey),
                                  title: Text(
                                    recentSearches[index],
                                    style: GoogleFonts.manrope(
                                      fontSize: 16,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.clear, color: Colors.grey),
                                    onPressed: () {
                                      _removeSearch(recentSearches[index]);
                                    },
                                  ),
                                  onTap: () {
                                    // Handle search action when tapping on a recent item
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: Text(
                            "No recent searches",
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
