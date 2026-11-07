# UI/UX Checklist — Day Check In (iOS Calendar–inspired)

## Hierarchy & Layout
- [x] AppBar title (month/year) is clear, left-aligned, and not competing with actions
- [x] Primary content (calendar → tasks) reads top-to-bottom without crowding
- [x] Task card content is vertically and horizontally centered
- [x] SafeArea / keyboard do not cause overflow
- [x] Debug controls are available but not visually dominant

## Visual Consistency
- [x] Theme primary color applied consistently (icons, completed days, FAB, completion UI)
- [x] Surfaces use iOS-like background / white cards / subtle dividers
- [x] Typography scale is consistent (large month title, secondary labels, body)
- [x] Completed vs incomplete states are unmistakable

## Calendar
- [x] Weekday labels localized and correctly ordered (Sunday-first)
- [x] Solid filled day circle only when all tasks completed
- [x] Today indicator (dot) only for today
- [x] Future days visually disabled / non-interactive
- [x] Month/year lives in AppBar (not duplicated in calendar body)

## Tasks
- [x] Swipeable task cards with clear completion control
- [x] Empty state is helpful and localized
- [x] Edit / delete / create flows are reachable and clear
- [x] Dialogs remain usable when keyboard is visible

## Localization & Theme
- [x] User-facing strings localized (incl. color theme + celebration)
- [x] Default tasks initialized on first launch in locale
- [x] Color theme picker centered and translated

## Polish
- [x] No clipped text / overflow under normal and keyboard layouts
- [x] Touch targets comfortable (~44pt where practical)
- [x] History ordered sequentially
- [x] Floating action button does not collide with critical content

## Review Notes
### Pass / Fail summary (2026-11-07)
- **AppBar**: Month/year moved into AppBar; title size reduced to 28 and left-aligned with `centerTitle: false` so actions stay readable.
- **Theme consistency**: Dialogs / menus / history / stats actions now use `Theme.of(context).colorScheme.primary` instead of hardcoded blue.
- **Localization**: Snackbars and color-theme tooltip use `AppLocalizations`.
- **Keyboard / overflow**: Task cards scroll when height is constrained; dialogs wrap fields in scroll views; body uses `SafeArea(top: false)` under AppBar.
- **FAB clearance**: Task PageView bottom padding increased so cards clear the FAB.
- **Calendar**: Filled circle = completed only; today dot = today only; weekdays localized.

### Remaining / deferred
- Celebration / color picker strings already localized; regenerate l10n if ARB drifts from generated files.
- Deep visual QA on physical devices for very small screens still recommended before App Store submit.
