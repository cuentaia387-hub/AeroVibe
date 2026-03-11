import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/glossy_button.dart';
import '../providers/note_provider.dart';
import '../models/aero_note.dart';
import '../services/audio_service.dart';

class NoteEditorScreen extends StatefulWidget {
  final AeroNote? note; // Null means new note

  const NoteEditorScreen({Key? key, this.note}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late Color _selectedColor;

  final List<Color> _availableColors = [
    Colors.white,
    AeroColors.waterBlue,
    AeroColors.natureGreen,
    AeroColors.sunnyYellow,
    Colors.purple.shade200,
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
    _selectedColor = widget.note?.color ?? Colors.white;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      Navigator.pop(context);
      return;
    }

    final provider = Provider.of<NoteProvider>(context, listen: false);

    if (widget.note == null) {
      provider.addNote(title, content, _selectedColor);
    } else {
      provider.updateNote(widget.note!.id, title, content, _selectedColor);
    }

    AudioService().playChime();
    Navigator.pop(context);
  }

  void _toggleArchive() {
    if (widget.note != null) {
      Provider.of<NoteProvider>(context, listen: false).toggleArchive(widget.note!.id);
      Navigator.pop(context);
    }
  }

  void _deleteNote() {
    if (widget.note != null) {
      Provider.of<NoteProvider>(context, listen: false).deleteNote(widget.note!.id);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Requires Stack with background in caller or here
      body: Stack(
        children: [
          // Background
          Container(decoration: const BoxDecoration(gradient: AeroColors.brightSkyGradient)),
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white.withOpacity(0.5), Colors.white.withOpacity(0.0)],
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(24),
                    child: GlassCard(
                      padding: const EdgeInsets.all(20),
                      tintColor: _selectedColor,
                      child: Column(
                        children: [
                          TextField(
                            controller: _titleController,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AeroColors.darkText,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Título vibrante...',
                              hintStyle: TextStyle(color: AeroColors.mutedText.withOpacity(0.5)),
                              border: InputBorder.none,
                            ),
                          ),
                          const Divider(color: AeroColors.glassWhite, thickness: 2),
                          TextField(
                            controller: _contentController,
                            maxLines: null,
                            minLines: 10,
                            style: const TextStyle(
                              fontSize: 16,
                              color: AeroColors.darkText,
                              height: 1.5,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Escribe tus pensamientos fluidos aquí...',
                              hintStyle: TextStyle(color: AeroColors.mutedText.withOpacity(0.5)),
                              border: InputBorder.none,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildColorPicker(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AeroColors.darkText),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          if (widget.note != null) ...[
            IconButton(
              icon: Icon(
                widget.note!.isArchived ? Icons.unarchive_rounded : Icons.archive_rounded,
                color: AeroColors.waterBlue,
              ),
              onPressed: _toggleArchive,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
              onPressed: _deleteNote,
            ),
          ],
          const SizedBox(width: 8),
          GlossyButton(
            text: 'Guardar',
            icon: Icons.check,
            baseColor: AeroColors.natureGreen,
            width: 120,
            onPressed: _saveNote,
          ),
        ],
      ),
    );
  }

  Widget _buildColorPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _availableColors.map((color) {
        final isSelected = color == _selectedColor;
        return GestureDetector(
          onTap: () => setState(() => _selectedColor = color),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 40 : 30,
            height: isSelected ? 40 : 30,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AeroColors.waterBlue : Colors.white,
                width: isSelected ? 3 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: isSelected ? 8 : 4,
                  offset: const Offset(0, 2),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
