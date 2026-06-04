import 'dart:convert';

import 'package:career_portal/features/auth/domain/models/register_education_entry.dart';
import 'package:career_portal/features/auth/domain/models/register_work_experience_entry.dart';

abstract final class RegisterJsonMapper {
  RegisterJsonMapper._();

  static String educationJson(List<RegisterEducationEntry> entries) {
    if (entries.isEmpty) return '[]';

    final payload = entries
        .map(
          (entry) => <String, dynamic>{
            'degree_name': entry.degreeName,
            'institution_name': entry.institutionName,
            'field_of_study': entry.fieldOfStudy,
            'start_date': _formatDate(entry.startDate),
            'end_date': _formatDate(entry.endDate),
            'grade': entry.grade,
            'description': entry.description,
          },
        )
        .toList();

    return jsonEncode(payload);
  }

  static String experienceJson(List<RegisterWorkExperienceEntry> entries) {
    if (entries.isEmpty) return '[]';

    final payload = entries
        .map(
          (entry) => <String, dynamic>{
            'company_name': entry.companyName,
            'job_title': entry.jobTitle,
            'location': entry.location,
            'start_date': _formatDate(entry.startDate),
            'end_date': entry.isCurrentJob
                ? null
                : (entry.endDate != null ? _formatDate(entry.endDate!) : null),
            'is_current_job': entry.isCurrentJob,
            'description': entry.description,
          },
        )
        .toList();

    return jsonEncode(payload);
  }

  static String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
