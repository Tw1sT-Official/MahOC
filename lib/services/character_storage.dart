import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character.dart';

class CharacterStorage {
  static const String _keyCharacters = 'mah_oc_characters_json_v1';
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    // Seed initial demo character if empty
    final list = getAllCharacters();
    if (list.isEmpty) {
      await saveCharacter(_createDemoCharacter());
    }
  }

  static List<Character> getAllCharacters() {
    final rawList = _prefs?.getStringList(_keyCharacters) ?? [];
    final characters = <Character>[];
    for (final raw in rawList) {
      try {
        final Map<String, dynamic> json = jsonDecode(raw);
        characters.add(Character.fromJson(json));
      } catch (_) {}
    }
    // Sort recently updated first
    characters.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return characters;
  }

  static Future<void> saveCharacter(Character character) async {
    character.updatedAt = DateTime.now();
    final list = getAllCharacters();
    final index = list.indexWhere((c) => c.id == character.id);
    if (index >= 0) {
      list[index] = character;
    } else {
      list.insert(0, character);
    }
    await _saveAll(list);
  }

  static Future<void> deleteCharacter(String id) async {
    final list = getAllCharacters()..removeWhere((c) => c.id == id);
    await _saveAll(list);
  }

  static Future<Character> duplicateCharacter(Character character) async {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    final duplicate = Character.fromJson(character.toJson())
      ..id = newId
      ..name = '${character.name} (Copy)'
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();
    await saveCharacter(duplicate);
    return duplicate;
  }

  static Future<void> _saveAll(List<Character> list) async {
    final rawList = list.map((c) => jsonEncode(c.toJson())).toList();
    await _prefs?.setStringList(_keyCharacters, rawList);
  }

  // --- Export Sheet to Formatted Markdown ---
  static String exportToMarkdown(Character c) {
    final buf = StringBuffer();
    buf.writeln('# 🎭 ${c.name.isNotEmpty ? c.name : "Unnamed Character"}');
    if (c.alias.isNotEmpty) buf.writeln('*AKA: ${c.alias}*');
    buf.writeln('');

    // 1. Profile
    buf.writeln('## 👤 1. Profile');
    if (c.age.isNotEmpty) buf.writeln('- **Age**: ${c.age}');
    if (c.genderPronouns.isNotEmpty) buf.writeln('- **Gender/Pronouns**: ${c.genderPronouns}');
    if (c.birthday.isNotEmpty) buf.writeln('- **Birthday**: ${c.birthday}');
    if (c.speciesRace.isNotEmpty) buf.writeln('- **Species/Race**: ${c.speciesRace}');
    if (c.faction.isNotEmpty) buf.writeln('- **Faction/Affiliation**: ${c.faction}');
    if (c.occupation.isNotEmpty) buf.writeln('- **Occupation**: ${c.occupation}');
    if (c.alignment.isNotEmpty) buf.writeln('- **Alignment**: ${c.alignment}');
    if (c.voiceTheme.isNotEmpty) buf.writeln('- **Voice/Theme**: ${c.voiceTheme}');
    buf.writeln('');

    // 2. Appearance
    buf.writeln('## 🎨 2. Appearance');
    if (c.height.isNotEmpty) buf.writeln('- **Height**: ${c.height}');
    if (c.weight.isNotEmpty) buf.writeln('- **Weight**: ${c.weight}');
    if (c.hair.isNotEmpty) buf.writeln('- **Hair**: ${c.hair}');
    if (c.eyes.isNotEmpty) buf.writeln('- **Eyes**: ${c.eyes}');
    if (c.skinTone.isNotEmpty) buf.writeln('- **Skin Tone**: ${c.skinTone}');
    if (c.distinguishingFeatures.isNotEmpty) buf.writeln('- **Distinguishing Marks**: ${c.distinguishingFeatures}');
    if (c.clothingStyle.isNotEmpty) buf.writeln('- **Clothing Style**: ${c.clothingStyle}');
    buf.writeln('');

    // 3. Personality
    buf.writeln('## 🧠 3. Personality');
    if (c.traits.isNotEmpty) buf.writeln('- **Traits**: ${c.traits.join(", ")}');
    if (c.strengths.isNotEmpty) buf.writeln('- **Strengths**: ${c.strengths}');
    if (c.weaknesses.isNotEmpty) buf.writeln('- **Weaknesses**: ${c.weaknesses}');
    if (c.likes.isNotEmpty) buf.writeln('- **Likes**: ${c.likes}');
    if (c.dislikes.isNotEmpty) buf.writeln('- **Dislikes**: ${c.dislikes}');
    if (c.fears.isNotEmpty) buf.writeln('- **Fears**: ${c.fears}');
    if (c.philosophy.isNotEmpty) buf.writeln('- **Philosophy/Motto**: "${c.philosophy}"');
    buf.writeln('');

    // 4. Equipment
    if (c.equipment.isNotEmpty) {
      buf.writeln('## ⚔️ 4. Equipment');
      for (final eq in c.equipment) {
        buf.writeln('- **${eq.name}** (${eq.type}): ${eq.description}');
      }
      buf.writeln('');
    }

    // 5. Skills
    if (c.skills.isNotEmpty) {
      buf.writeln('## 🎯 5. Skills');
      for (final sk in c.skills) {
        final stars = '★' * sk.rating + '☆' * (5 - sk.rating);
        buf.writeln('- **${sk.name}** [$stars]: ${sk.note}');
      }
      buf.writeln('');
    }

    // 6. Abilities
    if (c.abilities.isNotEmpty) {
      buf.writeln('## ✨ 6. Abilities & Powers');
      for (final ab in c.abilities) {
        buf.writeln('### ${ab.name} (${ab.type})');
        if (ab.description.isNotEmpty) buf.writeln(ab.description);
        if (ab.limitation.isNotEmpty) buf.writeln('*Cost/Limitation*: ${ab.limitation}');
        buf.writeln('');
      }
    }

    // 7. Relationships
    if (c.relationships.isNotEmpty) {
      buf.writeln('## 🤝 7. Relationships');
      for (final rel in c.relationships) {
        buf.writeln('- **${rel.characterName}** [${rel.relationType}]: ${rel.notes}');
      }
      buf.writeln('');
    }

    // 8. Story
    buf.writeln('## 📖 8. Story');
    if (c.backstory.isNotEmpty) {
      buf.writeln('### Backstory');
      buf.writeln(c.backstory);
      buf.writeln('');
    }
    if (c.currentStatus.isNotEmpty) {
      buf.writeln('### Current Situation');
      buf.writeln(c.currentStatus);
      buf.writeln('');
    }
    if (c.goalsMotivation.isNotEmpty) {
      buf.writeln('### Goals & Motivations');
      buf.writeln(c.goalsMotivation);
      buf.writeln('');
    }

    // 9. Trivia
    buf.writeln('## 💡 9. Trivia');
    if (c.quirks.isNotEmpty) buf.writeln('- **Quirks/Habits**: ${c.quirks.join(", ")}');
    if (c.hobbies.isNotEmpty) buf.writeln('- **Hobbies**: ${c.hobbies}');
    if (c.favoriteFood.isNotEmpty) buf.writeln('- **Favorite Food**: ${c.favoriteFood}');
    if (c.secrets.isNotEmpty) buf.writeln('- **Secrets**: ${c.secrets}');
    buf.writeln('');

    // 10. Metadata
    buf.writeln('## 🌐 10. References & Metadata');
    if (c.universeWorld.isNotEmpty) buf.writeln('- **Universe/World**: ${c.universeWorld}');
    if (c.inspirations.isNotEmpty) buf.writeln('- **Inspirations**: ${c.inspirations}');
    if (c.tags.isNotEmpty) buf.writeln('- **Tags**: ${c.tags.map((t) => "#$t").join(" ")}');
    if (c.creatorNotes.isNotEmpty) buf.writeln('- **Creator Notes**: ${c.creatorNotes}');

    return buf.toString();
  }

  // Sample starter demo character so app never feels empty on first boot
  static Character _createDemoCharacter() {
    return Character(
      id: 'demo_1',
      name: 'Kaelen Vance',
      alias: 'The Eclipse Blade',
      avatarEmoji: '🗡️',
      colorAccent: 0xFF00E5FF, // Cyan
      // 1. Profile
      age: '24',
      genderPronouns: 'Male (He/Him)',
      birthday: 'October 24',
      speciesRace: 'Shadow Elf / Human Hybrid',
      faction: 'Nocturne Mercenary Guild',
      occupation: 'Vanguard Scout',
      alignment: 'Chaotic Good',
      voiceTheme: 'Deep, calm with a wry undertone',
      // 2. Appearance
      height: '5\'11" (180 cm)',
      weight: '72 kg',
      hair: 'Ashen silver, swept back with stray strands',
      eyes: 'Luminescent violet',
      skinTone: 'Pale ivory',
      distinguishingFeatures: 'Geometric runic scar along right forearm',
      clothingStyle: 'Dark leather duster, reinforced titanium vambraces',
      // 3. Personality
      traits: ['Analytical', 'Stoic', 'Dry Humor', 'Protective'],
      strengths: 'Razor sharp situational awareness, unmatched reflexes',
      weaknesses: 'Reluctant to ask for help, prone to insomnia',
      likes: 'Quiet rain, black tea, sharpening blades',
      dislikes: 'Corrupt nobles, overly bright daylight',
      fears: 'Losing control of the shadow rift within',
      philosophy: 'A blade has no master but the choice to strike or sheathe.',
      // 4. Equipment
      equipment: [
        EquipmentItem(
          name: 'Nightfang Twin Daggers',
          type: 'Weapon',
          description: 'Forged from fallen meteoric iron, blades whisper in the dark.',
        ),
        EquipmentItem(
          name: 'Cloak of Shifting Veils',
          type: 'Armor',
          description: 'Blends into ambient shadows when standing motionless.',
        ),
      ],
      // 5. Skills
      skills: [
        SkillItem(name: 'Twin-Blade Dual Wield', rating: 5, note: 'Master tier combatant'),
        SkillItem(name: 'Stealth Infiltration', rating: 4, note: 'Silent step'),
        SkillItem(name: 'Tracking & Scouting', rating: 4, note: 'High survival instinct'),
        SkillItem(name: 'Diplomacy', rating: 2, note: 'Prefers silence over negotiation'),
      ],
      // 6. Abilities
      abilities: [
        AbilityItem(
          name: 'Umbral Step',
          type: 'Shadow Magic',
          description: 'Short-range teleport between any two connected shadows within 15 meters.',
          limitation: 'Causes slight eye strain and mana fatigue with rapid consecutive use.',
        ),
        AbilityItem(
          name: 'Eclipse Blade Edge',
          type: 'Passive',
          description: 'Blades coat in void frost, slowing enemy movements upon strike.',
          limitation: 'Requires remaining in combat focus.',
        ),
      ],
      // 7. Relationships
      relationships: [
        RelationshipItem(
          characterName: 'Captain Robert Reed',
          relationType: 'Mentor / Father Figure',
          notes: 'Took Kaelen off the streets and trained him in the Nocturne Guild.',
        ),
        RelationshipItem(
          characterName: 'Valerie Crow',
          relationType: 'Rival / Reluctant Ally',
          notes: 'Constant competition over high-bounty scouting contracts.',
        ),
      ],
      // 8. Story
      backstory:
          'Born on the fringe borders where the mortal realm collides with the Umbral Veil, Kaelen was left on the doorstep of the Nocturne Guild after an ethereal incident took his home.',
      currentStatus: 'Currently tracking reports of abnormal Void Rifts near the capital citadel.',
      goalsMotivation: 'Discover the origin of his runic marks and protect his guild brothers.',
      // 9. Trivia
      quirks: ['Always sits facing the tavern door', 'Twirls coins when thinking'],
      hobbies: 'Carving miniature figurines from driftwood',
      favoriteFood: 'Smoked venison and bitter herbal tea',
      secrets: 'Secretly loves romance novellas under his tactical gear',
      // 10. Metadata
      universeWorld: 'Aethelgard: The Broken Spires',
      inspirations: 'Geralt of Rivia meets Dishonored Corvo',
      tags: ['Fantasy', 'Rogue', 'ShadowElf', 'AntiHero'],
      colorPalette: ['#00E5FF', '#1A1A2E', '#6C5CE7', '#E0E0E0'],
    );
  }
}
