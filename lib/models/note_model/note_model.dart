import 'datum.dart';

class NoteModel {
	String? status;
	List<Datum>? data;

	NoteModel({this.status, this.data});

	factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
				status: json['status'] as String?,
				data: (json['data'] as List<dynamic>?)
						?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'status': status,
				'data': data?.map((e) => e.toJson()).toList(),
			};
}
