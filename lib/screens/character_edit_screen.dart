import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/character_storage.dart';

class CharacterEditScreen extends StatefulWidget {
  final Character character;
  final bool isNew;

  const CharacterEditScreen({
    super.key,
    required this.character,
    required this.isNew,
  });

  @override
  State<CharacterEditScreen> createState() => _CharacterEditScreenState();
}

class _CharacterEditScreenState extends State<CharacterEditScreen> with SingleTickerProviderStateMixin {
  late Character _c;
  late TabController _tabController;

  // Controllers for 1. Profile
  late TextEditingController _nameCtrl;
  late TextEditingController _aliasCtrl;
  late TextEditingController _ageCtrl;
  late TextEditingController _genderCtrl;
  late TextEditingController _bdayCtrl;
  late TextEditingController _speciesCtrl;
  late TextEditingController _factionCtrl;
  late TextEditingController _occupationCtrl;
  late TextEditingController _alignmentCtrl;
  late TextEditingController _voiceCtrl;

  // Controllers for 2. Appearance
  late TextEditingController _avatarCtrl;
  late TextEditingController _heightCtrl;
  late TextEditingController _weightCtrl;
  late TextEditingController _hairCtrl;
  late TextEditingController _eyesCtrl;
  late TextEditingController _skinToneCtrl;
  late TextEditingController _featuresCtrl;
  late TextEditingController _clothingCtrl;

  // Controllers for 3. Personality
  late TextEditingController _strengthsCtrl;
  late TextEditingController _weaknessesCtrl;
  late TextEditingController _likesCtrl;
  late TextEditingController _dislikesCtrl;
  late TextEditingController _fearsCtrl;
  late TextEditingController _philosophyCtrl;
  final TextEditingController _newTraitCtrl = TextEditingController();

  // Controllers for 8. Story
  late TextEditingController _backstoryCtrl;
  late TextEditingController _currentStatusCtrl;
  late TextEditingController _milestonesCtrl;
  late TextEditingController _goalsCtrl;

  // Controllers for 9. Trivia
  late TextEditingController _hobbiesCtrl;
  late TextEditingController _foodCtrl;
  late TextEditingController _secretsCtrl;
  late TextEditingController _miscCtrl;
  final TextEditingController _newQuirkCtrl = TextEditingController();

  // Controllers for 10. Metadata
  late TextEditingController _universeCtrl;
  late TextEditingController _inspirationsCtrl;
  late TextEditingController _notesCtrl;
  final TextEditingController _newTagCtrl = TextEditingController();

  static const List<int> _accentColors = [
    0xFF00E5FF, // Cyan
    0xFF7C4DFF, // Royal Violet
    0xFFFF1744, // Crimson
    0xFFFFD600, // Solar Gold
    0xFF00E676, // Emerald
    0xFFFF6D00, // Sunset Orange
    0xFFF50057, // Neon Magenta
    0xFFFFFFFF, // Ghost White
  ];

