# Longabia, Justine C.

### INF-247

### 2024-1003624

## Lab Activity 1: File Structuring | Design Pattern

**Discussion:**
For the image, I changed the `hasImage` true/false in `newsfeed_card.dart` into an `imagePath` instead. If I give a post an image path, it shows the picture using `Image.asset`. If I don't, the card just skips the image part so there's no empty space. This makes the card dynamic because I only need to add or remove the image path in `newsfeed_screen.dart` to decide if a post has a picture or not. I also added an `errorBuilder` so if the image can't load, it shows a placeholder instead of crashing.

For the profile picture, I made a separate `ProfileAvatar` widget using `CircleAvatar`. It shows the user's photo if there is one, and if there's none, it shows their initials instead.

Lastly, I moved the Like, Comment and Share buttons into their own widget called `PostActions`, and each button uses a reusable `ActionButton` widget. Tapping Like turns it blue and adds one to the count. If you long-press Like, a small picker shows up with Like, Love and Haha reactions, and the button changes to whichever one you pick.
