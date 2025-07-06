import 'package:get/get.dart';
import '../models/player_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PlayersController extends GetxController {
  var isLoading = true.obs;
  var players = <PlayerModel>[].obs;
  var selectedPosition = 'all'.obs;

  static final List<String> positions = [
    'all',
    'batsman',
    'bowler',
    'all-rounder',
    'wicket-keeper',
  ];

  @override
  void onInit() {
    loadPlayers();
    super.onInit();
  }

  void loadPlayers() {
    isLoading.value = true;
    
    // Mock data for KKR players
    final playerList = [
      PlayerModel(
        id: '1',
        name: 'Shreyas Iyer',
        profileImage: 'https://via.placeholder.com/150x150?text=Shreyas',
        position: 'batsman',
        nationality: 'India',
        age: 29,
        battingStyle: 'Right-handed',
        bowlingStyle: 'Right-arm off break',
        stats: {'matches': 50, 'runs': 1245, 'average': 32.5},
        socialMediaHandle: '@ShreyasIyer15',
      ),
      PlayerModel(
        id: '2',
        name: 'Andre Russell',
        profileImage: 'https://via.placeholder.com/150x150?text=Russell',
        position: 'all-rounder',
        nationality: 'West Indies',
        age: 35,
        battingStyle: 'Right-handed',
        bowlingStyle: 'Right-arm fast-medium',
        stats: {'matches': 75, 'runs': 1890, 'wickets': 45},
        socialMediaHandle: '@Russell12A',
      ),
      PlayerModel(
        id: '3',
        name: 'Sunil Narine',
        profileImage: 'https://via.placeholder.com/150x150?text=Narine',
        position: 'all-rounder',
        nationality: 'West Indies',
        age: 35,
        battingStyle: 'Left-handed',
        bowlingStyle: 'Right-arm off break',
        stats: {'matches': 120, 'wickets': 145, 'runs': 890},
        socialMediaHandle: '@SunilPNarine74',
      ),
      PlayerModel(
        id: '4',
        name: 'Nitish Rana',
        profileImage: 'https://via.placeholder.com/150x150?text=Rana',
        position: 'batsman',
        nationality: 'India',
        age: 30,
        battingStyle: 'Left-handed',
        bowlingStyle: 'Right-arm off break',
        stats: {'matches': 80, 'runs': 2100, 'average': 28.5},
        socialMediaHandle: '@NitishRana_27',
      ),
    ];

    players.value = playerList;
    isLoading.value = false;
  }

  void filterByPosition(String position) {
    selectedPosition.value = position;
  }

  List<PlayerModel> get filteredPlayers {
    if (selectedPosition.value == 'all') {
      return players;
    }
    return players.where((player) => player.position == selectedPosition.value).toList();
  }

  Future<void> connectWithPlayer(String socialHandle) async {
    final url = 'https://twitter.com/${socialHandle.replaceAll('@', '')}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar('Error', 'Could not open social media link');
    }
  }
}