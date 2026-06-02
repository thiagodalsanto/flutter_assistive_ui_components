# Flutter Assistive UI Components

A Flutter package of assistive components for interfaces used by people with fine motor difficulties.

It provides larger, more touch-tolerant widgets that can be configured at runtime, with support for haptic feedback, visual feedback, activation delay, and accessibility presets.

## Features

- Touch-tolerant UI components with configurable size, padding, and colors.
- Runtime configuration through `UserComponentProvider`.
- Optional haptic feedback for interactive elements.
- Optional floating visual feedback messages.
- Optional activation delay through `pressDelay`.
- Accessibility presets for fine motor, severe motor, and aphasia-oriented configurations.
- A draggable floating assistive button that opens the runtime configuration UI.

## Installation

Add the package to the Flutter app that will use it.

For a local package:

```yaml
dependencies:
  flutter_assistive_ui_components:
    path: ../flutter_assistive_ui_components
```

If the package is published, use the published version instead:

```yaml
dependencies:
  flutter_assistive_ui_components: ^0.0.1
```

Then import it:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_assistive_ui_components/flutter_assistive_ui_components.dart';
```

## Provider Setup

The package reads runtime configuration values from `UserComponentProvider`. Wrap the application, or the part of the application that uses the assistive components, with `ChangeNotifierProvider`.

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserComponentProvider(),
      child: const MyApp(),
    ),
  );
}
```

Example:

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
```

## Floating Assistive Button

`FloatingAssistiveButton` is the entry point for the runtime configuration UI. Because it renders a `Positioned` widget, place it inside a `Stack`.

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text('Your app content'),
          ),
          FloatingAssistiveButton(
            enabled: true,
            initialPosition: const Offset(24, 80),
            child: const Icon(
              Icons.accessibility_new,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
```

## Basic Assistive Button

Use `AssistiveUIButton` when you need a larger, touch-friendly button with optional icon, feedback, haptics, and activation delay.

```dart
AssistiveUIButton(
  label: 'Save',
  icon: Icons.check,
  size: const Size(220, 64),
  touchPadding: 20,
  enableHaptic: true,
  showFeedback: true,
  feedbackText: 'Saved',
  onPressed: () {
    debugPrint('Saved');
  },
)
```

## Basic Screen Example

```dart
class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  bool accepted = false;
  bool notifications = false;
  double volume = 0.5;
  String option = 'A';
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assistive UI Example')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AssistiveUIButton(
                  label: 'Continue',
                  icon: Icons.arrow_forward,
                  enableHaptic: true,
                  showFeedback: true,
                  onPressed: () {},
                ),
                AssistiveUICheckbox(
                  initialChecked: accepted,
                  onChanged: (value) => setState(() => accepted = value),
                ),
                AssistiveUISwitch(
                  value: notifications,
                  onChanged: (value) => setState(() => notifications = value),
                ),
                AssistiveUISlider(
                  value: volume,
                  onChanged: (value) => setState(() => volume = value),
                ),
                AssistiveUIDropdown<String>(
                  value: option,
                  items: const [
                    DropdownMenuItem(value: 'A', child: Text('Option A')),
                    DropdownMenuItem(value: 'B', child: Text('Option B')),
                  ],
                  onChanged: (value) => setState(() => option = value),
                ),
                AssistiveUITimePicker(
                  value: selectedTime,
                  onChanged: (value) => setState(() => selectedTime = value),
                ),
              ],
            ),
          ),
          FloatingAssistiveButton(
            enabled: true,
            initialPosition: const Offset(24, 80),
            child: const Icon(Icons.tune, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
```

## Runtime Configuration

Every component uses local constructor values first, then reads global runtime overrides from `UserComponentProvider` when that component supports the key.

Use `setConfig` to update a component at runtime:

```dart
final provider = Provider.of<UserComponentProvider>(context, listen: false);

provider.setConfig('button_width', 260.0);
provider.setConfig('button_height', 72.0);
provider.setConfig('button_enableHaptic', true);
provider.setConfig('button_showFeedback', true);
provider.setConfig('button_pressDelay', 250.0);
provider.setConfig('button_color', Colors.indigo);
```

Runtime keys follow this pattern:

```text
<componentPrefix>_<property>
```

For example:

- `button_width`
- `button_touchPadding`
- `checkbox_scale`
- `textfield_color`
- `timepicker_fontSize`

Provider delay values are stored as milliseconds using `double` or `num` values. Constructor delay values use `Duration`.

