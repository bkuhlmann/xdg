# 3.1.1 (2019-11-01)

- Added Rubocop Rake support.
- Updated to RSpec 3.9.0.
- Updated to Rake 13.0.0.
- Updated to Rubocop 0.75.0.
- Updated to Rubocop 0.76.0.
- Updated to Ruby 2.6.5.

# 3.1.0 (2019-10-01)

- Fixed dynamic directory path calculation for nil value.
- Added README example documentation for all XDG objects.
- Added cache inspection.
- Added combined path inspection.
- Added config inspection.
- Added data inspection.
- Added directory path inspection.
- Added environment inspection.
- Added pair inspection.
- Added pair presence checks.
- Added standard path inspection.

# 3.0.2 (2019-09-01)

- Updated to Rubocop 0.73.0.
- Updated to Ruby 2.6.4.
- Refactored structs to use hash-like syntax.

# 3.0.1 (2019-07-01)

- Updated Code Quality links.
- Updated to Gemsmith 13.5.0.
- Updated to Git Cop 3.5.0.
- Updated to Rubocop Performance 1.4.0.
- Refactored RSpec helper support requirements.

# 3.0.0 (2019-06-01)

- Added Gemsmith skeleton.
- Added implementation extracted from Runcom gem.
- Updated Code Climate badge links.
- Refactored directory path arrays.
- Refactored standard path expansion of home path.

# 2.2.5 (2019-05-21)

- Fixed a gem packaging issue where the `index` file from the 2.2.3 implementation was missing which
  caused `LoadError` issues for downstream projects.
- No official Git tag was used for this release due to not having write access to the original
  [XDG](https://github.com/rubyworks/xdg) project so this release is only available via
  [RubyGems](https://rubygems.org/gems/xdg/versions/2.2.5).

# 2.2.4 (2019-05-21)

- For all versions prior to 2.2.4 please see the original XDG project
[HISTORY](https://github.com/rubyworks/xdg/blob/master/HISTORY.md). The release of 2.2.4 marked the
beginning of new ownership of the XDG gem which this project documents starting with the release of
2.2.4.
- Added a post install message for the gem warning everyone of the upcoming 3.0.0 release with major
  breaking changes to the API.
- No official Git tag was used for this release due to not having write access to the original
  [XDG](https://github.com/rubyworks/xdg) project so this release is only available via
  [RubyGems](https://rubygems.org/gems/xdg/versions/2.2.4).
