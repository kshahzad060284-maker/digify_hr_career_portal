import 'package:career_portal/features/enterprise_context/domain/models/enterprise_context.dart';
import 'package:career_portal/features/enterprise_context/domain/repositories/enterprise_context_repository.dart';

class GetEnterpriseContextUseCase {
  const GetEnterpriseContextUseCase(this._repository);

  final EnterpriseContextRepository _repository;

  Future<EnterpriseContext> call() => _repository.getEnterpriseContext();
}
