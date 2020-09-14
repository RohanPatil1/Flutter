class Category {
  int id;
  String name;
  String image;
  Null slug;
  String createdAt;
  String updatedAt;
  int totalQuestions;
  int easyQuestions;
  int mediumQuestions;
  int hardQuestions;

  Category(
      {this.id,
        this.name,
        this.image,
        this.slug,
        this.createdAt,
        this.updatedAt,
        this.totalQuestions,
        this.easyQuestions,
        this.mediumQuestions,
        this.hardQuestions});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalQuestions = json['total_questions'];
    easyQuestions = json['easy_questions'];
    mediumQuestions = json['medium_questions'];
    hardQuestions = json['hard_questions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['total_questions'] = this.totalQuestions;
    data['easy_questions'] = this.easyQuestions;
    data['medium_questions'] = this.mediumQuestions;
    data['hard_questions'] = this.hardQuestions;
    return data;
  }
}