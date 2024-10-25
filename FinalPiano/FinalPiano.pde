import ddf.minim.*;
import java.util.HashMap;

Minim minim;  // Minim object to handle audio
HashMap<Character, AudioSample> keySounds;  // Map keys to audio samples
HashMap<Character, Boolean> keyState;  // Map to control key's state
boolean showSuggestions = false;
color buttonColor = color(255, 0, 0);  // Initial color of the button (white)

void setup() {
  fullScreen();
  strokeWeight(8);  // Set the outline width to 2 pixels

  // Initialize Minim
  minim = new Minim(this);

  // Initialize HashMap to map keys to sounds
  keySounds = new HashMap<Character, AudioSample>();

  // Load sound files and map them to keys
  keySounds.put('a', minim.loadSample("w1.wav"));  // white keys
  keySounds.put('s', minim.loadSample("w2.wav"));
  keySounds.put('d', minim.loadSample("w3.wav"));
  keySounds.put('f', minim.loadSample("w4.wav"));
  keySounds.put('g', minim.loadSample("w5.wav"));
  keySounds.put('h', minim.loadSample("w6.wav"));
  keySounds.put('j', minim.loadSample("w7.wav"));
  keySounds.put('k', minim.loadSample("w8.wav"));
  keySounds.put('l', minim.loadSample("w9.wav"));
  keySounds.put('ç', minim.loadSample("w10.wav"));

  keySounds.put('w', minim.loadSample("b1.wav"));  // black keys
  keySounds.put('e', minim.loadSample("b2.wav"));
  keySounds.put('t', minim.loadSample("b3.wav"));
  keySounds.put('y', minim.loadSample("b4.wav"));
  keySounds.put('u', minim.loadSample("b5.wav"));
  keySounds.put('o', minim.loadSample("b6.wav"));
  keySounds.put('p', minim.loadSample("b7.wav"));

  // Initialize key states as false
  keyState = new HashMap<Character, Boolean>();
  for (char key : keySounds.keySet()) {
    keyState.put(key, false);
  }
}

void draw() {
  background(173, 216, 230);

  // Draw each white key with different color when corresponding key is pressed
  for (char whiteKey : new char[]{'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'ç'}) {
    if (keyState.containsKey(whiteKey) && keyState.get(whiteKey)) {
      fill(random(240), random(240), random(240));
    } else {
      fill(255, 255, 255);
    }

    switch (whiteKey) {
      case 'a':
        rect(200 + 0, 100, 150, 650);
        break;
      case 's':
        rect(200 + 150, 100, 150, 650);
        break;
      case 'd':
        rect(200 + 300, 100, 150, 650);
        break;
      case 'f':
        rect(200 + 450, 100, 150, 650);
        break;
      case 'g':
        rect(200 + 600, 100, 150, 650);
        break;
      case 'h':
        rect(200 + 750, 100, 150, 650);
        break;
      case 'j':
        rect(200 + 900, 100, 150, 650);
        break;
      case 'k':
        rect(200 + 1050, 100, 150, 650);
        break;
      case 'l':
        rect(200 + 1200, 100, 150, 650);
        break;
      case 'ç':
        rect(200 + 1350, 100, 150, 650);
        break;
    }
  }

  // Draw each black key with different color when corresponding key is pressed
  for (char blackKey : new char[]{'w', 'e', 't', 'y', 'u', 'o', 'p'}) {
    if (keyState.containsKey(blackKey) && keyState.get(blackKey)) {
      fill(random(200), random(200), random(200));
    } else {
      fill(0, 0, 0);
    }

    switch (blackKey) {
      case 'w':
        rect(200 + 112.5, 100, 75, 390);
        break;
      case 'e':
        rect(350 + 112.5, 100, 75, 390);
        break;
      case 't':
        rect(650 + 112.5, 100, 75, 390);
        break;
      case 'y':
        rect(800 + 112.5, 100, 75, 390);
        break;
      case 'u':
        rect(950 + 112.5, 100, 75, 390);
        break;
      case 'o':
        rect(1250 + 112.5, 100, 75, 390);
        break;
      case 'p':
        rect(1400 + 112.5, 100, 75, 390);
        break;
    }
  }

  // Draw button
  fill(buttonColor);
  rect(70, 860, 338, 85);
  fill(255);
  textSize(50);
  text("Press spacebar", 80, 920);

  // Show suggestions if the flag is true
  if (showSuggestions) {
    fill(0);
    textSize(45);
    text("A  F  G  H  D  G  F  L  U  H  J  S  E         Beethoven (AI)", 550, 835);
    text("A  H  D  F  G  K  G  F  L  U  J  K  P         Mozart (AI)", 550, 920);
    text("A  E  F  G  U  G  F  Y  L  K  J  H  D         Our sugestion!", 550, 995);
  }
}

void keyPressed() {
  if (key == ' ') {
    showSuggestions = !showSuggestions;  // Toggle the state
    // Change the color of the button when clicking Spacebar
    buttonColor = color(random(200), random(200), random(200));
  } else if (keySounds.containsKey(key)) {
    // Check if the key is not currently pressed before triggering the sound
    if (!keyState.get(key)) {
      keyState.put(key, true);
      AudioSample sound = keySounds.get(key);
      sound.trigger(); // Play the sound mapped to the pressed key
    }
  }
}

void keyReleased() {
  if (keySounds.containsKey(key)) {
    keyState.put(key, false);
  }
}

void stop() {
  // Close all audio samples and stop Minim when the program is terminated
  for (AudioSample sound : keySounds.values()) {
    sound.close();
  }
  minim.stop();
  super.stop();
}
