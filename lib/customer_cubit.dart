
// class model for customer
class Customer {
  final String name;

  Customer(this.name);

  @override
  bool operator ==(Object other) => identical(this, other) || other is Customer && runtimeType == other.runtimeType && name == other.name;
  
  @override
  int get hashCode => name.hashCode;
  

}