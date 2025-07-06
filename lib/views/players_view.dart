import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../controllers/players_controller.dart';
import '../models/player_model.dart';

class PlayersView extends StatelessWidget {
  final PlayersController playersController = Get.find<PlayersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KKR Players'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildPositionFilter(),
          Expanded(
            child: Obx(() {
              if (playersController.isLoading.value) {
                return Center(
                  child: SpinKitFadingCircle(color: Color(0xFF512B7C)),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: playersController.filteredPlayers.length,
                itemBuilder: (context, index) {
                  final player = playersController.filteredPlayers[index];
                  return _buildPlayerCard(player);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPositionFilter() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: PlayersController.positions.length,
        itemBuilder: (context, index) {
          final position = PlayersController.positions[index];
          return Obx(() {
            final isSelected = position == playersController.selectedPosition.value;
            return GestureDetector(
              onTap: () => playersController.filterByPosition(position),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF512B7C) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  position[0].toUpperCase() + position.substring(1).replaceAll('-', ' '),
                  style: TextStyle(
                    color: isSelected ? Color(0xFFFFD700) : Colors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildPlayerCard(PlayerModel player) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Player Avatar
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFF512B7C),
                  child: Text(
                    player.name.split(' ').map((n) => n[0]).take(2).join(),
                    style: TextStyle(
                      color: Color(0xFFFFD700),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        player.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF512B7C),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${player.position.toUpperCase()} • ${player.nationality}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Age: ${player.age}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Batting Style:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(player.battingStyle),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bowling Style:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Flexible(
                        child: Text(
                          player.bowlingStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            // Stats Section
            if (player.stats.isNotEmpty)
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF512B7C).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: player.stats.entries.map((stat) => Column(
                    children: [
                      Text(
                        stat.value.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF512B7C),
                        ),
                      ),
                      Text(
                        stat.key.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )).toList(),
                ),
              ),
            SizedBox(height: 12),
            // Connect Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => playersController.connectWithPlayer(player.socialMediaHandle),
                icon: Icon(Icons.link),
                label: Text('Connect on Social Media'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD700),
                  foregroundColor: Color(0xFF512B7C),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}