import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/glossy_button.dart';
import '../providers/note_provider.dart';
import '../models/aero_note.dart';
import 'note_editor_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Uses Main's background
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bloc de Notas',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: AeroColors.darkText,
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1),
                  const SizedBox(height: 8),
                  const Text(
                    'Tus ideas, fluidas y claras como el cristal',
                    style: TextStyle(
                      fontSize: 16,
                      color: AeroColors.mutedText,
                      fontWeight: FontWeight.w600,
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 24),
                  _buildTabBar(),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: [
                  _NotesGrid(isArchived: false),
                  _NotesGrid(isArchived: true),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0), // Above the nav bar
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NoteEditorScreen()),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AeroColors.brightSkyGradient,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                )
              ],
              border: Border.all(color: Colors.white.withOpacity(0.8), width: 2),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ).animate().scale(delay: 400.ms, duration: 400.ms, curve: Curves.easeOutBack),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white.withOpacity(0.6),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
        ),
        labelColor: AeroColors.waterBlue,
        unselectedLabelColor: AeroColors.mutedText,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        tabs: const [
          Tab(text: 'Activas'),
          Tab(text: 'Archivadas'),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms);
  }
}

class _NotesGrid extends StatelessWidget {
  final bool isArchived;

  const _NotesGrid({Key? key, required this.isArchived}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, child) {
        final notes = isArchived ? provider.archivedNotes : provider.activeNotes;

        if (notes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isArchived ? Icons.archive_outlined : Icons.note_alt_outlined,
                  size: 64,
                  color: AeroColors.mutedText.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  isArchived ? 'No hay notas archivadas' : 'No tienes notas activas',
                  style: const TextStyle(color: AeroColors.mutedText, fontSize: 16),
                ),
                if (!isArchived) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Presiona el botón + para crear una',
                    style: TextStyle(color: AeroColors.waterBlue, fontWeight: FontWeight.bold),
                  )
                ]
              ],
            ).animate().fadeIn(),
          );
        }

        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 120, top: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return _NoteCard(note: note)
                .animate()
                .scale(delay: (50 * index).ms, duration: 300.ms, curve: Curves.easeOutBack);
          },
        );
      },
    );
  }
}

class _NoteCard extends StatelessWidget {
  final AeroNote note;

  const _NoteCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NoteEditorScreen(note: note)),
        );
      },
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        tintColor: note.color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.title.isNotEmpty)
              Text(
                note.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AeroColors.darkText,
                ),
              ),
            if (note.title.isNotEmpty) const SizedBox(height: 8),
            Expanded(
              child: Text(
                note.content,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: AeroColors.mutedText,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${note.createdAt.day}/${note.createdAt.month}/${note.createdAt.year}',
                  style: TextStyle(fontSize: 10, color: AeroColors.mutedText.withOpacity(0.6), fontWeight: FontWeight.bold),
                ),
                Icon(
                  note.isArchived ? Icons.archive : Icons.edit_note_rounded,
                  size: 16,
                  color: AeroColors.waterBlue.withOpacity(0.5),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

