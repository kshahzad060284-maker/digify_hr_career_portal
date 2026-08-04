import 'package:career_portal/features/enterprise_context/domain/models/enterprise_context.dart';

abstract class EnterpriseContextRepository {
  Future<EnterpriseContext> getEnterpriseContext();
}
