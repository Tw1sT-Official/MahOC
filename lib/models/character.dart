class EquipmentItem {
  String name;
  String type; // Weapon, Armor, Trinket, Artifact
  String description;

  EquipmentItem({
    required this.name,
    this.type = 'Gear',
    this.description = '',
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'description': description,
      };

  factory EquipmentItem.fromJson(Map<String, dynamic> json) => EquipmentItem(
        name: json['name'] ?? '',
        type: json['type'] ?? 'Gear',
        description: json['description'] ?? '',
      );
}

class SkillItem {
  String name;
  int rating; // 1 to 5
  String note;

  SkillItem({
    required this.name,
    this.rating = 3,
    this.note = '',
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'rating': rating,
        'note': note,
      };

  factory SkillItem.fromJson(Map<String, dynamic> json) => SkillItem(
        name: json['name'] ?? '',
        rating: json['rating'] ?? 3,
        note: json['note'] ?? '',
      );
}

class AbilityItem {
  String name;
  String type; // Magic, Superpower, Passive, Ultimate
  String description;
  String limitation;

  AbilityItem({
    required this.name,
    this.type = 'Power',
    this.description = '',
    this.limitation = '',
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'description': description,
        'limitation': limitation,
      };

  factory AbilityItem.fromJson(Map<String, dynamic> json) => AbilityItem(
        name: json['name'] ?? '',
        type: json['type'] ?? 'Power',
        description: json['description'] ?? '',
        limitation: json['limitation'] ?? '',
      );
}

class RelationshipItem {
  String characterName;
  String relationType; // Ally, Rival, Family, Love Interest, Enemy
  String notes;

  RelationshipItem({
    required this.characterName,
    this.relationType = 'Ally',
    this.notes = '',
  });

  Map<String, dynamic> toJson() => {
        'characterName': characterName,
        'relationType': relationType,
        'notes': notes,
      };

  factory RelationshipItem.fromJson(Map<String, dynamic> json) =>
      RelationshipItem(
        characterName: json['characterName'] ?? '',
        relationType: json['relationType'] ?? 'Ally',
        notes: json['notes'] ?? '',
      );
}

class Character {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int colorAccent; // 0xFF...

  // 1. Profile
  String name;
  String alias;
  String age;
  String genderPronouns;
  String birthday;
  String speciesRace;
  String faction;
  String occupation;
  String alignment;
  String voiceTheme;

  // 2. Appearance
  String avatarEmoji;
  String height;
  String weight;
  String hair;
  String eyes;
  String skinTone;
  String distinguishingFeatures;
  String clothingStyle;

  // 3. Personality
  List<String> traits;
  String strengths;
  String weaknesses;
  String likes;
  String dislikes;
  String fears;
  String philosophy;

  // 4. Equipment
  List<EquipmentItem> equipment;

  // 5. Skills
  List<SkillItem> skills;

  // 6. Abilities
  List<AbilityItem> abilities;

  // 7. Relationships
  List<RelationshipItem> relationships;

  // 8. Story
  String backstory;
  String currentStatus;
  String keyMilestones;
  String goalsMotivation;

  // 9. Trivia
  List<String> quirks;
  String hobbies;
  String favoriteFood;
  String secrets;
  String miscellaneous;

  // 10. References & Metadata
  String universeWorld;
  String inspirations;
  String creatorNotes;
  List<String> colorPalette;
  List<String> tags;

  Character({
    required this.id,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.colorAccent = 0xFF00E5FF,
    // 1. Profile
    this.name = '',
    this.alias = '',
    this.age = '',
    this.genderPronouns = '',
    this.birthday = '',
    this.speciesRace = '',
    this.faction = '',
    this.occupation = '',
    this.alignment = '',
    this.voiceTheme = '',
    // 2. Appearance
    this.avatarEmoji = '👤',
    this.height = '',
    this.weight = '',
    this.hair = '',
    this.eyes = '',
    this.skinTone = '',
    this.distinguishingFeatures = '',
    this.clothingStyle = '',
    // 3. Personality
    List<String>? traits,
    this.strengths = '',
    this.weaknesses = '',
    this.likes = '',
    this.dislikes = '',
    this.fears = '',
    this.philosophy = '',
    // 4. Equipment
    List<EquipmentItem>? equipment,
    // 5. Skills
    List<SkillItem>? skills,
    // 6. Abilities
    List<AbilityItem>? abilities,
    // 7. Relationships
    List<RelationshipItem>? relationships,
    // 8. Story
    this.backstory = '',
    this.currentStatus = '',
    this.keyMilestones = '',
    this.goalsMotivation = '',
    // 9. Trivia
    List<String>? quirks,
    this.hobbies = '',
    this.favoriteFood = '',
    this.secrets = '',
    this.miscellaneous = '',
    // 10. References & Metadata
    this.universeWorld = '',
    this.inspirations = '',
    this.creatorNotes = '',
    List<String>? colorPalette,
    List<String>? tags,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        traits = traits ?? [],
        equipment = equipment ?? [],
        skills = skills ?? [],
        abilities = abilities ?? [],
        relationships = relationships ?? [],
        quirks = quirks ?? [],
        colorPalette = colorPalette ?? [],
        tags = tags ?? [];

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'colorAccent': colorAccent,
        // 1. Profile
        'name': name,
        'alias': alias,
        'age': age,
        'genderPronouns': genderPronouns,
        'birthday': birthday,
        'speciesRace': speciesRace,
        'faction': faction,
        'occupation': occupation,
        'alignment': alignment,
        'voiceTheme': voiceTheme,
        // 2. Appearance
        'avatarEmoji': avatarEmoji,
        'height': height,
        'weight': weight,
        'hair': hair,
        'eyes': eyes,
        'skinTone': skinTone,
        'distinguishingFeatures': distinguishingFeatures,
        'clothingStyle': clothingStyle,
        // 3. Personality
        'traits': traits,
        'strengths': strengths,
        'weaknesses': weaknesses,
        'likes': likes,
        'dislikes': dislikes,
        'fears': fears,
        'philosophy': philosophy,
        // 4. Equipment
        'equipment': equipment.map((e) => e.toJson()).toList(),
        // 5. Skills
        'skills': skills.map((e) => e.toJson()).toList(),
        // 6. Abilities
        'abilities': abilities.map((e) => e.toJson()).toList(),
        // 7. Relationships
        'relationships': relationships.map((e) => e.toJson()).toList(),
        // 8. Story
        'backstory': backstory,
        'currentStatus': currentStatus,
        'keyMilestones': keyMilestones,
        'goalsMotivation': goalsMotivation,
        // 9. Trivia
        'quirks': quirks,
        'hobbies': hobbies,
        'favoriteFood': favoriteFood,
        'secrets': secrets,
        'miscellaneous': miscellaneous,
        // 10. References & Metadata
        'universeWorld': universeWorld,
        'inspirations': inspirations,
        'creatorNotes': creatorNotes,
        'colorPalette': colorPalette,
        'tags': tags,
      };

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'])
            : null,
        colorAccent: json['colorAccent'] ?? 0xFF00E5FF,
        // 1. Profile
        name: json['name'] ?? '',
        alias: json['alias'] ?? '',
        age: json['age'] ?? '',
        genderPronouns: json['genderPronouns'] ?? '',
        birthday: json['birthday'] ?? '',
        speciesRace: json['speciesRace'] ?? '',
        faction: json['faction'] ?? '',
        occupation: json['occupation'] ?? '',
        alignment: json['alignment'] ?? '',
        voiceTheme: json['voiceTheme'] ?? '',
        // 2. Appearance
        avatarEmoji: json['avatarEmoji'] ?? '👤',
        height: json['height'] ?? '',
        weight: json['weight'] ?? '',
        hair: json['hair'] ?? '',
        eyes: json['eyes'] ?? '',
        skinTone: json['skinTone'] ?? '',
        distinguishingFeatures: json['distinguishingFeatures'] ?? '',
        clothingStyle: json['clothingStyle'] ?? '',
        // 3. Personality
        traits: List<String>.from(json['traits'] ?? []),
        strengths: json['strengths'] ?? '',
        weaknesses: json['weaknesses'] ?? '',
        likes: json['likes'] ?? '',
        dislikes: json['dislikes'] ?? '',
        fears: json['fears'] ?? '',
        philosophy: json['philosophy'] ?? '',
        // 4. Equipment
        equipment: (json['equipment'] as List<dynamic>?)
                ?.map((e) => EquipmentItem.fromJson(e))
                .toList() ??
            [],
        // 5. Skills
        skills: (json['skills'] as List<dynamic>?)
                ?.map((e) => SkillItem.fromJson(e))
                .toList() ??
            [],
        // 6. Abilities
        abilities: (json['abilities'] as List<dynamic>?)
                ?.map((e) => AbilityItem.fromJson(e))
                .toList() ??
            [],
        // 7. Relationships
        relationships: (json['relationships'] as List<dynamic>?)
                ?.map((e) => RelationshipItem.fromJson(e))
                .toList() ??
            [],
        // 8. Story
        backstory: json['backstory'] ?? '',
        currentStatus: json['currentStatus'] ?? '',
        keyMilestones: json['keyMilestones'] ?? '',
        goalsMotivation: json['goalsMotivation'] ?? '',
        // 9. Trivia
        quirks: List<String>.from(json['quirks'] ?? []),
        hobbies: json['hobbies'] ?? '',
        favoriteFood: json['favoriteFood'] ?? '',
        secrets: json['secrets'] ?? '',
        miscellaneous: json['miscellaneous'] ?? '',
        // 10. References & Metadata
        universeWorld: json['universeWorld'] ?? '',
        inspirations: json['inspirations'] ?? '',
        creatorNotes: json['creatorNotes'] ?? '',
        colorPalette: List<String>.from(json['colorPalette'] ?? []),
        tags: List<String>.from(json['tags'] ?? []),
      );

  Character copyWith({
    String? id,
    String? name,
    String? alias,
    int? colorAccent,
    DateTime? updatedAt,
  }) {
    final json = toJson();
    if (id != null) json['id'] = id;
    if (name != null) json['name'] = name;
    if (alias != null) json['alias'] = alias;
    if (colorAccent != null) json['colorAccent'] = colorAccent;
    if (updatedAt != null) json['updatedAt'] = updatedAt.toIso8601String();
    return Character.fromJson(json);
  }
}
