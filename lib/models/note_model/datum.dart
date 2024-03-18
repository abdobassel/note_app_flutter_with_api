class Datum {
	String? id;
	String? body;
	String? title;
	String? userId;
	String? img;

	Datum({this.id, this.body, this.title, this.userId, this.img});

	factory Datum.fromJson(Map<String, dynamic> json) => Datum(
				id: json['id'] as String?,
				body: json['body'] as String?,
				title: json['title'] as String?,
				userId: json['user_id'] as String?,
				img: json['img'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'body': body,
				'title': title,
				'user_id': userId,
				'img': img,
			};
}
