import 'package:customer_crud/customer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => CustomerCubit(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showDialog(
      BuildContext context, String title, void Function(String) onPressed) {
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
                    borderRadius: BorderRadius.circular(10))),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onPressed(name);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var customer in state.customers)
                  Card(
                    child: Container(
                        height: 50,
                        width: 300,
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100]),
                        child: Text(customer.name)),
                  ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showDialog(context, 'Create Customer', (name) {
                            context
                                .read<CustomerCubit>()
                                .addCustomer(Customer(name));
                            // Navigator.of(context).pop();
                          });
                        },
                        child: const Text('Create'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showDialog(context, 'Update Customer', (name) {
                            final customer = state.customers.isNotEmpty
                                ? state.customers[0]
                                : null;
                            if (customer != null) {
                              customer.name = name;
                              context
                                  .read<CustomerCubit>()
                                  .updateCustomer(customer);
                              // Navigator.of(context).pop();
                            }
                          });
                        },
                        child: const Text('Update'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showDialog(context, 'Delete Customer', (name) {
                            final customer = state.customers.isNotEmpty
                                ? state.customers[0]
                                : null;
                            if (customer != null) {
                              context
                                  .read<CustomerCubit>()
                                  .deleteCustomer(customer);
                              // Navigator.of(context).pop();
                            }
                          });
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                )
              ]);
        },
      ),
    );
  }
}
