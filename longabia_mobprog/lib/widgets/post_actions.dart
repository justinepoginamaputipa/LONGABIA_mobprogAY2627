import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import 'custom_text.dart';

enum Reaction { none, like, love, haha }

class ReactionStyle {
  const ReactionStyle(this.icon, this.label, this.color);
  final IconData icon;
  final String label;
  final Color color;
}

const Map<Reaction, ReactionStyle> reactionStyles = {
  Reaction.like: ReactionStyle(Icons.thumb_up, 'Like', FB_PRIMARY),
  Reaction.love: ReactionStyle(Icons.favorite, 'Love', Color(0xFFF33E58)),
  Reaction.haha: ReactionStyle(Icons.emoji_emotions, 'Haha', Color(0xFFF7B125)),
};

class PostActions extends StatefulWidget {
  const PostActions({
    super.key,
    required this.numOfLikes,
    this.numOfComments = 0,
  });

  final int numOfLikes;
  final int numOfComments;

  @override
  State<PostActions> createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions> {
  Reaction _reaction = Reaction.none;
  bool _showPicker = false;

  int get _totalReactions =>
      widget.numOfLikes + (_reaction == Reaction.none ? 0 : 1);

  // Tap: like / unlike
  void _onLikeTap() {
    setState(() {
      _reaction = _reaction == Reaction.none ? Reaction.like : Reaction.none;
      _showPicker = false;
    });
  }

  // Long press: show or hide the reaction picker
  void _onLikeLongPress() {
    setState(() {
      _showPicker = !_showPicker;
    });
  }

  void _pickReaction(Reaction reaction) {
    setState(() {
      _reaction = reaction;
      _showPicker = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color grey = Colors.grey[700]!;
    final ReactionStyle? current = reactionStyles[_reaction];

    return Column(
      children: [
        // Reaction bubbles + count, and number of comments
        Row(
          children: [
            const ReactionBubble(reaction: Reaction.like),
            const ReactionBubble(reaction: Reaction.love),
            const ReactionBubble(reaction: Reaction.haha),
            SizedBox(width: ScreenUtil().setWidth(5)),
            CustomFont(
              text: '$_totalReactions',
              fontSize: ScreenUtil().setSp(12),
              color: Colors.grey,
            ),
            const Spacer(),
            CustomFont(
              text: '${widget.numOfComments} Comments',
              fontSize: ScreenUtil().setSp(12),
              color: Colors.grey,
            ),
          ],
        ),
        const Divider(),
        // Reaction picker (shows on long press)
        if (_showPicker)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(4)),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(8),
                vertical: ScreenUtil().setHeight(4),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 6),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final reaction in [
                    Reaction.like,
                    Reaction.love,
                    Reaction.haha,
                  ])
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(4)),
                      child: GestureDetector(
                        onTap: () => _pickReaction(reaction),
                        child: ReactionBubble(reaction: reaction, size: 34),
                      ),
                    ),
                ],
              ),
            ),
          ),
        // Like, Comment, Share buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ActionButton(
              icon: current?.icon ?? Icons.thumb_up_outlined,
              label: current?.label ?? 'Like',
              color: current?.color ?? grey,
              onTap: _onLikeTap,
              onLongPress: _onLikeLongPress,
            ),
            ActionButton(
              icon: Icons.chat_bubble_outline,
              label: 'Comment',
              color: grey,
              onTap: () {},
            ),
            ActionButton(
              icon: Icons.redo,
              label: 'Share',
              color: grey,
              onTap: () {},
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

// Small colored circle with the reaction icon
class ReactionBubble extends StatelessWidget {
  const ReactionBubble({super.key, required this.reaction, this.size = 18});

  final Reaction reaction;
  final double size;

  @override
  Widget build(BuildContext context) {
    final ReactionStyle style = reactionStyles[reaction]!;
    return Padding(
      padding: EdgeInsets.only(right: ScreenUtil().setWidth(2)),
      child: CircleAvatar(
        radius: ScreenUtil().setSp(size / 2),
        backgroundColor: style.color,
        child: Icon(
          style.icon,
          size: ScreenUtil().setSp(size * 0.6),
          color: Colors.white,
        ),
      ),
    );
  }
}

// Reusable button used for Like, Comment and Share
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.onLongPress,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(12),
          vertical: ScreenUtil().setHeight(6),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: ScreenUtil().setSp(18)),
            SizedBox(width: ScreenUtil().setWidth(5)),
            CustomFont(
              text: label,
              fontSize: ScreenUtil().setSp(12),
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
