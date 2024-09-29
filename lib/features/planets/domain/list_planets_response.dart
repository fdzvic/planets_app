import 'dart:convert';

class ListPlanetsResponse {
  String? msg;
  List<Planet>? data;

  ListPlanetsResponse({
    this.msg,
    this.data,
  });

  factory ListPlanetsResponse.fromRawJson(String str) =>
      ListPlanetsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListPlanetsResponse.fromJson(Map<String, dynamic> json) =>
      ListPlanetsResponse(
        msg: json["msg"],
        data: json["data"] != null
            ? List<Planet>.from(json["data"].map((x) => Planet.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : null,
      };
}

class Planet {
  String? name;
  int? orbitalDistanceKm;
  int? equatorialRadiusKm;
  dynamic volumeKm3;
  String? massKg;
  num? densityGCm3;
  num? surfaceGravityMS2;
  int? escapeVelocityKmh;
  num? dayLengthEarthDays;
  num? yearLengthEarthDays;
  int? orbitalSpeedKmh;
  String? atmosphereComposition;
  int? moons;
  String? image;
  String? description;
  int? yearLengthEarthYears;

  Planet({
    this.name,
    this.orbitalDistanceKm,
    this.equatorialRadiusKm,
    this.volumeKm3,
    this.massKg,
    this.densityGCm3,
    this.surfaceGravityMS2,
    this.escapeVelocityKmh,
    this.dayLengthEarthDays,
    this.yearLengthEarthDays,
    this.orbitalSpeedKmh,
    this.atmosphereComposition,
    this.moons,
    this.image,
    this.description,
    this.yearLengthEarthYears,
  });

  factory Planet.fromRawJson(String str) => Planet.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Planet.fromJson(Map<String, dynamic> json) => Planet(
        name: json["name"],
        orbitalDistanceKm: json["orbital_distance_km"],
        equatorialRadiusKm: json["equatorial_radius_km"],
        volumeKm3: json["volume_km3"],
        massKg: json["mass_kg"],
        densityGCm3: json["density_g_cm3"],
        surfaceGravityMS2: json["surface_gravity_m_s2"],
        escapeVelocityKmh: json["escape_velocity_kmh"],
        dayLengthEarthDays: json["day_length_earth_days"],
        yearLengthEarthDays: json["year_length_earth_days"],
        orbitalSpeedKmh: json["orbital_speed_kmh"],
        atmosphereComposition: json["atmosphere_composition"],
        moons: json["moons"],
        image: json["image"],
        description: json["description"],
        yearLengthEarthYears: json["year_length_earth_years"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "orbital_distance_km": orbitalDistanceKm,
        "equatorial_radius_km": equatorialRadiusKm,
        "volume_km3": volumeKm3,
        "mass_kg": massKg,
        "density_g_cm3": densityGCm3,
        "surface_gravity_m_s2": surfaceGravityMS2,
        "escape_velocity_kmh": escapeVelocityKmh,
        "day_length_earth_days": dayLengthEarthDays,
        "year_length_earth_days": yearLengthEarthDays,
        "orbital_speed_kmh": orbitalSpeedKmh,
        "atmosphere_composition": atmosphereComposition,
        "moons": moons,
        "image": image,
        "description": description,
        "year_length_earth_years": yearLengthEarthYears,
      };
}