  @override
  void initState() {
    super.initState();
    _c = Character.fromJson(widget.character.toJson());
    _tabController = TabController(length: 10, vsync: this);

    // Profile
    _nameCtrl = TextEditingController(text: _c.name);
    _aliasCtrl = TextEditingController(text: _c.alias);
    _ageCtrl = TextEditingController(text: _c.age);
    _genderCtrl = TextEditingController(text: _c.genderPronouns);
    _bdayCtrl = TextEditingController(text: _c.birthday);
    _speciesCtrl = TextEditingController(text: _c.speciesRace);
    _factionCtrl = TextEditingController(text: _c.faction);
    _occupationCtrl = TextEditingController(text: _c.occupation);
    _alignmentCtrl = TextEditingController(text: _c.alignment);
    _voiceCtrl = TextEditingController(text: _c.voiceTheme);

    // Appearance
    _avatarCtrl = TextEditingController(text: _c.avatarEmoji);
    _heightCtrl = TextEditingController(text: _c.height);
    _weightCtrl = TextEditingController(text: _c.weight);
    _hairCtrl = TextEditingController(text: _c.hair);
    _eyesCtrl = TextEditingController(text: _c.eyes);
    _skinToneCtrl = TextEditingController(text: _c.skinTone);
    _featuresCtrl = TextEditingController(text: _c.distinguishingFeatures);
    _clothingCtrl = TextEditingController(text: _c.clothingStyle);

    // Personality
    _strengthsCtrl = TextEditingController(text: _c.strengths);
    _weaknessesCtrl = TextEditingController(text: _c.weaknesses);
    _likesCtrl = TextEditingController(text: _c.likes);
    _dislikesCtrl = TextEditingController(text: _c.dislikes);
    _fearsCtrl = TextEditingController(text: _c.fears);
    _philosophyCtrl = TextEditingController(text: _c.philosophy);

    // Story
    _backstoryCtrl = TextEditingController(text: _c.backstory);
    _currentStatusCtrl = TextEditingController(text: _c.currentStatus);
    _milestonesCtrl = TextEditingController(text: _c.keyMilestones);
    _goalsCtrl = TextEditingController(text: _c.goalsMotivation);

    // Trivia
    _hobbiesCtrl = TextEditingController(text: _c.hobbies);
    _foodCtrl = TextEditingController(text: _c.favoriteFood);
    _secretsCtrl = TextEditingController(text: _c.secrets);
    _miscCtrl = TextEditingController(text: _c.miscellaneous);

    // Metadata
    _universeCtrl = TextEditingController(text: _c.universeWorld);
    _inspirationsCtrl = TextEditingController(text: _c.inspirations);
    _notesCtrl = TextEditingController(text: _c.creatorNotes);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameCtrl.dispose();
    _aliasCtrl.dispose();
    _ageCtrl.dispose();
    _genderCtrl.dispose();
    _bdayCtrl.dispose();
    _speciesCtrl.dispose();
    _factionCtrl.dispose();
    _occupationCtrl.dispose();
    _alignmentCtrl.dispose();
    _voiceCtrl.dispose();
    _avatarCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _hairCtrl.dispose();
    _eyesCtrl.dispose();
    _skinToneCtrl.dispose();
    _featuresCtrl.dispose();
    _clothingCtrl.dispose();
    _strengthsCtrl.dispose();
    _weaknessesCtrl.dispose();
    _likesCtrl.dispose();
    _dislikesCtrl.dispose();
    _fearsCtrl.dispose();
    _philosophyCtrl.dispose();
    _newTraitCtrl.dispose();
    _backstoryCtrl.dispose();
    _currentStatusCtrl.dispose();
    _milestonesCtrl.dispose();
    _goalsCtrl.dispose();
    _hobbiesCtrl.dispose();
    _foodCtrl.dispose();
    _secretsCtrl.dispose();
    _miscCtrl.dispose();
    _newQuirkCtrl.dispose();
    _universeCtrl.dispose();
    _inspirationsCtrl.dispose();
    _notesCtrl.dispose();
    _newTagCtrl.dispose();
    super.dispose();
  }

