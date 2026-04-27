# Fizzy Button 💧✨

A beautiful, animated **fizzy login button** for Flutter with bubble effects, smooth loading transitions, and morphing into a circular progress indicator.

---

## ✨ Features

* 💧 Fizzy bubble animation on tap
* 🔄 Smooth transition to loading state
* 🔘 Button morphs into a circular loader
* ⚡ Fully customizable (colors, text, size)
* 🔌 Async support for real login APIs
* 🎯 Lightweight & easy to use

---

## 📸 Preview

> Add your GIF here (recommended)

```
assets/demo.gif
```

---

## 🚀 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  fizzy_button: ^0.0.1
```

Then run:

```bash
flutter pub get
```

---

## 🛠 Usage

```dart
import 'package:flutter/material.dart';
import 'package:fizzy_button/fizzy_button.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FizzyLoginButton(
          onTap: () async {
            await Future.delayed(const Duration(seconds: 2));
          },
        ),
      ),
    );
  }
}
```

---

## ⚙️ Customization

```dart
FizzyLoginButton(
  width: 240,
  height: 60,
  text: "Sign In",
  loadingText: "Please wait...",
  gradientColors: [Colors.purple, Colors.blue],
  bubbleColor: Colors.white,
  textColor: Colors.white,
  onTap: () async {
    await Future.delayed(const Duration(seconds: 3));
  },
)
```

---

## 🎬 Behavior

1. User taps button
2. Fizzy bubbles animate
3. Text changes to **"Logging in..."**
4. Button shrinks into a circle
5. Circular loader appears
6. Returns to normal after async completes

---

## 🧠 API

| Property         | Type                      | Default           | Description         |
| ---------------- | ------------------------- | ----------------- | ------------------- |
| `onTap`          | `Future<void> Function()` | `null`            | Async callback      |
| `width`          | `double`                  | `220`             | Button width        |
| `height`         | `double`                  | `60`              | Button height       |
| `text`           | `String`                  | `"Login"`         | Default label       |
| `loadingText`    | `String`                  | `"Logging in..."` | Loading label       |
| `gradientColors` | `List<Color>`             | `[blue, cyan]`    | Background gradient |
| `bubbleColor`    | `Color`                   | `white`           | Bubble color        |
| `textColor`      | `Color`                   | `white`           | Text color          |

---

## 🧪 Example

See the `/example` folder for a complete working app.

---

## 📦 Roadmap

* ✅ Loading animation
* 🔜 Success checkmark animation
* 🔜 Error state with shake
* 🔜 Controller support
* 🔜 More bubble physics customization

---

## 🤝 Contributing

Contributions are welcome!
Feel free to open issues or submit pull requests.

---

## 📄 License

MIT License © 2026

---

## 💡 Author

Built with ❤️ using Flutter
