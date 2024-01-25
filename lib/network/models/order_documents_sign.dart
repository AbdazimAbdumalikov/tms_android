class OrderDocumentSign {
  String? signMethod;
  List<DocumentsToSign>? documentsToSign;

  OrderDocumentSign({this.signMethod, this.documentsToSign});

  OrderDocumentSign.fromJson(Map<String, dynamic> json) {
    signMethod = json['signMethod'];
    if (json['documentsToSign'] != null) {
      documentsToSign = <DocumentsToSign>[];
      json['documentsToSign'].forEach((v) {
        documentsToSign!.add(new DocumentsToSign.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signMethod'] = this.signMethod;
    if (this.documentsToSign != null) {
      data['documentsToSign'] =
          this.documentsToSign!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentsToSign {
  int? id;
  String? nameRu;
  String? nameKz;
  String? nameEn;
  List<Meta>? meta;
  Document? document;

  DocumentsToSign(
      {this.id,
        this.nameRu,
        this.nameKz,
        this.nameEn,
        this.meta,
        this.document});

  DocumentsToSign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameRu = json['nameRu'];
    nameKz = json['nameKz'];
    nameEn = json['nameEn'];
    if (json['meta'] != null) {
      meta = <Meta>[];
      json['meta'].forEach((v) {
        meta!.add(new Meta.fromJson(v));
      });
    }
    document = json['document'] != null
        ? new Document.fromJson(json['document'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameRu'] = this.nameRu;
    data['nameKz'] = this.nameKz;
    data['nameEn'] = this.nameEn;
    if (this.meta != null) {
      data['meta'] = this.meta!.map((v) => v.toJson()).toList();
    }
    if (this.document != null) {
      data['document'] = this.document!.toJson();
    }
    return data;
  }
}

class Meta {
  String? name;
  String? value;

  Meta({this.name, this.value});

  Meta.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class Document {
  File? file;

  Document({this.file});

  Document.fromJson(Map<String, dynamic> json) {
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    return data;
  }
}

class File {
  String? mime;
  String? data;
  File({this.mime, this.data});

  File.fromJson(Map<String, dynamic> json) {
    mime = json['mime'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mime'] = this.mime;
    data['data'] = this.data;
    return data;
  }
}
