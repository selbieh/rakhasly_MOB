class PreviosDrivingLicenseRequest {
  int? count;
  dynamic next;
  dynamic previous;
  List<PrevDrivingLicenseRequestResults>? results;

  PreviosDrivingLicenseRequest(
      {this.count, this.next, this.previous, this.results});

  PreviosDrivingLicenseRequest.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <PrevDrivingLicenseRequestResults>[];
      json['results'].forEach((v) {
        results!.add(PrevDrivingLicenseRequestResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrevDrivingLicenseRequestResults {
  int? id;
  dynamic rating;
  String? createdAt;
  String? updatedAt;
  String? status;
  bool? needsCheck;
  int? renewalDuration;
  String? visitDate;
  String? visitSlot;
  bool? vipAssistance;
  bool? installment;
  bool? isNewCar;
  String? contract;
  String? licenseIdImage;
  String? nationalIdImage;
  String? price;
  String? notes;

  PrevDrivingLicenseRequestResults(
      {this.id,
      this.rating,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.needsCheck,
      this.renewalDuration,
      this.visitDate,
      this.visitSlot,
      this.vipAssistance,
      this.installment,
      this.isNewCar,
      this.contract,
      this.licenseIdImage,
      this.nationalIdImage,
      this.price,
      this.notes});

  PrevDrivingLicenseRequestResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    needsCheck = json['needs_check'];
    renewalDuration = json['renewal_duration'];
    visitDate = json['visit_date'];
    visitSlot = json['visit_slot'];
    vipAssistance = json['vip_assistance'];
    installment = json['installment'];
    isNewCar = json['is_new_car'];
    contract = json['contract'];
    licenseIdImage = json['license_id_image'];
    nationalIdImage = json['national_id_image'];
    price = json['price'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rating'] = rating;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    data['needs_check'] = needsCheck;
    data['renewal_duration'] = renewalDuration;
    data['visit_date'] = visitDate;
    data['visit_slot'] = visitSlot;
    data['vip_assistance'] = vipAssistance;
    data['installment'] = installment;
    data['is_new_car'] = isNewCar;
    data['contract'] = contract;
    data['license_id_image'] = licenseIdImage;
    data['national_id_image'] = nationalIdImage;
    data['price'] = price;
    data['notes'] = notes;
    return data;
  }
}
