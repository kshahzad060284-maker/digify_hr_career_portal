import 'package:career_portal/features/offers/presentation/controllers/candidate_offers_controller.dart';
import 'package:career_portal/features/offers/presentation/state/candidate_offers_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final candidateOffersControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      CandidateOffersController,
      CandidateOffersState
    >(CandidateOffersController.new);
