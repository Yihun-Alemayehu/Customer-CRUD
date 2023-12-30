import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// class model for customer
class Customer {
  late final String name;

  Customer(this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Customer &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

//customer state
class CustomerState extends Equatable {
  final List<Customer> customers;

  const CustomerState(this.customers);

  @override
  List<Object?> get props => [customers];
}

//abstract class for customer event
abstract class CustomerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// customer event
class AddCustomerEvent extends CustomerEvent {
  final Customer customer;

  AddCustomerEvent(this.customer);

  @override
  List<Object?> get props => [customer];
}

class UpdateCustomerEvent extends CustomerEvent {
  final Customer customer;

  UpdateCustomerEvent(this.customer);

  @override
  List<Object?> get props => [customer];
}

class DeleteCustomerEvent extends CustomerEvent {
  final Customer customer;

  DeleteCustomerEvent(this.customer);

  @override
  List<Object?> get props => [customer];
}

//customer Cubit
class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(const CustomerState([]));

  void addCustomer(Customer customer) {
    emit(CustomerState(List.from(state.customers)..add(customer)));
  }

  void updateCustomer(Customer customer) {
    final updatedCustomer = List<Customer>.from(state.customers);
    final index = updatedCustomer.indexWhere((element) => element == customer);

    if (index != -1) {
      updatedCustomer[index] = customer;
      emit(CustomerState(updatedCustomer));
    }
  }

  void deleteCustomer(Customer customer) {
    final updatedCustomer = List<Customer>.from(state.customers);
    updatedCustomer.remove(customer);
    emit(CustomerState(updatedCustomer));
  }
}
