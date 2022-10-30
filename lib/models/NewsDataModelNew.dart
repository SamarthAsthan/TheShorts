class Welcome {
    Welcome({
        required this.status,
        required this.totalResults,
        required this.articles,
    });

    String status;
    int totalResults;
    List<Article> articles;
}

class Article {
    Article({
        required this.title,
        required this.description,
        required this.sourceUrl,
        required this.imageUrl,
        required this.createdAt,
        required this.authorName,
        required this.category,
    });

    String title;
    String description;
    String sourceUrl;
    String imageUrl;
    DateTime createdAt;
    String authorName;
    Category category;

  static fromJson(e) {}
}

enum Category { GENERAL }
