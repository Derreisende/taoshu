class BookListModel {
  String listName;
  String cover;
  List<ReBooks> reBooks;

  BookListModel({this.listName, this.cover, this.reBooks});

  BookListModel.fromJson(Map<String, dynamic> json) {
    listName = json['listName'];
    cover = json['cover'];
    if (json['reBooks'] != null) {
      reBooks = new List<ReBooks>();
      json['reBooks'].forEach((v) {
        reBooks.add(new ReBooks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['listName'] = this.listName;
    data['cover'] = this.cover;
    if (this.reBooks != null) {
      data['reBooks'] = this.reBooks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReBooks {
  String iSBN;

  ReBooks({this.iSBN});

  ReBooks.fromJson(Map<String, dynamic> json) {
    iSBN = json['ISBN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ISBN'] = this.iSBN;
    return data;
  }
}
