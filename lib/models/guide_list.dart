import 'package:flutter/material.dart';

class GuideModel{
  String? title, icon;
  Widget? description;

  GuideModel({
    this.title,
    this.description,
    this.icon,
  });
}

List<GuideModel> guideList = [
  GuideModel(
    title: 'How to Use the Deck',
    description: RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          fontFamily: "Inter",
          fontWeight: FontWeight.w500,
          color: Colors.black,
          height: 1.5,
        ),
        children: [
          const TextSpan(
            text: "Begin Here\n\nNew to the deck? Start simple.\n\n",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(text: "1. Choose a spread — 1, 3, 5, or 7 cards.\n"),
          const TextSpan(text: "2. Focus on a question or feeling.\n"),
          const TextSpan(text: "3. Draw your cards, notice what first catches your attention.\n"),
          const TextSpan(text: "4. Read the card messages, trace the sigils, and save your reading with a note. That’s it—you’ve begun your conversation with the deck.\n\n"),

          const TextSpan(
            text:
            "Welcome. Whether this is your first time with oracle cards or you’ve traveled this path before, you are stepping into something alive. This deck is more than images and words—it is a ",
          ),
          const TextSpan(
            text: "living portal.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
            " Each card carries an archetype, a real-life story, and a sigil—threads of energy that speak directly to your inner world.\n\nBegin by choosing your spread. Each one opens a different kind of conversation with yourself:\n\n",
          ),

          const TextSpan(
            text: "The Whisper ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
            "— A single card for a single truth. A quick nudge from the unseen, perfect when you want clarity in the moment, guidance on a small decision, or simply a message to start your day.\n\n",
          ),

          const TextSpan(
            text: "The Portal Path to Reclamation ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
            "— Three cards that carry you from past to present to reclamation. Choose this when you want to see the story behind a situation—where you’ve been, where you stand, and the truth calling you forward.\n\n",
          ),

          const TextSpan(
            text: "The Spiral of Becoming ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
            "— Five cards moving in layers, revealing the forces shaping your transformation and the wisdom ready to emerge. This is for when you’re in the middle of change and need deeper insight into the patterns at play.\n\n",
          ),

          const TextSpan(
            text: "The Circle of Self ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
            "— Seven cards forming a full circle of allies, mirrors, and truths, reflecting your wholeness in this moment. Choose this for times of self-discovery, annual or seasonal check-ins, or when you want to see the larger map of your life.\n\n",
          ),

          const TextSpan(
            text: "Chaos Mode",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text:
            " — to invite the unexpected.\n\nBefore you draw, pause. Focus on your question and speak from the heart—clarity calls clarity. When you reveal the cards, let the images, words, and symbols breathe before seeking their written meanings.\n\nEvery card holds a sigil—a symbolic key to its archetype. Tracing it with your finger or resting your gaze upon it awakens its energy within you, working subtly through your subconscious.\n\nWhen your reading is complete, save it in the app and add a journal note. These saved readings are more than memories—they are mirrors across time, revealing how your story moves, how questions evolve, and how clarity deepens.",
          ),
        ],
      ),
    ),
    icon: 'assets/logo.png'
  ),
  GuideModel(
    title: 'How to Read Cards Intuitively',
    description: RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 14,
          fontFamily: "Inter",
          fontWeight: FontWeight.w500,
          color: Colors.black,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text:
            "You don’t need special training to read oracle cards. This guide offers keys, but your intuition is the true translator.\n\n",
          ),
          TextSpan(
            text:
            "When you turn a card, pause before reading its description. Notice what draws you first—the colors, the expression on the cat’s face, a particular symbol. Pay attention to how you feel: curiosity, resistance, nostalgia—each is a message. Sometimes a cat’s gaze will awaken a personal memory. Trust the first thought, image, or sensation that comes—it is often the clearest.\n\n",
          ),
          TextSpan(
            text:
            "The spreads described in ‘How to Use the Deck’ give you a framework to begin with, but their meaning is not fixed. Even though the app’s spreads cannot be altered except through Chaos Mode, you can widen your interpretation—seeing new layers in what each position means, exploring connections between cards, or creating your own personal understanding of the story being told.\n\n",
          ),
          TextSpan(
            text:
            "Each card gives you more than one way in. There is a message from the Cat, drawn from her real-life story. There is shadow wisdom, revealing what may be hidden. There is a mantra to speak into being, a call to intuition to guide your next step, and a sigil activation to awaken the archetype within you. All of these are here to help you understand not just the card, but yourself in this moment.",
          ),
        ],
      ),
    ),
    icon: 'assets/guide_icons/Group 45.png'
  ),
  GuideModel(
    title: 'What is an Oracle Card?',
    description: Text(
      'If this is your first encounter with oracle cards, think of them not as fortune-tellers but as mirrors. They don’t predict your future—they help you see yourself more clearly, right now. An oracle card reflects your present being, offering clarity, insight, and meaning towhatever you’re holding—a situation, a challenge, a question, or a quiet wondering.They speak in symbols, archetypes, and story, mirroring what lives in your heart andmind. They don’t hand you answers. Instead, they open a conversation with yourself—aconversation where truth has been waiting all along.',
      style: TextStyle(
        fontSize: 14,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
        color: Colors.black,
        height: 1.5,
      ),
    ),
    icon: 'assets/guide_icons/Group 33.png'
  ),
  GuideModel(
    title: 'About Chaos Mode',
    description: RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 14,
          fontFamily: "Inter",
          fontWeight: FontWeight.w500,
          color: Colors.black,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: "Chaos Mode",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
            " is where the deck reveals its wild, untamed side—the threshold where the ",
          ),
          TextSpan(
            text: "45th unexpected card",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
            " may appear. It might slip in after you think your spread is complete, replace a card you’ve drawn, or appear with a twist you didn’t see coming. It can be triggered by hidden signs, rare card combinations, or even the pull of the moon. You can turn Chaos Mode on or off in the app. You cannot control when the unexpected card will arrive—but you can welcome it when it does. When it appears, the reading changes—sometimes subtly, sometimes entirely. This is where certainty ends, and transformation begins.",
          ),
        ],
      ),
    ),
    icon: 'assets/guide_icons/Vector.png'
  ),
  GuideModel(
    title: 'Card Pull Ritual Suggestions',
    description: RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          fontFamily: "Inter",
          fontWeight: FontWeight.w500,
          color: Colors.black,
          height: 1.5,
        ),
        children: [
          TextSpan(text: "Ritual is a way to tell your mind and body: "),
          TextSpan(
            text: "“I’m ready to listen.”",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
            " Even the simplest gestures can make the moment feel special, moving you from ordinary time into a space where the unseen can speak. You might light a candle, play soft music, or simply sit quietly. Close your eyes, take a slow breath, and hold the deck—or your phone—as if it were a trusted companion. Whisper your question or thought into the space around you, into the moment you are stepping into. The clearer your heart’s tone, the clearer the mirror will be.\n\n",
          ),
          TextSpan(
            text:
            "Tap consciously at the card you want to turn, honoring its arrival. Before reading the guide’s words, let yourself feel the card’s presence. Trace the sigil, speak the mantra, or follow your own instinct to seal the moment. When you’re done, save your reading and write your reflections in the journal. This simple act turns your reading into a living record. Over time, you’ll see how your story shifts, how questions change shape, and how insight deepens—sometimes in ways you couldn’t see until you looked back.\n\n",
          ),
          TextSpan(
            text:
            "You can always pull ",
          ),
          TextSpan(
            text: "one card for free",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
            "—any day, any time. It’s your way to stay connected to the deck’s energy, even without a subscription. If you’d like to go deeper, a subscription unlocks unlimited readings—three, five, and seven-card spreads—plus Chaos Mode, journaling, and your full library of saved readings. You can subscribe monthly or annually, and you can also ",
          ),
          TextSpan(
            text: "gift the app",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text:
            " to someone you love, so they can step into the portal with you. Whatever you choose, the deck will always be here when you return.",
          ),
        ],
      ),
    ),
    icon: 'assets/guide_icons/Group 51.png'
  )
];