## Accessibility Presets

The package includes preset functions that write predefined values into `UserComponentProvider`.

```dart
final provider = Provider.of<UserComponentProvider>(context, listen: false);

applyFineMotor(provider);
applyAphasia(provider);
applySevereMotor(provider);
```

You can also use the helper below from inside a modal or sheet context:

```dart
applyPreset(context, 'fine_motor');
applyPreset(context, 'aphasia');
applyPreset(context, 'severe_motor');
```

## Runtime Configuration Keys

| Component | Prefix | Runtime properties |
| --- | --- | --- |
| `AssistiveUIButton` | `button` | `width`, `height`, `fontSize`, `touchPadding`, `padding`, `color`, `fontColor`, `enableHaptic`, `showFeedback`, `feedbackText`, `pressDelay`, `iconEnabled`, `icon` |
| `AssistiveUIIconButton` | `iconbutton` | `width`, `height`, `iconSize`, `touchPadding`, `padding`, `iconColor`, `color`, `enableHaptic`, `showFeedback`, `pressDelay`, `borderRadius` |
| `AssistiveUICheckbox` | `checkbox` | `scale`, `padding`, `touchPadding`, `color`, `enableHaptic`, `showFeedback`, `pressDelay` |
| `AssistiveUIRadio` | `radio` | `size`, `touchPadding`, `padding`, `color`, `enableHaptic`, `showFeedback`, `pressDelay` |
| `AssistiveUISlider` | `slider` | `width`, `height`, `padding`, `touchPadding`, `activeColor`, `inactiveColor` |
| `AssistiveUISwitch` | `switch` | `width`, `height`, `touchPadding`, `enableHaptic`, `showFeedback`, `pressDelay`, `color` |
| `AssistiveUITextField` | `textfield` | `height`, `width`, `touchPadding`, `padding`, `pressDelay`, `enableHaptic`, `showFeedback`, `color` |
| `AssistiveUIDropdown` | `dropdown` | `width`, `height`, `touchPadding`, `padding`, `color`, `listColor`, `enableHaptic`, `showFeedback`, `pressDelay` |
| `AssistiveUITimePicker` | `timepicker` | `width`, `height`, `touchPadding`, `fontSize`, `padding`, `color`, `fontColor`, `enableHaptic`, `showFeedback`, `pressDelay` |
| `AssistiveUIProgressIndicator` | `linearprogress` | `height`, `width`, `borderRadius`, `color`, `valueColor`, `showLabel`, `animated`, `animationDuration`, `borderColor`, `labelColor` |
| `AssistiveUITabBar` | `tabbar` | `height`, `padding`, `backgroundColor`, `inactiveColor`, `activeColor`, `enableHaptic`, `showFeedback`, `showIcon`, `pressDelay` |
| `AssistiveUIBottomBar` | `bottombar` | `backgroundColor`, `inactiveColor`, `enableHaptic`, `showFeedback`, `pressDelay`, `opacity`, `itemPaddingVertical`, `itemPaddingHorizontal`, `margin` |
| `AssistiveUIAlertDialog` | `alertdialog` | `width`, `padding`, `borderRadius`, `backgroundColor`, `titleColor`, `contentColor`, `enableHaptic`, `showFeedback`, `confirmWidth`, `confirmHeight`, `confirmRadius`, `confirmBg`, `confirmTextColor`, `cancelWidth`, `cancelHeight`, `cancelRadius`, `cancelBg`, `cancelTextColor` |

## Components

### AssistiveUIButton

A large touch-friendly button with optional icon, haptic feedback, visual feedback, and activation delay.

