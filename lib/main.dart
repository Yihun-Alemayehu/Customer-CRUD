import 'package:customer_crud/customer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BlocProvider(
      create: (context) => CustomerCubit(),
      child: const HomePage(),
    ),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _showDialog(BuildContext context, String title, Function(String) onPressed){
    String name = '';

    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(       
          title: Text(title),
          content: TextField(
            onChanged: (value) => name = value,
            decoration: InputDecoration(
              hintText: 'Enter customer name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
          ),
        );
      },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'CUSTOMER',
          style: TextStyle(
            letterSpacing: 3,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<CustomerCubit, CustomerState>(
        builder: (context, state) {
          return Column(children: [
            for (var customer in state.customers)
              Card(
                child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[900]),
                    child: Text(customer.name)),
              ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    context.read<CustomerCubit>().addCustomer(Customer(name));
                  },
                  child: const Text('Create'),
                )
              ],
            )
          ]);
        },
      ),
    );
  }
}
