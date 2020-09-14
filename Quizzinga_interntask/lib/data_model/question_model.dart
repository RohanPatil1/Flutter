class Question {
  int id;
  String text;
  Null quizSet;
  String addedBy;
  bool approved;
  String answer;
  int rating;
  String createdAt;
  String updatedAt;
  List<Categories> categories;
  List<Options> options;

  Question(
      {this.id,
      this.text,
      this.quizSet,
      this.addedBy,
      this.approved,
      this.answer,
      this.rating,
      this.createdAt,
      this.updatedAt,
      this.categories,
      this.options});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    quizSet = json['quiz_set'];
    addedBy = json['added_by'];
    approved = json['approved'];
    answer = json['answer'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['quiz_set'] = this.quizSet;
    data['added_by'] = this.addedBy;
    data['approved'] = this.approved;
    data['answer'] = this.answer;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.categories != null) {
//      percentagesToday:
//      List<double>.from(json["percentagesToday"].map((x) => x.toDouble()));
      data['categories'] =
          List<Categories>.from(this.categories.map((e) => e.toJson())).toList();
//      this.categories.map((v) => v.toJson()).toList();
    }
    if (this.options != null) {
//      data['options'] = this.options.map((v) => v.toJson()).toList();
      data['options'] =
          List<Options>.from(this.options.map((e) => e.toJson())).toList();
    }
    return data;
  }
}

class Categories {
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

  Categories(
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

  Categories.fromJson(Map<String, dynamic> json) {
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

class Options {
  int id;
  int question;
  String caption;
  String credits;
  String originalImage;
  String image;
  bool optimized;
  String createdAt;
  String updatedAt;

  Options(
      {this.id,
      this.question,
      this.caption,
      this.credits,
      this.originalImage,
      this.image,
      this.optimized,
      this.createdAt,
      this.updatedAt});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    caption = json['caption'];
    credits = json['credits'];
    originalImage = json['original_image'];
    image = json['image'];
    optimized = json['optimized'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['caption'] = this.caption;
    data['credits'] = this.credits;
    data['original_image'] = this.originalImage;
    data['image'] = this.image;
    data['optimized'] = this.optimized;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