```dart
AssistiveUIButton(
  label: 'Continue',
  onPressed: () {},
)
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `label` | `String` | Required | Button text. |
| `onPressed` | `VoidCallback?` | Required | Called when the button is activated. |
| `icon` | `IconData?` | `null` | Optional icon displayed before the label. |
| `fontColor` | `Color` | `Colors.white` | Text and icon color. |
| `size` | `Size` | `Size(200, 56)` | Button width and height. |
| `fontSize` | `double` | `16` | Label font size. |
| `touchPadding` | `double` | `16` | Extra outer tappable padding. |
| `padding` | `double` | `0` | Internal horizontal content padding. |
| `pressDelay` | `Duration` | `Duration.zero` | Delay before activation. |
| `enableHaptic` | `bool` | `false` | Enables haptic feedback. |
| `hapticDuration` | `Duration` | `30 ms` | Time reserved for haptic feedback. |
| `showFeedback` | `bool` | `false` | Shows floating visual feedback. |
| `feedbackText` | `String` | `Button pressed` | Feedback message. |

### AssistiveUIIconButton

A touch-friendly icon button with configurable size, color, radius, haptics, feedback, and activation delay.

```dart
AssistiveUIIconButton(
  icon: Icons.add,
  iconColor: Colors.white,
  color: Colors.blue,
  size: const Size(56, 56),
  iconSize: 28,
  onPressed: () {},
)
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `icon` | `IconData` | Required | Icon to display. |
| `onPressed` | `VoidCallback?` | Required | Called when activated. |
| `iconColor` | `Color` | Required | Icon color. |
| `color` | `Color` | Required | Button background color. |
| `size` | `Size` | Required | Button width and height. |
| `iconSize` | `double` | Required | Icon size. |
| `touchPadding` | `double` | `0` | Extra outer tappable padding. |
| `padding` | `double` | `0` | Internal padding. |
| `borderRadius` | `double` | `8` | Rounded corner radius. |
| `pressDelay` | `Duration` | `Duration.zero` | Delay before activation. |
| `enableHaptic` | `bool` | `true` | Enables haptic feedback. |
| `hapticDuration` | `Duration` | `0 ms` | Time reserved for haptic feedback. |
| `showFeedback` | `bool` | `true` | Shows floating visual feedback. |
| `feedbackText` | `String` | `Icon button pressed` | Feedback message. |

### AssistiveUICheckbox

A scalable checkbox with a larger touch target, optional haptics, and optional feedback messages.

```dart
AssistiveUICheckbox(
  initialChecked: false,
  onChanged: (checked) {},
)
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `onChanged` | `ValueChanged<bool>?` | Required | Called when the checked state changes. |
| `initialChecked` | `bool` | `false` | Initial checked state. |
| `scale` | `double` | `1.4` | Visual checkbox scale. |
| `touchPadding` | `double` | `16` | Extra outer tappable padding. |
| `color` | `Color` | `Colors.blue` | Checked fill color. |
| `padding` | `double` | `8` | Internal padding. |
| `enableHaptic` | `bool` | `false` | Enables haptic feedback. |
| `pressDelay` | `Duration` | `Duration.zero` | Delay before toggling. |
| `hapticDuration` | `Duration` | `30 ms` | Time reserved for haptic feedback. |
| `showFeedback` | `bool` | `false` | Shows floating visual feedback. |
| `feedbackTextOnCheck` | `String` | `Checked` | Message after checking. |
| `feedbackTextOnUncheck` | `String` | `Unchecked` | Message after unchecking. |

### AssistiveUIRadio<T>

A generic radio button with configurable size, color, touch padding, haptics, and feedback.

```dart
AssistiveUIRadio<String>(
  value: 'yes',
  groupValue: selectedValue,
  onChanged: (value) {},
)
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `value` | `T` | Required | Value represented by this radio option. |
| `groupValue` | `T` | Required | Currently selected value in the radio group. |
| `onChanged` | `ValueChanged<T>?` | Required | Called with `value` when selected. |
| `size` | `double` | `16` | Radio visual scale reference. |
| `color` | `Color` | `Colors.blue` | Selected color. |
| `touchPadding` | `double` | `8` | Extra outer tappable padding. |
| `padding` | `double` | `0` | Internal padding. |
| `pressDelay` | `Duration` | `Duration.zero` | Delay before selection. |
| `enableHaptic` | `bool` | `false` | Enables haptic feedback. |
| `hapticDuration` | `Duration` | `30 ms` | Time reserved for haptic feedback. |
| `showFeedback` | `bool` | `false` | Shows floating visual feedback. |

### AssistiveUISlider

A custom slider with a large gesture area and configurable dimensions and colors.

