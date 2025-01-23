class Job {
  String url;
  String companyName;
  bool saved;
  String titleJob;
  String location;
  String typeWork;
  List<String> requirement;
  Job(this.url, this.companyName, this.saved, this.titleJob, this.location,
      this.typeWork, this.requirement);
  static List<Job> generateJobs() {
    return [
      Job('assets/images/google_logo.png', 'Google', false, 'Backend-Developer',
          'Nam Tu Liem - Ha Noi', 'Part time', [
        'Bachelor"s degree or equivalent practical experience.',
        '2 years of experience diagnosing and troubleshooting one of the following: operating systems and computer/server hardware or networking protocols.',
        'Experience with performing component-level repairs on IT equipment. ',
        'Ability to lift/move 50lb (23kg) of equipment and ability to exert yourself physically over extended periods of time, including frequent bending, kneeling, climbing, pushing/pulling and lifting. ',
        'Ability to work non-standard hours, including working weekends, holidays and on shift-based schedule as required. '
      ]),
      Job('assets/images/linkedin_logo.png', 'Linkedin', true,
          'Frontend-Developer', 'Ha Dong - Ha Noi', 'Full time', [
        "Bachelor's degree or equivalent practical experience.",
        "Experience diagnosing and troubleshooting one of the following: operating systems and computer/server hardware or networking protocols.",
        "Experience with performing component-level repairs on IT equipment.",
        "Ability to lift/move 50lb (23kg) of equipment and ability to exert yourself physically over extended periods of time, including frequent bending, kneeling, climbing, pushing/pulling and lifting.",
        "Ability to work non-standard hours, including working weekends, holidays and on shift-based schedule as required.",
      ]),
      Job('assets/images/airbnb_logo.png', 'Airbnb', false, 'Data Engine',
          'Cau Giay - Ha Noi', 'Part time', [
        'Bachelor"s degree or equivalent practical experience.',
        '2 years of experience diagnosing and troubleshooting one of the following: operating systems and computer/server hardware or networking protocols.',
        'Experience with performing component-level repairs on IT equipment. ',
        'Ability to lift/move 50lb (23kg) of equipment and ability to exert yourself physically over extended periods of time, including frequent bending, kneeling, climbing, pushing/pulling and lifting. ',
        'Ability to work non-standard hours, including working weekends, holidays and on shift-based schedule as required. '
      ])
    ];
  }
}
