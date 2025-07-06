import 'package:get/get.dart';
import '../models/match_model.dart';

class MatchesController extends GetxController {
  var isLoading = true.obs;
  var matches = <MatchModel>[].obs;
  var upcomingMatches = <MatchModel>[].obs;
  var completedMatches = <MatchModel>[].obs;

  @override
  void onInit() {
    loadMatches();
    super.onInit();
  }

  void loadMatches() {
    isLoading.value = true;
    
    // Mock data for KKR matches
    final matchList = [
      MatchModel(
        id: '1',
        opponent: 'Mumbai Indians',
        opponentLogo: 'https://via.placeholder.com/50x50?text=MI',
        matchDate: DateTime.now().add(Duration(days: 7)),
        venue: 'Eden Gardens, Kolkata',
        matchType: 'IPL 2024',
        status: 'upcoming',
      ),
      MatchModel(
        id: '2',
        opponent: 'Chennai Super Kings',
        opponentLogo: 'https://via.placeholder.com/50x50?text=CSK',
        matchDate: DateTime.now().add(Duration(days: 14)),
        venue: 'M.A. Chidambaram Stadium',
        matchType: 'IPL 2024',
        status: 'upcoming',
      ),
      MatchModel(
        id: '3',
        opponent: 'Royal Challengers Bangalore',
        opponentLogo: 'https://via.placeholder.com/50x50?text=RCB',
        matchDate: DateTime.now().subtract(Duration(days: 3)),
        venue: 'Eden Gardens, Kolkata',
        matchType: 'IPL 2024',
        status: 'completed',
        result: 'KKR Won by 6 wickets',
        kkrScore: 178,
        opponentScore: 175,
      ),
      MatchModel(
        id: '4',
        opponent: 'Delhi Capitals',
        opponentLogo: 'https://via.placeholder.com/50x50?text=DC',
        matchDate: DateTime.now().subtract(Duration(days: 10)),
        venue: 'Arun Jaitley Stadium',
        matchType: 'IPL 2024',
        status: 'completed',
        result: 'DC Won by 4 runs',
        kkrScore: 172,
        opponentScore: 176,
      ),
    ];

    matches.value = matchList;
    upcomingMatches.value = matchList.where((match) => match.status == 'upcoming').toList();
    completedMatches.value = matchList.where((match) => match.status == 'completed').toList();
    isLoading.value = false;
  }

  void refreshMatches() {
    loadMatches();
  }
}