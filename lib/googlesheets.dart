import 'package:gsheets/gsheets.dart';
import 'package:remake_storedata_to_spreadsheet/sheetscolumn.dart';

class SheetsFlutter {
  static String _sheetId = "1dcLL2mOzE8QCqdrntTAuXDazEdtR2f5DT3_pPNhQWKQ";
  static const _sheetCredentials = r'''
{
  "type": "service_account",
  "project_id": "activityrecordsmi",
  "private_key_id": "e7e64a9723e7aea5f56e12664e0221b27ca78d54",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDC77KjRf4kR/A5\nxQr8SYSAv9uETng2NXirnWZQlx7agpjCovjegT7tuENKqp6gsEZqR+HtIJY7nUwV\nTKzOwSDOvIYxs1dK1jWxMiOt4LF4ahxwm0HTfNoEyos84FhKAujZPgXZtx/tpmdy\nai4oGQq0/ADmlWMF/yTPvwQcOr6fYtX7iZ3FnOxao0nKHxGs8XInGdDoPBi+Iv+b\nQ9twhWE0va2/yrUMrU4hxqBkzSs6ExVkxBIGUXf5FEintOxl/mFF+BNsDjEvP+u7\nMbm+C6EGfzBFCvtfYMZjELdDkzHGj84aqELqZVawsU0r6aGwjOBgzNLJeUxjkG92\nFWnqEzsVAgMBAAECggEAB8pCbknuxQ5m6Dgan0hk1ixUnm3wWeI7J0iL/S582iib\n6DNRFLs/g4p4jfRRkIRa3AZxXeOOfWVk0/kTctO+9uQLzNKo62GyFZm2WU2Aahp7\ndniN4eC8abKaa91fSd3h5kSXQUMTMJEU0zqxC4MsrVzgwFY59dRjaTXt+R7T3VSo\n8qSijKyvy6M7z9iQTskQE7opA56bBWpMahoROMiXAr2IJm/XECZyYEuxzQZc/HAE\npmwQJ1DBGp09x6HKb9aSBA789BpW3jjiWx009qUbq+silnrOr1XZZgODyefoiygh\n7GYZr0TO3+wfA1GVHP2MhyNqq3BYzVHJJPU9XSKKJQKBgQDkNqErLxa/AJyNjsZC\najcMqotslI+URUnsEJmhjDd4I7I/e3QPCWM51u3UG+3xp6/KVROtEnC5s2g88Wnk\nDxKmbpWSLLBNFitOtu77ifdmyE3BcUzHr4CIBR9FyALHIzc39wjowdtAX+qYcpIM\nvyQsGq/gGIcCYrEO5f74T2cufwKBgQDaq9Pm4H7l3eJtV48kXUd1iaGTXWNXBH9c\nbAXhpAFL9FoHu7BU4jNyvcprcc/gpC1tCMbq7VZ8194/0uCUQIk3BEAYvzEHImQG\nfG9O4kHxOSEPRJo2/xjEfVQW7XghnVE/YqrHy2+VaczFyWmGa6BFjoyYF/hscWuA\nWxI1jP80awKBgEQbxbfkos44OYDJ1oOlvW4rS9cI81zV3Pz161PaTAev55eomXeP\nXqy5Z1tBRp8zY3RoNaoWccwKLhbaGbc1hGRlZoAslCU9c4lXcTVi9JIZP5N24+pI\nh3yQwseJrMKP0QAD2wXULUImHhaHQu1I8luzTz/7MffVSnBe1dx3nhyzAoGAKCLT\nwRPBlvV0AvfISTdpz1QUuRSyEB2+NruJFNJifot6HuM/SUU/hjb5uWDpc+UOhW3P\n/PzVHBMPMw3EtNFnnhaEoUYufI2+aEZcs9Dpo5oFzGSeHawS4rXSQmcR3rGeYRD+\nIa/gaj9CG6eNW+PTRhEVEzGLInRq8+NDY1re2MMCgYBql3zY0jsAl0VImTurXhQa\n/jgMkg2l/mTpHIrzJ6oujqEsUU+dRGOTU2rktmNdedbVMRU4nxrDNfhA/QZ9Pvih\n2UrBWXOFpa/zWx30UZmF+yNavPjXkGDSTvhOhJ8XE9I1p+gG5y3vHj2J/DV387k8\nDts+fL0Tg+3WYISE2K4dGw==\n-----END PRIVATE KEY-----\n",
  "client_email": "smisheets@activityrecordsmi.iam.gserviceaccount.com",
  "client_id": "100249727196644006281",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/smisheets%40activityrecordsmi.iam.gserviceaccount.com"
}
''';
  static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_sheetId);

      _userSheet = await _getWorkSheet(spreadsheet, title: "record");
      final firstRow = SheetsColumn.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print(e);
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }
}
