import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/character.dart';
import '../services/character_storage.dart';
import 'character_edit_screen.dart';

class CharacterDetailScreen extends StatefulWidget {
  final String characterId;

  const CharacterDetailScreen({super.key, required this.characterId});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  Character? _character;

  @override
  void initState() {
    super.initState();
    _loadCharacter();
  }

  void _loadCharacter() {
    final list = CharacterStorage.getAllCharacters();
    final match = list.firstWhere(
      (c) => c.id == widget.characterId,
      orElse: () => Character(id: widget.characterId, name: 'Unknown'),
    );
    setState(() {
      _character = match;
    });
  }

  void _copyMarkdown() {
    if (_character == null) return;
    final md = CharacterStorage.exportToMarkdown(_character!);
    Clipboard.setData(ClipboardData(text: md));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied "${_character!.name}" markdown sheet to clipboard!'),
        backgroundColor: Color(_character!.colorAccent),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_character == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF09090D),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final c = _character!;
    final accent = Color(c.colorAccent);

    return Scaffold(
      backgroundColor: const Color(0xFF09090D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F16),
        elevation: 0,
        title: Text(
          c.name.isNotEmpty ? c.name : 'Character Sheet',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, size: 20),
            tooltip: 'Copy Markdown Sheet',
            onPressed: _copyMarkdown,
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            tooltip: 'Edit Sheet',
            onPressed: () async {
              final result = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (_) => CharacterEditScreen(character: c, isNew: false),
                ),
              );
              if (result == true) _loadCharacter();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
        children: [
          // Header Hero Banner
          _buildHeroHeader(c, accent),
          const SizedBox(height: 20),

          // 1. Profile
          _buildCategoryCard(
            title: '1. Profile',
            icon: Icons.person_outline,
            accent: accent,
            children: [
              _buildRow('Full Name', c.name),
              _buildRow('Alias / Title', c.alias),
              _buildRow('Age', c.age),
              _buildRow('Gender / Pronouns', c.genderPronouns),
              _buildRow('Birthday', c.birthday),
              _buildRow('Species / Race', c.speciesRace),
              _buildRow('Faction / Affiliation', c.faction),
              _buildRow('Occupation', c.occupation),
              _buildRow('Moral Alignment', c.alignment),
              _buildRow('Theme Song / Voice', c.voiceTheme),
            ],
          ),
          const SizedBox(height: 16),

          // 2. Appearance
          _buildCategoryCard(
            title: '2. Appearance',
            icon: Icons.palette_outlined,
            accent: accent,
            children: [
              _buildRow('Height', c.height),
              _buildRow('Weight', c.weight),
              _buildRow('Hair Style & Color', c.hair),
              _buildRow('Eye Color', c.eyes),
              _buildRow('Skin Tone', c.skinTone),
              _buildRow('Distinguishing Marks', c.distinguishingFeatures),
              _buildRow('Clothing Style', c.clothingStyle),
            ],
          ),
          const SizedBox(height: 16),

          // 3. Personality
          _buildCategoryCard(
            title: '3. Personality',
            icon: Icons.psychology_outlined,
            accent: accent,
            children: [
              if (c.traits.isNotEmpty) ...[
                const Text('Personality Traits:', style: TextStyle(color: Colors.white60, fontSize: 12)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: c.traits
                      .map((t) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: accent.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: accent.withOpacity(0.4)),
                            ),
                            child: Text(t, style: TextStyle(color: accent, fontSize: 12, fontWeight: FontWeight.bold)),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 12),
              ],
              _buildRow('Strengths', c.strengths),
              _buildRow('Flaws & Weaknesses', c.weaknesses),
              _buildRow('Likes', c.likes),
              _buildRow('Dislikes', c.dislikes),
              _buildRow('Fears & Phobias', c.fears),
              _buildRow('Personal Philosophy', c.philosophy),
            ],
          ),
          const SizedBox(height: 16),

