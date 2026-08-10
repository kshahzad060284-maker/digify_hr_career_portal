import 'package:career_portal/features/dashboard/domain/models/employer_assignment_type.dart';
import 'package:career_portal/features/dashboard/domain/models/job_company_info.dart';
import 'package:career_portal/features/dashboard/domain/repositories/job_postings_repository.dart';

class GetEmployerInfoUseCase {
  const GetEmployerInfoUseCase(this._repository);

  final JobPostingsRepository _repository;

  Future<JobCompanyInfo> call({
    required int enterpriseId,
    EmployerAssignmentType assignmentType =
        EmployerAssignmentType.enterpriseLevel,
  }) {
    return _repository.getEmployerInfo(
      enterpriseId: enterpriseId,
      assignmentType: assignmentType,
    );
  }
}
