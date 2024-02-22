class UserModel {
  late String gender;
  late Name name;
  late Location location;
  late String email;
  late Dob dob;
  late Registered registered;
  late String phone;
  late String cell;
  late Id id;
  late Picture picture;
  late String nat;

  UserModel({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.dob,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.id,
    required this.picture,
    required this.nat,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'] ?? "";
    name = Name.fromJson(json['name']);
    location = Location.fromJson(json['location']);
    email = json['email'] ?? "";
    dob = Dob.fromJson(json['dob']);
    registered = Registered.fromJson(json['registered']);
    phone = json['phone'] ?? "";
    cell = json['cell'] ?? "";
    id = Id.fromJson(json['id']);
    picture = Picture.fromJson(json['picture']);
    nat = json['nat'] ?? "";
  }
}

class Name {
  late String title;
  late String first;
  late String last;

  Name({required this.title, required this.first, required this.last});

  Name.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    first = json['first'] ?? "";
    last = json['last'] ?? "";
  }
}

class Location {
  late Street street;
  late String city;
  late String state;
  late String country;
  late dynamic postcode;
  late Coordinates coordinates;
  late Timezone timezone;

  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  Location.fromJson(Map<String, dynamic> json) {
    street = Street.fromJson(json['street']);
    city = json['city'] ?? "";
    state = json['state'] ?? "";
    country = json['country'] ?? "";
    postcode = json['postcode'] ?? 0;
    coordinates = Coordinates.fromJson(json['coordinates']);
    timezone = Timezone.fromJson(json['timezone']);
  }
}

class Street {
  late int number;
  late String name;

  Street({required this.number, required this.name});

  Street.fromJson(Map<String, dynamic> json) {
    number = json['number'] ?? 0;
    name = json['name'] ?? "";
  }
}

class Coordinates {
  late String latitude;
  late String longitude;

  Coordinates({required this.latitude, required this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'] ?? "";
    longitude = json['longitude'] ?? "";
  }
}

class Timezone {
  late String offset;
  late String description;

  Timezone({required this.offset, required this.description});

  Timezone.fromJson(Map<String, dynamic> json) {
    offset = json['offset'] ?? "";
    description = json['description'] ?? "";
  }
}

class Dob {
  late String date;
  late int age;

  Dob({required this.date, required this.age});

  Dob.fromJson(Map<String, dynamic> json) {
    date = json['date'] ?? "";
    age = json['age'] ?? 0;
  }
}

class Registered {
  late String date;
  late int age;

  Registered({required this.date, required this.age});

  Registered.fromJson(Map<String, dynamic> json) {
    date = json['date'] ?? "";
    age = json['age'] ?? 0;
  }
}

class Id {
  late String name;
  late String value;

  Id({required this.name, required this.value});

  Id.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    value = json['value'] ?? "";
  }
}

class Picture {
  late String large;
  late String medium;
  late String thumbnail;

  Picture({required this.large, required this.medium, required this.thumbnail});

  Picture.fromJson(Map<String, dynamic> json) {
    large = json['large'] ?? "";
    medium = json['medium'] ?? "";
    thumbnail = json['thumbnail'] ?? "";
  }
}
