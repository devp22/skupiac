class NewPlaylist {
  late final String Name;
  late final String NumberOfSongs;
  late final String Publisher;
  late final String image;

  NewPlaylist({
    required this.Name,
    required this.NumberOfSongs,
    required this.Publisher,
    required this.image,
  });
  NewPlaylist.fromJson(Map<String, dynamic> json) {
    Name = json["Name"];
    Publisher = json["Publisher"];
    NumberOfSongs = json["NumberOfSongs"];
    image = json["image"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.Name;
    data['NumberOfSongs'] = this.NumberOfSongs;
    data['Publisher'] = this.Publisher;
    data['image'] = this.image;
    return data;
  }
}
