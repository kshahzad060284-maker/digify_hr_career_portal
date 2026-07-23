import 'package:career_portal/features/applications/presentation/controllers/candidate_applications_controller.dart';
import 'package:career_portal/features/applications/presentation/state/candidate_applications_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'candidate_applications_di_provider.dart';

final candidateApplicationsControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      CandidateApplicationsController,
      CandidateApplicationsState
    >(CandidateApplicationsController.new);
