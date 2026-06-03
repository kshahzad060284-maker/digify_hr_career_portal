import 'package:career_portal/features/dashboard/domain/models/dashboard_job.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_filters_controller.dart';
import 'package:career_portal/features/dashboard/presentation/providers/dashboard_job_search_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _mockJobs = [
  DashboardJob(
    id: '1',
    title: 'Senior Software Engineer',
    department: 'Engineering',
    location: 'San Francisco, CA',
    employmentType: 'Full-time • Hybrid',
    description:
        'We are seeking an experienced Senior Software Engineer to join our platform team.',
    responsibilities: [
      'Lead the design and development of scalable solutions',
      'Collaborate with cross-functional teams to deliver high-quality products',
      'Mentor junior team members and contribute to technical excellence',
      'Participate in code reviews and architectural discussions',
      'Drive innovation and continuous improvement initiatives',
    ],
    qualifications: [
      '5+ years of relevant experience',
      "Bachelor's degree in related field or equivalent experience",
      'Strong technical skills and problem-solving abilities',
      'Excellent communication and collaboration skills',
      'Passion for learning and professional growth',
    ],
    salaryRange: r'$140k - $180k',
    startDate: 'June 1, 2026',
    level: 'L5',
    contactEmail: 'careers@company.com',
    openingsCount: 2,
    isUrgent: true,
  ),
  DashboardJob(
    id: '2',
    title: 'UX Designer',
    department: 'Design',
    location: 'Austin, TX',
    employmentType: 'Full-time • Hybrid',
    description:
        'Seeking a creative UX Designer to enhance our user experience.',
    responsibilities: [
      'Create user-centered designs for web and mobile applications',
      'Conduct user research and usability testing',
      'Collaborate with product and engineering teams',
      'Maintain and evolve the design system',
      'Present design concepts to stakeholders',
    ],
    qualifications: [
      '3+ years of UX design experience',
      'Strong portfolio demonstrating design process',
      'Proficiency in Figma and prototyping tools',
      'Understanding of accessibility best practices',
      'Excellent visual design and communication skills',
    ],
    salaryRange: r'$90k - $120k',
    startDate: 'July 15, 2026',
    level: 'L4',
    contactEmail: 'careers@company.com',
    openingsCount: 1,
    isUrgent: true,
  ),
];

final dashboardAllJobsProvider = Provider<List<DashboardJob>>((ref) {
  return _mockJobs;
});

final dashboardJobLocationsProvider = Provider<List<String>>((ref) {
  final jobs = ref.watch(dashboardAllJobsProvider);
  return jobs.map((job) => job.location).toSet().toList()..sort();
});

final dashboardFilteredJobsProvider = Provider<List<DashboardJob>>((ref) {
  final jobs = ref.watch(dashboardAllJobsProvider);
  final search = ref.watch(dashboardJobSearchControllerProvider);
  final filters = ref.watch(dashboardFiltersControllerProvider);
  final query = search.debouncedQuery.toLowerCase();

  return jobs.where((job) {
    final matchesSearch =
        query.isEmpty ||
        job.title.toLowerCase().contains(query) ||
        job.department.toLowerCase().contains(query) ||
        job.description.toLowerCase().contains(query);

    final matchesLocation =
        filters.isAllLocations || job.location == filters.selectedLocation;

    return matchesSearch && matchesLocation;
  }).toList();
});
