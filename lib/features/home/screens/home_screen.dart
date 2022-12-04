import 'package:flutter/material.dart';
import 'package:flutter_application/common/widgets/loader.dart';
import 'package:flutter_application/features/auth/services/auth_service.dart';
import 'package:flutter_application/features/home/services/home_services.dart';
import 'package:flutter_application/models/patients_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeServices homeServices = HomeServices();
  final AuthService authService = AuthService();

  List<Patients>? patientsList;
  List<Patients>? patientsToday = [];
  List<Patients>? patientsTomorrow = [];

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  fetchPatients() async {
    patientsList = await homeServices.fetchAllPatients(context);
    loopForPatientsToday();
    loopForPatientsTomorrow();
    setState(() {});
  }

  final int now = DateTime.now().millisecondsSinceEpoch;

  loopForPatientsToday() {
    List<Patients> listLoop = [];
    for (int i = 0; i < patientsList!.length; i++) {
      var appointmentDate = patientsList![i].at;
      if (appointmentDate < now + 86400000) {
        listLoop.add(patientsList![i]);
      }
    }

    patientsToday = listLoop;
    setState(() {});
  }

  loopForPatientsTomorrow() {
    List<Patients> listLoop = [];
    for (int i = 0; i < patientsList!.length; i++) {
      var appointmentDate = patientsList![i].at;
      if (now + 86400000 * 2 > appointmentDate &&
          appointmentDate > now + 86400000) {
        listLoop.add(patientsList![i]);
      }
    }

    patientsTomorrow = listLoop;
    setState(() {});
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Log Out',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Are you sure you want to log out from the console?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      GestureDetector(
                        onTap: () {
                          authService.logOut(context);
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return patientsList == null
        ? const Loader()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: 42,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        fit: BoxFit.cover,
                        height: 40,
                        // width: 40,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        openDialog();
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: 42,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Icon(
                          Icons.logout_outlined,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 80,
                          child: Image.asset(
                            'assets/images/doctor.jpg',
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'My Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Dr. Jon Doe',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Patient list for today',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: patientsToday!.length,
                      itemExtent: 75,
                      itemBuilder: ((context, index) {
                        final appointmentDate =
                            DateTime.fromMillisecondsSinceEpoch(
                                patientsToday![index].at);
                        final String date =
                            DateFormat('HH:mm').format(appointmentDate);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 60,
                              child: Image.asset(
                                'assets/images/patient.jpg',
                                fit: BoxFit.cover,
                                height: 60,
                                width: 60,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${patientsToday![index].firstName} ${patientsToday![index].lastName}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$date - ${patientsToday![index].patientCase}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tomorrow',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    //
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: patientsTomorrow!.length,
                      itemExtent: 75,
                      itemBuilder: ((context, index) {
                        final appointmentDate =
                            DateTime.fromMillisecondsSinceEpoch(
                                patientsTomorrow![index].at);
                        final String date =
                            DateFormat('HH:mm').format(appointmentDate);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 60,
                              child: Image.asset(
                                'assets/images/patient.jpg',
                                fit: BoxFit.cover,
                                height: 60,
                                width: 60,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${patientsTomorrow![index].firstName} ${patientsTomorrow![index].lastName}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$date - ${patientsTomorrow![index].patientCase}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
