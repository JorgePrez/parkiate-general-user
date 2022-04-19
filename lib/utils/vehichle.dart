
class Vehicle {
  final int id;
  final String name;
  final String amount;
  final String image;
  final String person;
  final String distance;

  const Vehicle({this.id, this.name, this.amount, this.image, this.person, this.distance});

}

class VehicleList {
  static List<Vehicle> list() {
    const list = <Vehicle> [
      Vehicle(
        id: 1,
        name: 'Light Bike',
        amount: '150',
        image: 'assets/images/vehicle/motorbike.png',
        person: '4',
        distance: '15'
      ),
      Vehicle(
        id: 2,
        name: 'Cover Van',
          amount: '49',
          image: 'assets/images/vehicle/cover_van.png',
          person: '4',
          distance: '41'
      ),
      Vehicle(
        id: 3,
        name: 'Bus',
          amount: '149',
          image: 'assets/images/vehicle/bus.png',
          person: '4',
          distance: '36'
      ),
      Vehicle(
          id: 4,
          name: 'Heavy Bike',
          amount: '149',
          image: 'assets/images/vehicle/motorbike2.png',
          person: '4',
          distance: '36'
      ),
      Vehicle(
          id: 5,
          name: 'Truck',
          amount: '149',
          image: 'assets/images/vehicle/truck.png',
          person: '4',
          distance: '36'
      ),
      Vehicle(
          id: 6,
          name: 'Tourism',
          amount: '149',
          image: 'assets/images/vehicle/tourism.png',
          person: '4',
          distance: '36'
      ),
    ];
    return list;
  }
}