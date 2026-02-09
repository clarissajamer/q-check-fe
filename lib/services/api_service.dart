import 'dart:convert';
import 'package:q_check/models/login.dart';
// We export create_quiz.dart's Data so that files identifying Data via ApiService (like home_content.dart) work.
import 'package:q_check/models/create_quiz.dart';
export 'package:q_check/models/create_quiz.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  static const String baseUrl = 'http://127.0.0.1:8000';


  String? _token;
  int? _userId;

  Future<void> setAuthData(String token, int userId) async {
    _token = token;
    _userId = userId;
  }

  Future<void> loadAuthFromPrefs() async {
    // Mock: Do nothing or set default if needed
  }

  Future<void> logoutUser() async {
    _token = null;
    _userId = null;
  }

  // ===============================
  // LOGIN (MOCK)
  // ===============================
  Future<login?> loginUser(String serialNumber, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    // Always succeed
    return login(
      message: "Login Success (Mock)",
      token: "mock-token-abc-123",
      user: User(
        id: 1,
        username: serialNumber,
        email: "mock@example.com",
        role: "admin",
        roleId: 1,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  // ===============================
  // FETCH QUIZ (MOCK)
  // ===============================
  Future<List<Data>> fetchQuizzes({String status = 'all'}) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    // Return mock quizzes
    return [
      Data(
        id: 1,
        judul: "Mock Quiz 1 - Matematika",
        deskripsi: "Quiz Matematika Kelas 10",
        startTime: DateTime.now().toIso8601String(),
        endTime: DateTime.now().add(const Duration(hours: 2)).toIso8601String(),
        createdBy: 1,
      ),
      Data(
        id: 2,
        judul: "Mock Quiz 2 - B. Indonesia",
        deskripsi: "Latihan Soal Ujian",
        startTime: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        endTime: DateTime.now().add(const Duration(days: 1)).toIso8601String(),
        createdBy: 1,
      ),
    ];
  }

  Future<List<Data>> fetchQuizData() async {
    return fetchQuizzes();
  }

  // ===============================
  // CREATE QUIZ (MOCK)
  // ===============================
  Future<Data?> createQuiz({
    required String judul,
    String? deskripsi,
    String? startTime,
    String? endTime,
    int? createdBy,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    // Return newly created mock data
    return Data(
      id: DateTime.now().millisecondsSinceEpoch,
      judul: judul,
      deskripsi: deskripsi,
      startTime: startTime,
      endTime: endTime,
      createdBy: createdBy ?? _userId ?? 1,
      isArchived: false,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

  // ===============================
  // CREATE BANK SOAL (MOCK)
  // ===============================
  Future<Data?> createBankSoal({
    required String pertanyaan,
    required String opsiA,
    required String opsiB,
    String? opsiC,
    String? opsiD,
    required String jawabanBenar,
    required int quizId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    // Return a dummy data object indicating success
    return Data(
      id: DateTime.now().millisecondsSinceEpoch,
      // Since we are using create_quiz.Data but simulating bank soal result,
      // we technically don't have 'pertanyaan' fields here.
      // But usually the UI checks valid return (not null) for success.
      judul: "Mock Soal Created", 
    );
  }
}
