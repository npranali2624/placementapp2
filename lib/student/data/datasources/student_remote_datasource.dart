// TODO: implement API calls for student operations
class StudentRemoteDatasource {
  Future<Map<String, dynamic>> getStudentProfile(String studentId) async {
    throw UnimplementedError();
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    throw UnimplementedError();
  }

  Future<void> applyForJob({
    required String jobId,
    required Map<String, dynamic> applicationData,
  }) async {
    throw UnimplementedError();
  }

  Future<List<Map<String, dynamic>>> getOpenings() async {
    throw UnimplementedError();
  }
}