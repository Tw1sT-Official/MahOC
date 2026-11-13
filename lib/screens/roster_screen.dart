import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/character.dart';
import '../services/character_storage.dart';
import 'character_detail_screen.dart';
import 'character_edit_screen.dart';

class RosterScreen extends StatefulWidget {
  const RosterScreen({super.key});

  @override
  State<RosterScreen> createState() => _RosterScreenState();
}

class _RosterScreenState extends State<RosterScreen> {
  List<Character> _characters = [];
  String _searchQuery = '';
  String _selectedUniverse = 'All';

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  void _loadCharacters() {
    setState(() {
      _characters = CharacterStorage.getAllCharacters();
    });
  }

  List<String> get _universes {
    final set = {'All'};
    for (final c in _characters) {
      if (c.universeWorld.trim().isNotEmpty) {
        set.add(c.universeWorld.trim());
      }
    }
    return set.toList();
  }

  List<Character> get _filteredCharacters {
    return _characters.where((c) {
      final matchesSearch = _searchQuery.isEmpty ||
          c.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.alias.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.speciesRace.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.universeWorld.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.tags.any((t) => t.toLowerCase().contains(_searchQuery.toLowerCase()));

      final matchesUniverse =
          _selectedUniverse == 'All' || c.universeWorld.trim() == _selectedUniverse;

      return matchesSearch && matchesUniverse;
    }).toList();
  }

  Future<void> _duplicate(Character c) async {
    final dup = await CharacterStorage.duplicateCharacter(c);
    _loadCharacters();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Duplicated "${c.name}" as "${dup.name}"'),
          backgroundColor: const Color(0xFF1E1E28),
        ),
      );
    }
  }

  Future<void> _delete(Character c) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF14141E),
        title: const Text('Delete Character Sheet?'),
        content: Text('Are you sure you want to permanently delete "${c.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.white60)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF1744)),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await CharacterStorage.deleteCharacter(c.id);
      _loadCharacters();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Deleted "${c.name}"'),
            backgroundColor: const Color(0xFF1E1E28),
          ),
        );
      }
    }
  }

  void _copyMarkdown(Character c) {
    final md = CharacterStorage.exportToMarkdown(c);
    Clipboard.setData(ClipboardData(text: md));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied "${c.name}" markdown sheet to clipboard!'),
        backgroundColor: Color(c.colorAccent),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredCharacters;

    return Scaffold(
      backgroundColor: const Color(0xFF09090D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F16),
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'MAH OC',
              style: TextStyle(
                color: Color(0xFF00E5FF),
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF00E5FF).withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.4)),
              ),
              child: Text(
                '${_characters.length}',
                style: const TextStyle(
                  color: Color(0xFF00E5FF),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF00E5FF),
        foregroundColor: Colors.black,
        elevation: 8,
        icon: const Icon(Icons.add, size: 22),
        label: const Text(
          'NEW OC',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2),
        ),
        onPressed: () async {
          final newChar = Character(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: '',
          );
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) => CharacterEditScreen(character: newChar, isNew: true),
            ),
          );
          if (result == true) _loadCharacters();
        },
      ),
      body: Column(
        children: [
          // Search & Universe Filters
          _buildSearchAndFilters(),

          // Character List
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return _buildCharacterCard(filtered[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    final universes = _universes;

    return Container(
      color: const Color(0xFF0F0F16),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          TextField(
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Search by name, world, tag, species...',
              hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
              prefixIcon: const Icon(Icons.search, color: Colors.white54, size: 20),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.white54, size: 18),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
              filled: true,
              fillColor: const Color(0xFF161622),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (val) => setState(() => _searchQuery = val),
          ),

          // Horizontal Universe Chips
          if (universes.length > 2) ...[
            const SizedBox(height: 10),
            SizedBox(
              height: 32,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: universes.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (ctx, i) {
                  final uni = universes[i];
                  final isSel = _selectedUniverse == uni;
                  return ChoiceChip(
                    label: Text(uni, style: const TextStyle(fontSize: 11)),
                    selected: isSel,
                    selectedColor: const Color(0xFF00E5FF).withOpacity(0.2),
                    backgroundColor: const Color(0xFF161622),
                    labelStyle: TextStyle(
                      color: isSel ? const Color(0xFF00E5FF) : Colors.white60,
                      fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: isSel ? const Color(0xFF00E5FF) : Colors.white12,
                      ),
                    ),
                    onSelected: (_) => setState(() => _selectedUniverse = uni),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCharacterCard(Character c) {
    final accent = Color(c.colorAccent);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF13131C),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withOpacity(0.25), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.04),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CharacterDetailScreen(characterId: c.id),
              ),
            );
            _loadCharacters();
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar badge
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: accent.withOpacity(0.5), width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      c.avatarEmoji.isNotEmpty ? c.avatarEmoji : '👤',
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Core Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name & Alias
                      Text(
                        c.name.isNotEmpty ? c.name : 'Unnamed Character',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (c.alias.isNotEmpty)
                        Text(
                          '"${c.alias}"',
                          style: TextStyle(
                            color: accent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 6),

                      // Meta line: Species • Occupation • Universe
                      Text(
                        [
                          if (c.speciesRace.isNotEmpty) c.speciesRace,
                          if (c.occupation.isNotEmpty) c.occupation,
                          if (c.universeWorld.isNotEmpty) c.universeWorld,
                        ].join(' • '),
                        style: const TextStyle(color: Colors.white54, fontSize: 11),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Tags & Traits Pills
                      if (c.traits.isNotEmpty || c.alignment.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            if (c.alignment.isNotEmpty)
                              _buildPill(c.alignment, accent.withOpacity(0.2), accent),
                            ...c.traits.take(3).map(
                                  (t) => _buildPill(t, Colors.white10, Colors.white70),
                                ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                // Trailing Popup Menu
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.white54, size: 20),
                  color: const Color(0xFF1B1B26),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  onSelected: (val) async {
                    switch (val) {
                      case 'edit':
                        final res = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CharacterEditScreen(character: c, isNew: false),
                          ),
                        );
                        if (res == true) _loadCharacters();
                        break;
                      case 'copy':
                        _copyMarkdown(c);
                        break;
                      case 'dup':
                        _duplicate(c);
                        break;
                      case 'delete':
                        _delete(c);
                        break;
                    }
                  },
                  itemBuilder: (ctx) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 18, color: Colors.white70),
                          SizedBox(width: 10),
                          Text('Edit Sheet', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'copy',
                      child: Row(
                        children: [
                          Icon(Icons.copy, size: 18, color: Colors.white70),
                          SizedBox(width: 10),
                          Text('Copy Markdown', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'dup',
                      child: Row(
                        children: [
                          Icon(Icons.content_copy, size: 18, color: Colors.white70),
                          SizedBox(width: 10),
                          Text('Duplicate', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(height: 8),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 18, color: Color(0xFFFF1744)),
                          SizedBox(width: 10),
                          Text('Delete', style: TextStyle(color: Color(0xFFFF1744))),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPill(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: textCol, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00E5FF).withOpacity(0.1),
                border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
              ),
              child: const Icon(Icons.person_add_alt_1, color: Color(0xFF00E5FF), size: 36),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Characters Found',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tap "NEW OC" to build your next original character sheet across all 10 categories!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white38, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