```dart
AssistiveUISlider(
  value: value,
  min: 0,
  max: 100,
  onChanged: (nextValue) {},
)
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `value` | `double` | Required | Current slider value. |
| `onChanged` | `ValueChanged<double>` | Required | Called when the value changes. |
| `width` | `double` | `300` | Slider track width. |
| `height` | `double` | `8` | Slider track height. |
| `padding` | `double` | `16` | Internal padding. |
| `touchPadding` | `double` | `8` | Extra outer gesture padding. |
| `enableHaptic` | `bool` | `false` | Enables haptic feedback. |
| `hapticDuration` | `Duration` | `30 ms` | Time reserved for haptic feedback. |
| `showFeedback` | `bool` | `false` | Shows floating visual feedback. |
| `min` | `double` | `0.0` | Minimum value. |
| `max` | `double` | `1.0` | Maximum value. |
| `divisions` | `double` | `100` | Logical division count. |
| `inactiveColor` | `Color` | `Colors.grey` | Inactive track color. |
| `activeColor` | `Color` | `Colors.blue` | Active track and thumb color. |
| `pressDelay` | `Duration` | `Duration.zero` | Delay before activation. |

### AssistiveUISwitch

A scalable switch with larger touch tolerance, optional haptic feedback, and optional visual feedback.

```dart
AssistiveUISwitch(
  value: enabled,
  onChanged: (value) {},
)
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `value` | `bool` | Required | Current switch value. |
| `onChanged` | `ValueChanged<bool>?` | Required | Called when the value changes. |
| `width` | `double` | `72` | Switch width. |
| `height` | `double` | `40` | Switch height. |
| `touchPadding` | `double` | `16` | Extra outer tappable padding. |
| `pressDelay` | `Duration` | `Duration.zero` | Delay before toggling. |
| `enableHaptic` | `bool` | `false` | Enables haptic feedback. |
| `hapticDuration` | `Duration` | `30 ms` | Time reserved for haptic feedback. |
| `showFeedback` | `bool` | `false` | Shows floating visual feedback. |
| `color` | `Color` | `Colors.blue` | Active color. |

### AssistiveUITextField

A configurable text field with larger touch area, focus handling, optional haptics, and visual feedback.

```dart
final controller = TextEditingController();

AssistiveUITextField(
  label: 'Name',
  controller: controller,
)
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `label` | `String` | Required | Input label. |
| `controller` | `TextEditingController` | Required | Text controller. |
| `height` | `double` | `56` | Field height. |
| `width` | `double` | `200` | Field width. |
| `touchPadding` | `double` | `12` | Extra outer tappable padding. |
| `padding` | `double` | `8` | Internal content padding. |
| `pressDelay` | `Duration` | `Duration.zero` | Delay before requesting focus. |
| `enableHaptic` | `bool` | `false` | Enables haptic feedback. |
| `hapticDuration` | `Duration` | `30 ms` | Time reserved for haptic feedback. |
| `showFeedback` | `bool` | `false` | Shows floating visual feedback. |
| `feedbackText` | `String` | `Textfield Activated` | Feedback message. |
| `color` | `Color` | `Colors.blue` | Focused border color. |
| `focusNode` | `FocusNode?` | `null` | Optional external focus node. |

### AssistiveUIDropdown<T>

A generic dropdown with larger touch area, configurable colors, haptics, feedback, and delayed selection.

```dart
AssistiveUIDropdown<String>(
  value: selected,
  items: const [
    DropdownMenuItem(value: 'one', child: Text('One')),
    DropdownMenuItem(value: 'two', child: Text('Two')),
  ],
  onChanged: (value) {},
)
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `value` | `T` | Required | Current selected value. |
| `items` | `List<DropdownMenuItem<T>>` | Required | Dropdown options. |
| `onChanged` | `ValueChanged<T>?` | Required | Called when a value is selected. |
| `width` | `double` | `200` | Dropdown width. |
| `height` | `double` | `56` | Dropdown height. |
| `touchPadding` | `double` | `8` | Extra outer tappable padding. |
| `padding` | `double` | `0` | Internal padding. |
| `pressDelay` | `Duration` | `Duration.zero` | Delay before selection handling. |
| `enableHaptic` | `bool` | `false` | Enables haptic feedback. |
| `hapticDuration` | `Duration` | `30 ms` | Time reserved for haptic feedback. |
| `showFeedback` | `bool` | `false` | Shows floating visual feedback. |
| `color` | `Color` | `Colors.blue` | Border color. |
| `listColor` | `Color` | `Colors.white` | Dropdown menu background color. |
| `feedbackText` | `String` | `Dropdown Selected` | Feedback message. |
| `icon` | `Widget` | `Icon(Icons.arrow_drop_down)` | Dropdown icon. |

### AssistiveUITimePicker

A touch-friendly time picker trigger that opens Flutter's native `showTimePicker`.

