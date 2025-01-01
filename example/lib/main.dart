import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gqlflutter;
import 'package:http/http.dart' as http;
import 'package:loggycian_flutter/loggycian_flutter.dart';

/// Example showcasing Loggycian integration with multiple HTTP clients.
///
/// This example demonstrates how to:
/// 1. Set up Loggycian with Flutter
/// 2. Integrate with Dio, HTTP, and GraphQL clients
/// 3. Handle multiple concurrent API calls
/// 4. Implement best practices for network logging
///
/// To use Loggycian in your project:
/// ```dart
/// void main() {
///   runApp(
///     Loggycian(
///       app: YourApp(),
///     ),
///   );
/// }
/// ```

/// Configuration for API endpoints used in this example
class ApiConfig {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String graphqlUrl = 'https://countries.trevorblades.com/';
  static const String postsEndpoint = '/posts';
}

/// Demonstrates best practices for API service implementation with Loggycian
///
/// Key features:
/// * Dio integration with [DioInterceptor]
/// * HTTP client with [HttpInterceptor]
/// * GraphQL client with [GqlInterceptor]
///
/// Usage:
/// ```dart
/// final apiService = ApiService();
/// final results = await apiService.fetchAllData();
/// ```
class ApiService {
  final Dio _dio;
  final http.Client _httpClient;
  final gqlflutter.GraphQLClient _graphQLClient;

  /// Creates an [ApiService] with properly configured interceptors.
  ///
  /// Each client is initialized with its respective Loggycian interceptor:
  /// - Dio uses [DioInterceptor]
  /// - HTTP client uses [HttpInterceptor]
  /// - GraphQL client uses [GqlInterceptor]
  ApiService()
    : _dio = Dio()..interceptors.add(DioInterceptor()),
      _httpClient = HttpInterceptor(http.Client()),
      _graphQLClient = gqlflutter.GraphQLClient(
        cache: gqlflutter.GraphQLCache(),
        link: GqlInterceptor(gqlflutter.HttpLink(ApiConfig.graphqlUrl)),
      );

  Future<List<String>> fetchAllData() async {
    final List<dynamic> responses = await Future.wait([
      _fetchDioPosts(),
      _fetchHttpPosts(),
      _fetchGraphQLCountries(),
    ]);

    final List<String> dioPosts = responses[0] as List<String>;
    final List<String> httpPosts = responses[1] as List<String>;
    final String graphqlResponse = responses[2] as String;

    return [...dioPosts, ...httpPosts, graphqlResponse];
  }

  Future<List<String>> _fetchDioPosts() async {
    List<Future<Response>> futures = List.generate(
      4,
      (i) =>
          _dio.get('${ApiConfig.baseUrl}${ApiConfig.postsEndpoint}/${i + 1}'),
    );
    final responses = await Future.wait(futures);
    return responses.map((response) => response.data.toString()).toList();
  }

  Future<List<String>> _fetchHttpPosts() async {
    List<Future<http.Response>> futures = List.generate(
      4,
      (i) => _httpClient.get(
        Uri.parse('${ApiConfig.baseUrl}${ApiConfig.postsEndpoint}/${i + 1}'),
      ),
    );
    final responses = await Future.wait(futures);
    return responses.map((response) => response.body).toList();
  }

  Future<String> _fetchGraphQLCountries() async {
    final options = gqlflutter.QueryOptions(
      document: gqlflutter.gql("""
        query GetCountries {
          countries {
            code
            name
          }
        }
      """),
      fetchPolicy: gqlflutter.FetchPolicy.noCache,
      cacheRereadPolicy: gqlflutter.CacheRereadPolicy.ignoreAll,
    );
    final result = await _graphQLClient.query(options);
    return result.data.toString();
  }
}

/// Example Flutter application demonstrating Loggycian integration
///
/// This application shows:
/// 1. Proper widget tree setup with [Loggycian]
/// 2. Real-world API calls with different HTTP clients
/// 3. Network logging visualization
void main() {
  runApp(const MainApp());
}

/// Navigator Key for Loggycian
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Loggycian(app: Scaffold(body: Center(child: ApiCaller()))),
    );
  }
}

class ApiCaller extends StatefulWidget {
  const ApiCaller({super.key});

  @override
  State<StatefulWidget> createState() => _ApiCallerState();
}

class _ApiCallerState extends State<ApiCaller> {
  final ApiService _apiService = ApiService();
  late Future<List<String>> _apiFuture;

  @override
  void initState() {
    super.initState();
    _apiFuture = _apiService.fetchAllData();
  }

  void _refreshApis() {
    setState(() {
      _apiFuture = _apiService.fetchAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: _apiFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No data found');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(snapshot.data![index]));
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshApis,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
