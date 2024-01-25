class MgovSign{
  String? description;
  String? expiryDate;
  Organisation? organisation;
  Document? document;

  MgovSign(
      {this.description, this.expiryDate, this.organisation, this.document});

  MgovSign.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    expiryDate = json['expiry_date'];
    organisation = json['organisation'] != null
        ? new Organisation.fromJson(json['organisation'])
        : null;
    document = json['document'] != null
        ? new Document.fromJson(json['document'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['expiry_date'] = this.expiryDate;
    if (this.organisation != null) {
      data['organisation'] = this.organisation!.toJson();
    }
    if (this.document != null) {
      data['document'] = this.document!.toJson();
    }
    return data;
  }
}

class Organisation {
  String? nameRu;
  String? nameKz;
  String? nameEn;
  String? bin;

  Organisation({this.nameRu, this.nameKz, this.nameEn, this.bin});

  Organisation.fromJson(Map<String, dynamic> json) {
    nameRu = json['nameRu'];
    nameKz = json['nameKz'];
    nameEn = json['nameEn'];
    bin = json['bin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameRu'] = this.nameRu;
    data['nameKz'] = this.nameKz;
    data['nameEn'] = this.nameEn;
    data['bin'] = this.bin;
    return data;
  }
}

class Document {
  String? uri;
  String? authType;

  Document({this.uri, this.authType});

  Document.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    authType = json['auth_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uri'] = this.uri;
    data['auth_type'] = this.authType;
    return data;
  }
}