          // 4. Equipment
          _buildCategoryCard(
            title: '4. Equipment & Arsenal',
            icon: Icons.shield_outlined,
            accent: accent,
            children: [
              if (c.equipment.isEmpty)
                const Text('No equipment listed.', style: TextStyle(color: Colors.white38, fontSize: 12))
              else
                ...c.equipment.map((eq) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF191924),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(eq.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(eq.type, style: const TextStyle(color: Colors.white70, fontSize: 10)),
                              ),
                            ],
                          ),
                          if (eq.description.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(eq.description, style: const TextStyle(color: Colors.white60, fontSize: 12)),
                          ],
                        ],
                      ),
                    )),
            ],
          ),
          const SizedBox(height: 16),

          // 5. Skills
          _buildCategoryCard(
            title: '5. Skills & Proficiencies',
            icon: Icons.star_outline,
            accent: accent,
            children: [
              if (c.skills.isEmpty)
                const Text('No skills listed.', style: TextStyle(color: Colors.white38, fontSize: 12))
              else
                ...c.skills.map((sk) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(sk.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                                if (sk.note.isNotEmpty)
                                  Text(sk.note, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                              ],
                            ),
                          ),
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < sk.rating ? Icons.star : Icons.star_border,
                                color: accent,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
            ],
          ),
          const SizedBox(height: 16),

          // 6. Abilities
          _buildCategoryCard(
            title: '6. Abilities & Powers',
            icon: Icons.auto_awesome_outlined,
            accent: accent,
            children: [
              if (c.abilities.isEmpty)
                const Text('No abilities listed.', style: TextStyle(color: Colors.white38, fontSize: 12))
              else
                ...c.abilities.map((ab) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF191924),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: accent.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(ab.name, style: TextStyle(color: accent, fontWeight: FontWeight.bold, fontSize: 14)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: accent.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(ab.type, style: TextStyle(color: accent, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          if (ab.description.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(ab.description, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                          if (ab.limitation.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text('Limitation: ${ab.limitation}', style: const TextStyle(color: Colors.white38, fontSize: 11, fontStyle: FontStyle.italic)),
                          ],
                        ],
                      ),
                    )),
            ],
          ),
          const SizedBox(height: 16),

          // 7. Relationships
          _buildCategoryCard(
            title: '7. Relationships',
            icon: Icons.group_outlined,
            accent: accent,
            children: [
              if (c.relationships.isEmpty)
                const Text('No relationships listed.', style: TextStyle(color: Colors.white38, fontSize: 12))
              else
                ...c.relationships.map((rel) => Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF191924),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.person_pin_circle_outlined, size: 20, color: Colors.white60),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(rel.characterName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 8),
                                    Text('•  ${rel.relationType}', style: TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                if (rel.notes.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(rel.notes, style: const TextStyle(color: Colors.white60, fontSize: 12)),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
            ],
          ),
          const SizedBox(height: 16),

          // 8. Story
          _buildCategoryCard(
            title: '8. Story & Biography',
            icon: Icons.menu_book_outlined,
            accent: accent,
            children: [
              _buildStoryBlock('Backstory & Origins', c.backstory),
              _buildStoryBlock('Current Status & Location', c.currentStatus),
              _buildStoryBlock('Key Milestones', c.keyMilestones),
              _buildStoryBlock('Goals & Motivations', c.goalsMotivation),
            ],
          ),
          const SizedBox(height: 16),

          // 9. Trivia
          _buildCategoryCard(
            title: '9. Trivia & Facts',
            icon: Icons.lightbulb_outline,
            accent: accent,
            children: [
              if (c.quirks.isNotEmpty) ...[
                _buildRow('Quirks & Habits', c.quirks.join(', ')),
              ],
              _buildRow('Hobbies', c.hobbies),
              _buildRow('Favorite Food & Drink', c.favoriteFood),
              _buildRow('Secrets / Hidden Lore', c.secrets),
              _buildRow('Miscellaneous', c.miscellaneous),
            ],
          ),
          const SizedBox(height: 16),

          // 10. References & Metadata
          _buildCategoryCard(
            title: '10. References & Metadata',
            icon: Icons.info_outline,
            accent: accent,
            children: [
              _buildRow('Universe / World', c.universeWorld),
              _buildRow('Inspirations', c.inspirations),
              _buildRow('Creator Notes', c.creatorNotes),
              if (c.tags.isNotEmpty) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: c.tags
                      .map((t) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('#$t', style: const TextStyle(color: Colors.white70, fontSize: 11)),
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(Character c, Color accent) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF13131C),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accent.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.08),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withOpacity(0.15),
              border: Border.all(color: accent, width: 2),
            ),
            child: Center(
              child: Text(
                c.avatarEmoji.isNotEmpty ? c.avatarEmoji : '👤',
                style: const TextStyle(fontSize: 36),
              ),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.name.isNotEmpty ? c.name : 'Unnamed Character',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (c.alias.isNotEmpty)
                  Text(
                    c.alias,
                    style: TextStyle(
                      color: accent,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                const SizedBox(height: 6),
                Text(
                  [
                    if (c.speciesRace.isNotEmpty) c.speciesRace,
                    if (c.universeWorld.isNotEmpty) c.universeWorld,
                  ].join(' • '),
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required IconData icon,
    required Color accent,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF13131C),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: accent),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white10, height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryBlock(String title, String content) {
    if (content.trim().isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(content, style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}
