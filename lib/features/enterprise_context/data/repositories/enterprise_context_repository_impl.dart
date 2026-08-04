import 'package:career_portal/features/enterprise_context/data/datasources/enterprise_context_remote_data_source.dart';
import 'package:career_portal/features/enterprise_context/domain/models/enterprise_context.dart';
import 'package:career_portal/features/enterprise_context/domain/repositories/enterprise_context_repository.dart';

class EnterpriseContextRepositoryImpl implements EnterpriseContextRepository {
  const EnterpriseContextRepositoryImpl({
    required EnterpriseContextRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final EnterpriseContextRemoteDataSource _remoteDataSource;

  @override
  Future<EnterpriseContext> getEnterpriseContext() async {
    final dto = await _remoteDataSource.getEnterpriseContext();
    return dto.toDomain();
  }
}
