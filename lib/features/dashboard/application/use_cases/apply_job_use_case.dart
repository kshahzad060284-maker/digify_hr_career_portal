import 'package:career_portal/features/dashboard/domain/models/apply_job_input.dart';
import 'package:career_portal/features/dashboard/domain/repositories/job_postings_repository.dart';

class ApplyJobUseCase {
  const ApplyJobUseCase(this._repository);

  final JobPostingsRepository _repository;

  Future<void> call(ApplyJobInput input) => _repository.applyForJob(input);
}