  void _save() async {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter at least a character Name in Profile!'),
          backgroundColor: Color(0xFFFF1744),
        ),
      );
      _tabController.animateTo(0);
      return;
    }

    _c.name = name;
    _c.alias = _aliasCtrl.text.trim();
    _c.age = _ageCtrl.text.trim();
    _c.genderPronouns = _genderCtrl.text.trim();
    _c.birthday = _bdayCtrl.text.trim();
    _c.speciesRace = _speciesCtrl.text.trim();
    _c.faction = _factionCtrl.text.trim();
    _c.occupation = _occupationCtrl.text.trim();
    _c.alignment = _alignmentCtrl.text.trim();
    _c.voiceTheme = _voiceCtrl.text.trim();

    _c.avatarEmoji = _avatarCtrl.text.trim().isNotEmpty ? _avatarCtrl.text.trim() : '👤';
    _c.height = _heightCtrl.text.trim();
    _c.weight = _weightCtrl.text.trim();
    _c.hair = _hairCtrl.text.trim();
    _c.eyes = _eyesCtrl.text.trim();
    _c.skinTone = _skinToneCtrl.text.trim();
    _c.distinguishingFeatures = _featuresCtrl.text.trim();
    _c.clothingStyle = _clothingCtrl.text.trim();

    _c.strengths = _strengthsCtrl.text.trim();
    _c.weaknesses = _weaknessesCtrl.text.trim();
    _c.likes = _likesCtrl.text.trim();
    _c.dislikes = _dislikesCtrl.text.trim();
    _c.fears = _fearsCtrl.text.trim();
    _c.philosophy = _philosophyCtrl.text.trim();

    _c.backstory = _backstoryCtrl.text.trim();
    _c.currentStatus = _currentStatusCtrl.text.trim();
    _c.keyMilestones = _milestonesCtrl.text.trim();
    _c.goalsMotivation = _goalsCtrl.text.trim();

    _c.hobbies = _hobbiesCtrl.text.trim();
    _c.favoriteFood = _foodCtrl.text.trim();
    _c.secrets = _secretsCtrl.text.trim();
    _c.miscellaneous = _miscCtrl.text.trim();

    _c.universeWorld = _universeCtrl.text.trim();
    _c.inspirations = _inspirationsCtrl.text.trim();
    _c.creatorNotes = _notesCtrl.text.trim();

    await CharacterStorage.saveCharacter(_c);
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final accent = Color(_c.colorAccent);

    return Scaffold(
      backgroundColor: const Color(0xFF09090D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F16),
        elevation: 0,
        title: Text(
          widget.isNew ? 'New Character' : 'Edit ${_c.name}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: accent),
            onPressed: _save,
            icon: const Icon(Icons.check, size: 20),
            label: const Text('SAVE', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: accent,
          labelColor: accent,
          unselectedLabelColor: Colors.white54,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          tabs: const [
            Tab(text: '1. Profile'),
            Tab(text: '2. Appearance'),
            Tab(text: '3. Personality'),
            Tab(text: '4. Equipment'),
            Tab(text: '5. Skills'),
            Tab(text: '6. Abilities'),
            Tab(text: '7. Relationships'),
            Tab(text: '8. Story'),
            Tab(text: '9. Trivia'),
            Tab(text: '10. Metadata'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProfileTab(accent),
          _buildAppearanceTab(),
          _buildPersonalityTab(accent),
          _buildEquipmentTab(accent),
          _buildSkillsTab(accent),
          _buildAbilitiesTab(accent),
          _buildRelationshipsTab(accent),
          _buildStoryTab(),
          _buildTriviaTab(accent),
          _buildMetadataTab(accent),
        ],
      ),
    );
  }

  // --- 1. Profile Tab ---
  Widget _buildProfileTab(Color accent) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Accent Color Swatches
        const Text('Character Theme Accent:', style: TextStyle(color: Colors.white60, fontSize: 12)),
        const SizedBox(height: 8),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _accentColors.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (ctx, i) {
              final col = Color(_accentColors[i]);
              final isSel = _c.colorAccent == _accentColors[i];
              return GestureDetector(
                onTap: () => setState(() => _c.colorAccent = _accentColors[i]),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: col,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSel ? Colors.white : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: isSel ? const Icon(Icons.check, size: 20, color: Colors.black) : null,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),

        _buildTextField(_nameCtrl, 'Full Character Name *', hint: 'e.g. Kaelen Vance'),
        _buildTextField(_aliasCtrl, 'Title / Alias', hint: 'e.g. The Eclipse Blade'),
        _buildTextField(_ageCtrl, 'Age', hint: 'e.g. 24, Immortal, Unknown'),
        _buildTextField(_genderCtrl, 'Gender & Pronouns', hint: 'e.g. Male (He/Him), Non-binary'),
        _buildTextField(_bdayCtrl, 'Birthday / Zodiac', hint: 'e.g. October 24 (Scorpio)'),
        _buildTextField(_speciesCtrl, 'Species / Race', hint: 'e.g. Shadow Elf, Human, Android'),
        _buildTextField(_factionCtrl, 'Faction / Affiliation', hint: 'e.g. Nocturne Guild, Rebels'),
        _buildTextField(_occupationCtrl, 'Occupation / Class', hint: 'e.g. Vanguard Scout, Mercenary'),
        _buildTextField(_alignmentCtrl, 'Moral Alignment', hint: 'e.g. Chaotic Good, Lawful Neutral'),
        _buildTextField(_voiceCtrl, 'Voice Claim / Theme Song', hint: 'e.g. Deep & calm, "Bury the Light"'),
      ],
    );
  }

  // --- 2. Appearance Tab ---
  Widget _buildAppearanceTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTextField(_avatarCtrl, 'Avatar Emoji / Icon', hint: 'e.g. 🗡️, 🦊, 🧙‍♂️, 👑, 🦾'),
        _buildTextField(_heightCtrl, 'Height', hint: 'e.g. 5\'11" (180 cm)'),
        _buildTextField(_weightCtrl, 'Weight / Build', hint: 'e.g. 72 kg, Athletic, Slender'),
        _buildTextField(_hairCtrl, 'Hair Style & Color', hint: 'e.g. Ashen silver, messy swept back'),
        _buildTextField(_eyesCtrl, 'Eye Color & Shape', hint: 'e.g. Luminescent violet, piercing'),
        _buildTextField(_skinToneCtrl, 'Skin Tone / Complexion', hint: 'e.g. Pale ivory, sun-kissed, bronze'),
        _buildTextField(_featuresCtrl, 'Distinguishing Features', hint: 'e.g. Runic scar on forearm, pointed ears', maxLines: 2),
        _buildTextField(_clothingCtrl, 'Typical Clothing / Style', hint: 'e.g. Dark leather duster, tactical armor', maxLines: 3),
      ],
    );
  }

  // --- 3. Personality Tab ---
  Widget _buildPersonalityTab(Color accent) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Traits Tag List
        const Text('Personality Trait Tags:', style: TextStyle(color: Colors.white60, fontSize: 12)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _c.traits
              .map((t) => Chip(
                    label: Text(t, style: const TextStyle(fontSize: 12)),
                    backgroundColor: accent.withOpacity(0.15),
                    labelStyle: TextStyle(color: accent, fontWeight: FontWeight.bold),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => setState(() => _c.traits.remove(t)),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildTextField(_newTraitCtrl, 'Add Trait', hint: 'e.g. Tsundere, Cynical, Loyal'),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.add_circle, color: accent, size: 30),
              onPressed: () {
                final text = _newTraitCtrl.text.trim();
                if (text.isNotEmpty && !_c.traits.contains(text)) {
                  setState(() {
                    _c.traits.add(text);
                    _newTraitCtrl.clear();
                  });
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 16),

        _buildTextField(_strengthsCtrl, 'Strengths', hint: 'e.g. High situational awareness, loyal', maxLines: 2),
        _buildTextField(_weaknessesCtrl, 'Flaws & Weaknesses', hint: 'e.g. Overprotective, bad temper', maxLines: 2),
        _buildTextField(_likesCtrl, 'Likes', hint: 'e.g. Rainy days, quiet libraries, bitter tea'),
        _buildTextField(_dislikesCtrl, 'Dislikes', hint: 'e.g. Arrogant nobles, loud noises'),
        _buildTextField(_fearsCtrl, 'Fears & Phobias', hint: 'e.g. Claustrophobia, losing loved ones'),
        _buildTextField(_philosophyCtrl, 'Personal Philosophy / Quote', hint: 'e.g. "A blade has no master but the choice to strike."', maxLines: 2),
      ],
    );
  }

  // --- 4. Equipment Tab ---
  Widget _buildEquipmentTab(Color accent) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Weapons, Armor & Items', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            TextButton.icon(
              icon: Icon(Icons.add, size: 18, color: accent),
              label: Text('ADD GEAR', style: TextStyle(color: accent, fontWeight: FontWeight.bold)),
              onPressed: () => _showAddEquipmentDialog(accent),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_c.equipment.isEmpty)
          const Text('No equipment added yet. Tap "ADD GEAR" to list weapons and items.', style: TextStyle(color: Colors.white38, fontSize: 13))
        else
          ..._c.equipment.map((eq) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF13131C),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(eq.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: accent.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                                child: Text(eq.type, style: TextStyle(color: accent, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          if (eq.description.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(eq.description, style: const TextStyle(color: Colors.white60, fontSize: 12)),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.white38, size: 20),
                      onPressed: () => setState(() => _c.equipment.remove(eq)),
                    ),
                  ],
                ),
              )),
      ],
    );
  }

  // --- 5. Skills Tab ---
  Widget _buildSkillsTab(Color accent) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Proficiencies & Levels (1-5★)', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            TextButton.icon(
              icon: Icon(Icons.add, size: 18, color: accent),
              label: Text('ADD SKILL', style: TextStyle(color: accent, fontWeight: FontWeight.bold)),
              onPressed: () => _showAddSkillDialog(accent),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_c.skills.isEmpty)
          const Text('No skills added yet. Tap "ADD SKILL" to rate abilities like Swordsmanship, Cooking, etc.', style: TextStyle(color: Colors.white38, fontSize: 13))
        else
          ..._c.skills.map((sk) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF13131C),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(sk.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          if (sk.note.isNotEmpty)
                            Text(sk.note, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                        ],
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (i) => GestureDetector(
                          onTap: () => setState(() => sk.rating = i + 1),
                          child: Icon(
                            i < sk.rating ? Icons.star : Icons.star_border,
                            color: accent,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.white38, size: 18),
                      onPressed: () => setState(() => _c.skills.remove(sk)),
                    ),
                  ],
                ),
              )),
      ],
    );
  }

  // --- 6. Abilities Tab ---
  Widget _buildAbilitiesTab(Color accent) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Superpowers & Magic', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            TextButton.icon(
              icon: Icon(Icons.add, size: 18, color: accent),
              label: Text('ADD POWER', style: TextStyle(color: accent, fontWeight: FontWeight.bold)),
              onPressed: () => _showAddAbilityDialog(accent),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_c.abilities.isEmpty)
          const Text('No abilities listed. Tap "ADD POWER" to add spells, passive buffs, or ultimate attacks.', style: TextStyle(color: Colors.white38, fontSize: 13))
        else
          ..._c.abilities.map((ab) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF13131C),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: accent.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(ab.name, style: TextStyle(color: accent, fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: accent.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                          child: Text(ab.type, style: TextStyle(color: accent, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.white38, size: 18),
                          onPressed: () => setState(() => _c.abilities.remove(ab)),
                        ),
                      ],
                    ),
                    if (ab.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(ab.description, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                    if (ab.limitation.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text('Cost / Limitation: ${ab.limitation}', style: const TextStyle(color: Colors.white38, fontSize: 11, fontStyle: FontStyle.italic)),
                    ],
                  ],
                ),
              )),
      ],
    );
  }

  // --- 7. Relationships Tab ---
  Widget _buildRelationshipsTab(Color accent) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Character Connections', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            TextButton.icon(
              icon: Icon(Icons.add, size: 18, color: accent),
              label: Text('ADD RELATION', style: TextStyle(color: accent, fontWeight: FontWeight.bold)),
              onPressed: () => _showAddRelationshipDialog(accent),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_c.relationships.isEmpty)
          const Text('No relationships added yet. Connect your OC to allies, rivals, family, or enemies.', style: TextStyle(color: Colors.white38, fontSize: 13))
        else
          ..._c.relationships.map((rel) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF13131C),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(rel.characterName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              Text('•  ${rel.relationType}', style: TextStyle(color: accent, fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          if (rel.notes.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(rel.notes, style: const TextStyle(color: Colors.white60, fontSize: 12)),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.white38, size: 18),
                      onPressed: () => setState(() => _c.relationships.remove(rel)),
                    ),
                  ],
                ),
              )),
      ],
    );
  }

  // --- 8. Story Tab ---
  Widget _buildStoryTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTextField(_backstoryCtrl, 'Backstory & Origins', hint: 'Where they came from, defining tragedy or childhood...', maxLines: 5),
        _buildTextField(_currentStatusCtrl, 'Current Situation & Location', hint: 'What are they doing right now in your story/campaign?', maxLines: 3),
        _buildTextField(_milestonesCtrl, 'Key Life Milestones', hint: 'Major life events, turning points, or achievements...', maxLines: 3),
        _buildTextField(_goalsCtrl, 'Goals & Motivations', hint: 'What do they want more than anything?', maxLines: 3),
      ],
    );
  }

  // --- 9. Trivia Tab ---
  Widget _buildTriviaTab(Color accent) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Quirks & Habits:', style: TextStyle(color: Colors.white60, fontSize: 12)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _c.quirks
              .map((q) => Chip(
                    label: Text(q, style: const TextStyle(fontSize: 12)),
                    backgroundColor: Colors.white12,
                    labelStyle: const TextStyle(color: Colors.white70),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => setState(() => _c.quirks.remove(q)),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildTextField(_newQuirkCtrl, 'Add Quirk', hint: 'e.g. Always twirls pens, taps feet'),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.add_circle, color: accent, size: 30),
              onPressed: () {
                final text = _newQuirkCtrl.text.trim();
                if (text.isNotEmpty && !_c.quirks.contains(text)) {
                  setState(() {
                    _c.quirks.add(text);
                    _newQuirkCtrl.clear();
                  });
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(_hobbiesCtrl, 'Hobbies', hint: 'e.g. Playing the lute, gardening, lockpicking'),
        _buildTextField(_foodCtrl, 'Favorite Food & Drinks', hint: 'e.g. Spicy ramen, Earl Grey tea'),
        _buildTextField(_secretsCtrl, 'Secrets & Hidden Lore', hint: 'Things only the creator knows...', maxLines: 3),
        _buildTextField(_miscCtrl, 'Miscellaneous Trivia', hint: 'Any fun random facts...', maxLines: 3),
      ],
    );
  }

  // --- 10. Metadata Tab ---
  Widget _buildMetadataTab(Color accent) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTextField(_universeCtrl, 'Universe / World / Lore Setting', hint: 'e.g. Aethelgard, Cyberpunk Tokyo, D&D Faerun'),
        _buildTextField(_inspirationsCtrl, 'Inspirations', hint: 'e.g. Dante from DMC, Spike Spiegel'),
        _buildTextField(_notesCtrl, 'Creator Notes', hint: 'Design intent, voice ideas, revision notes...', maxLines: 4),

        const SizedBox(height: 12),
        const Text('Search Tags:', style: TextStyle(color: Colors.white60, fontSize: 12)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _c.tags
              .map((t) => Chip(
                    label: Text('#$t', style: const TextStyle(fontSize: 12)),
                    backgroundColor: Colors.white12,
                    labelStyle: const TextStyle(color: Colors.white70),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => setState(() => _c.tags.remove(t)),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildTextField(_newTagCtrl, 'Add Tag', hint: 'e.g. SciFi, Villain, Mage, Royal'),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.add_circle, color: accent, size: 30),
              onPressed: () {
                final text = _newTagCtrl.text.trim().replaceAll('#', '');
                if (text.isNotEmpty && !_c.tags.contains(text)) {
                  setState(() {
                    _c.tags.add(text);
                    _newTagCtrl.clear();
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  // Helper text field
  Widget _buildTextField(TextEditingController ctrl, String label, {String? hint, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: ctrl,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white54, fontSize: 13),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white24, fontSize: 12),
          filled: true,
          fillColor: const Color(0xFF13131C),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Color(_c.colorAccent), width: 1.5),
          ),
        ),
      ),
    );
  }

  // Dialogs for dynamic list items
  void _showAddEquipmentDialog(Color accent) {
    final nameC = TextEditingController();
    final typeC = TextEditingController(text: 'Weapon');
    final descC = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF14141E),
        title: const Text('Add Equipment', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(nameC, 'Item Name', hint: 'e.g. Nightfang Dagger'),
            _buildTextField(typeC, 'Type', hint: 'Weapon, Armor, Trinket'),
            _buildTextField(descC, 'Description', hint: 'Stats, forging lore...', maxLines: 2),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: accent, foregroundColor: Colors.black),
            onPressed: () {
              if (nameC.text.trim().isNotEmpty) {
                setState(() {
                  _c.equipment.add(EquipmentItem(name: nameC.text.trim(), type: typeC.text.trim(), description: descC.text.trim()));
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAddSkillDialog(Color accent) {
    final nameC = TextEditingController();
    final noteC = TextEditingController();
    int rating = 3;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF14141E),
          title: const Text('Add Skill', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(nameC, 'Skill Name', hint: 'e.g. Swordsmanship, Stealth, Cooking'),
              _buildTextField(noteC, 'Proficiency Note', hint: 'e.g. Master tier, Self-taught'),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (i) => GestureDetector(
                    onTap: () => setDialogState(() => rating = i + 1),
                    child: Icon(i < rating ? Icons.star : Icons.star_border, color: accent, size: 28),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: accent, foregroundColor: Colors.black),
              onPressed: () {
                if (nameC.text.trim().isNotEmpty) {
                  setState(() {
                    _c.skills.add(SkillItem(name: nameC.text.trim(), rating: rating, note: noteC.text.trim()));
                  });
                  Navigator.pop(ctx);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddAbilityDialog(Color accent) {
    final nameC = TextEditingController();
    final typeC = TextEditingController(text: 'Magic');
    final descC = TextEditingController();
    final limC = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF14141E),
        title: const Text('Add Ability / Power', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(nameC, 'Ability Name', hint: 'e.g. Umbral Step'),
              _buildTextField(typeC, 'Category / Type', hint: 'Magic, Superpower, Passive, Ultimate'),
              _buildTextField(descC, 'Description', hint: 'How it works, range, effects...', maxLines: 2),
              _buildTextField(limC, 'Cost / Limitation', hint: 'Cooldown, stamina cost, drawback...', maxLines: 2),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: accent, foregroundColor: Colors.black),
            onPressed: () {
              if (nameC.text.trim().isNotEmpty) {
                setState(() {
                  _c.abilities.add(AbilityItem(
                    name: nameC.text.trim(),
                    type: typeC.text.trim(),
                    description: descC.text.trim(),
                    limitation: limC.text.trim(),
                  ));
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAddRelationshipDialog(Color accent) {
    final nameC = TextEditingController();
    final typeC = TextEditingController(text: 'Ally');
    final notesC = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF14141E),
        title: const Text('Add Relationship', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(nameC, 'Character Name', hint: 'e.g. Captain Robert Reed'),
            _buildTextField(typeC, 'Relationship Role', hint: 'Ally, Rival, Family, Love Interest, Enemy'),
            _buildTextField(notesC, 'Notes & History', hint: 'How they met, dynamic...', maxLines: 2),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel', style: TextStyle(color: Colors.white54))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: accent, foregroundColor: Colors.black),
            onPressed: () {
              if (nameC.text.trim().isNotEmpty) {
                setState(() {
                  _c.relationships.add(RelationshipItem(
                    characterName: nameC.text.trim(),
                    relationType: typeC.text.trim(),
                    notes: notesC.text.trim(),
                  ));
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
