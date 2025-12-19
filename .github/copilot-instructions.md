# GitHub Copilot Instructions for github-slideshow

## Project Overview

This is a Jekyll-based slideshow presentation using the reveal.js framework. It's designed as a learning activity for teaching Git and GitHub fundamentals through GitHub Learning Lab.

## Technology Stack

- **Static Site Generator**: Jekyll (GitHub Pages compatible)
- **Presentation Framework**: reveal.js (included as a git submodule)
- **Markup**: Markdown for slide content
- **Configuration**: YAML (_config.yml)
- **Styling**: Sass/SCSS with Solarized theme

## Project Structure

- `_posts/`: Slide content in Markdown format (YYYY-MM-DD-title.md)
- `_layouts/`: Jekyll layout templates
- `_includes/`: Reusable Jekyll components
- `script/`: Utility scripts for development
- `_config.yml`: Main Jekyll configuration
- `index.html`: Main presentation entry point
- `node_modules/reveal.js/`: reveal.js library (git submodule)

## Development Workflow

### Initial Setup

```bash
script/setup
```

This script will:
- Install Homebrew dependencies (macOS only)
- Install Ruby version (if using rbenv)
- Install gem dependencies via Bundler
- Initialize git submodules (reveal.js)

### Local Development

```bash
script/server
```

This starts the Jekyll development server. Access the slideshow at `http://localhost:4000`.

Additional server options can be passed as arguments, e.g.:
```bash
script/server --livereload
```

### Building

```bash
script/cibuild
```

This script:
1. Builds the Jekyll site with baseurl set to "."
2. Runs HTML validation with htmlproofer on the generated index.html

### Testing

The project uses `html-proofer` for HTML validation. Tests run as part of `script/cibuild`.

## Adding New Slides

1. Create a new Markdown file in `_posts/` with format: `YYYY-MM-DD-title.md`
2. Add YAML front matter with layout and title:
   ```yaml
   ---
   layout: slide
   title: "Your Slide Title"
   ---
   ```
3. Add your slide content in Markdown below the front matter

## Configuration Notes

- Jekyll timezone: Europe/Berlin
- Markdown engine: kramdown with smart quotes
- Syntax highlighter: rouge
- Permalink format: "/:title"
- Solarized theme variant: dark (configurable in _config.yml)

## Important Conventions

- All slide files must be in `_posts/` directory
- Slide files use Jekyll post naming convention (date-based)
- Layout should be set to "slide" in front matter
- The slideshow uses reveal.js for navigation and transitions

## Dependencies

- Ruby (managed via rbenv if available)
- Bundler for Ruby gems
- Jekyll (via github-pages gem)
- html-proofer for validation
- Git (for submodule management)

## Code Style

- Follow existing Jekyll conventions
- Use Markdown for content
- YAML for configuration
- Maintain consistent indentation in config files
