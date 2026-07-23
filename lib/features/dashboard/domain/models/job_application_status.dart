enum JobApplicationStatus {
  applied,
  notApplied;

  static JobApplicationStatus? tryParse({
    String? applicationStatus,
    String? appliedFlag,
  }) {
    final flag = appliedFlag?.trim().toUpperCase();
    if (flag == 'Y') return JobApplicationStatus.applied;
    if (flag == 'N') return JobApplicationStatus.notApplied;

    final status = applicationStatus?.trim().toUpperCase();
    if (status == null || status.isEmpty) return null;

    return switch (status) {
      'APPLIED' => JobApplicationStatus.applied,
      'NOT_APPLIED' => JobApplicationStatus.notApplied,
      _ => null,
    };
  }
}