```dart
AssistiveUITimePicker(
  value: selectedTime,
  onChanged: (time) {},
)
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `value` | `TimeOfDay?` | `null` | Current selected time. |
| `onChanged` | `ValueChanged<TimeOfDay>?` | `null` | Called when a time is selected. |
| `label` | `String` | `Select Time` | Text shown when no time is selected. |
| `width` | `double` | `200` | Picker trigger width. |
| `height` | `double` | `56` | Picker trigger height. |
| `fontSize` | `double` | `16` | Label and icon size reference. |
| `touchPadding` | `double` | `8` | Extra outer tappable padding. |
| `padding` | `double` | `0` | Horizontal content padding. |
| `pressDelay` | `Duration` | `Duration.zero` | Delay before opening the picker. |
| `enableHaptic` | `bool` | `false` | Enables haptic feedback. |
| `hapticDuration` | `Duration` | `30 ms` | Time reserved for haptic feedback. |
| `showFeedback` | `bool` | `false` | Shows floating visual feedback after selection. |
| `color` | `Color` | `Colors.white` | Trigger background color. |
| `fontColor` | `Color` | `Colors.black` | Label and icon color. |

### AssistiveUIProgressIndicator

A configurable linear progress indicator with optional animation and label.

```dart
AssistiveUIProgressIndicator(
  value: 0.65,
  showLabel: true,
)
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `value` | `double?` | `null` | Progress value from `0.0` to `1.0`; `null` renders an empty bar. |
| `valueColor` | `Color?` | `Colors.white` | Filled progress color. |
| `height` | `double` | `8` | Bar height. |
| `width` | `double` | `200` | Bar width. |
| `color` | `Color?` | `Colors.blue` | Track background color. |
| `borderRadius` | `double` | `8` | Bar corner radius. |
| `showLabel` | `bool` | `false` | Shows a percentage label. |
| `isAnimated` | `bool` | `true` | Animates value changes. |
| `animationDuration` | `double?` | `null` | Animation duration in milliseconds. |
| `borderColor` | `Color` | `Colors.black` | Border color. |
| `labelColor` | `Color?` | `Colors.black` | Percentage label color. |

### AssistiveUITabBar

A custom tab bar using `TabItem` models, large touch areas, optional icons, haptics, and feedback.

```dart
AssistiveUITabBar(
  currentIndex: currentIndex,
  items: [
    TabItem(label: 'Home', icon: Icons.home),
    TabItem(label: 'Settings', icon: Icons.settings),
  ],
  onChanged: (index) {},
)
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `items` | `List<TabItem>` | Required | Tab items to render. |
| `currentIndex` | `int` | Required | Initially selected index. |
| `onChanged` | `ValueChanged<int>?` | Required | Called when a tab is selected. |
| `height` | `double` | `64` | Tab bar height. |
| `padding` | `double` | `8` | Padding inside each tab. |
| `enableHaptic` | `bool` | `true` | Enables haptic feedback. |
| `showIcon` | `bool` | `true` | Shows each tab icon. |
| `showFeedback` | `bool` | `true` | Shows floating visual feedback. |
| `pressDelay` | `Duration` | `Duration.zero` | Delay before changing tabs. |

### AssistiveUIBottomBar

A touch-friendly bottom navigation bar built on top of `salomon_bottom_bar`.

```dart
AssistiveUIBottomBar(
  currentIndex: currentIndex,
  items: [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home),
      title: const Text('Home'),
      selectedColor: Colors.blue,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.settings),
      title: const Text('Settings'),
      selectedColor: Colors.green,
    ),
  ],
  onChanged: (index) {},
)
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `currentIndex` | `int` | Required | Initially selected index. |
| `items` | `List<SalomonBottomBarItem>` | Required | Bottom bar items. |
| `onChanged` | `ValueChanged<int>?` | Required | Called when an item is selected. |
| `backgroundColor` | `Color` | `Color.fromARGB(50, 243, 243, 243)` | Bar background color. |
| `inactiveColor` | `Color` | `Colors.grey` | Unselected item color. |
| `curve` | `Curve` | `Curves.easeInQuint` | Selection animation curve. |
| `animationDuration` | `Duration` | `Duration.zero` | Selection animation duration. |
| `selectedColorOpacity` | `double` | `0.2` | Selected item background opacity. |
| `itemPaddingHorizontal` | `double` | `16` | Horizontal item padding. |
| `itemPaddingVertical` | `double` | `12` | Vertical item padding. |
| `margin` | `double` | `0` | Outer margin. |
| `itemShape` | `ShapeBorder` | `StadiumBorder()` | Selected item shape. |
| `enableHaptic` | `bool` | `true` | Enables haptic feedback. |
| `showFeedback` | `bool` | `true` | Shows floating visual feedback. |
| `pressDelay` | `Duration` | `Duration.zero` | Delay before changing tabs. |

