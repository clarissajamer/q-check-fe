import 'package:flutter/material.dart';
import 'package:q_check/page/home_page.dart';
import 'package:q_check/page/profile_page.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFFF6DC43);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: BottomAppBar(
            color: accentColor,
            surfaceTintColor: Colors.transparent,
            height: 70,
            
            shape: const CircularNotchedRectangle(),
            
            notchMargin: 6.0, 
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, 
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.home_filled,
                      size: 30, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  HomePage(),
                      ),
                    );
                  },
                ),

                const SizedBox(width: 80), 

                IconButton(
                  icon: const Icon(Icons.person_outline,
                      size: 30, color: Colors.white),
                  onPressed: () { 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  ProfilePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}