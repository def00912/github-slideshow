# GitHub Copilot Instructions

## Project Overview
This is a Jekyll-based slideshow repository using reveal.js for GitHub Learning Lab. It's designed as a fun activity for learning Git and GitHub.

## Technology Stack
- **Jekyll**: Static site generator
- **reveal.js**: HTML presentation framework
- **Ruby**: For Jekyll and GitHub Pages
- **Markdown**: For slide content

## Repository Structure
- `_posts/`: Contains slide content as markdown files (named with date format YYYY-MM-DD-title.md)
- `_layouts/`: Jekyll layout templates
- `_includes/`: Reusable Jekyll components
- `_config.yml`: Jekyll and reveal.js configuration
- `index.html`: Main presentation entry point

## Code Style and Conventions

### File Formatting (from .editorconfig)
- **Default**: Use tabs with size 4, LF line endings, UTF-8 encoding
- **JSON, JS, CSS, SCSS, YML, HTML**: Use 2 spaces for indentation
- **Markdown files**: Use 4 spaces for indentation, keep trailing whitespace, insert final newline
- Trim trailing whitespace (except in markdown)

### Slide Content
- Slides are created as markdown files in `_posts/` directory
- Use date format: `YYYY-MM-DD-title.md`
- Include front matter with `layout: slide` and `title`
- Keep content concise and presentation-friendly

### Jekyll Configuration
- Markdown processor: kramdown
- Highlighter: rouge
- Timezone: Europe/Berlin
- Use jemoji plugin for emoji support

## Best Practices
1. Follow existing slide structure when adding new slides
2. Test locally with Jekyll before committing
3. Respect the editorconfig settings for consistent formatting
4. Keep slides simple and focused for learning purposes
5. Use semantic commit messages

## Dependencies
- Managed via Bundler (Gemfile)
- Uses GitHub Pages gem (>= 207)
- Includes html-proofer for validation (>= 3.13.0)

## Development
- Uses Jekyll as the static site generator to build from Markdown and templates
- Slides are rendered in order based on post dates (reversed chronologically)
- reveal.js configuration is in `_config.yml` under the `reveal:` section