### AssistiveUIAlertDialog

A configurable alert dialog with large action buttons, customizable colors, haptics, feedback, and activation delay.

```dart
showDialog(
  context: context,
  builder: (_) => AssistiveUIAlertDialog(
    title: 'Delete item?',
    content: 'This action cannot be undone.',
    confirmText: 'Delete',
    cancelText: 'Cancel',
    onConfirm: () {},
  ),
);
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `title` | `String` | `Title` | Dialog title. |
| `content` | `String` | `Content` | Dialog body text. |
| `confirmText` | `String` | `OK` | Confirm button text. |
| `cancelText` | `String` | `Cancel` | Cancel button text. |
| `feedbackText` | `String?` | `null` | Custom feedback message. |
| `titleColor` | `Color` | `Colors.black` | Title color. |
| `contentColor` | `Color` | `Colors.black87` | Content color. |
| `backgroundColor` | `Color` | `Colors.white` | Dialog background color. |
| `titleStyle` | `FontStyle` | `FontStyle.normal` | Title font style. |
| `contentStyle` | `FontStyle` | `FontStyle.normal` | Content font style. |
| `onConfirm` | `VoidCallback?` | `null` | Called after confirmation. |
| `onCancel` | `VoidCallback?` | `null` | Called after cancellation. |
| `enableHaptic` | `bool` | `true` | Enables haptic feedback. |
| `showFeedback` | `bool` | `true` | Shows floating visual feedback. |
| `width` | `double` | `300` | Dialog width. |
| `padding` | `double` | `16` | Dialog padding. |
| `borderRadius` | `double` | `16` | Dialog corner radius. |
| `pressDelay` | `Duration` | `Duration.zero` | Delay before button action. |
| `confirmWidth` | `double` | `110` | Confirm button width. |
| `confirmHeight` | `double` | `40` | Confirm button height. |
| `confirmBorderRadius` | `double` | `8` | Confirm button radius. |
| `confirmBackgroundColor` | `Color` | `Colors.blue` | Confirm button background color. |
| `confirmTextColor` | `Color` | `Colors.white` | Confirm button text color. |
| `cancelWidth` | `double` | `110` | Cancel button width. |
| `cancelHeight` | `double` | `40` | Cancel button height. |
| `cancelBorderRadius` | `double` | `8` | Cancel button radius. |
| `cancelBackgroundColor` | `Color` | `Colors.grey` | Cancel button background color. |
| `cancelTextColor` | `Color` | `Colors.white` | Cancel button text color. |

### FloatingAssistiveButton

A draggable floating button that opens the assistive runtime configuration sheets.

```dart
FloatingAssistiveButton(
  enabled: true,
  initialPosition: const Offset(24, 80),
  child: const Icon(Icons.accessibility_new, color: Colors.white),
)
```

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `child` | `Widget` | Required | Content shown inside the button. |
| `enabled` | `bool` | Required | Shows or hides the button. |
| `initialPosition` | `Offset` | Required | Initial `left` and `top` position inside the parent `Stack`. |
| `size` | `double` | `72` | Button width and height. |
| `color` | `Color` | `Colors.blue` | Button base color. |

## Supporting Models

### TabItem

Used by `AssistiveUITabBar`.

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| `label` | `String` | Required | Tab label. |
| `icon` | `IconData` | Required | Tab icon. |
| `activeColor` | `Color?` | `null` | Optional selected color for this item. |
| `inactiveColor` | `Color?` | `null` | Optional unselected color for this item. |

### ComponentPreset

Used to define reusable preset values that can be applied to `UserComponentProvider`.

`ComponentPreset` includes optional fields such as `width`, `height`, `fontSize`, `iconSize`, `scale`, `touchPadding`, `padding`, `pressDelay`, `enableHaptic`, `showFeedback`, `color`, `fontColor`, `activeColor`, `inactiveColor`, `iconColor`, `borderRadius`, `hapticDuration`, `showLabel`, `isAnimated`, `animationDuration`, `valueColor`, `borderColor`, `labelColor`, `backgroundColor`, `titleColor`, `contentColor`, dialog button properties, bottom bar spacing properties, `size`, and `listColor`.
