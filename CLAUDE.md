# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Rails 8.1 social media application for creating and liking posts (user messages). Features session-based authentication with bcrypt, user profiles with avatar support, and a likes system. Deployed on Render at https://post-jvax.onrender.com/

## Technology Stack

- **Ruby 3.4.7** with **Rails 8.1**
- **PostgreSQL** database
- **Hotwire** (Turbo + Stimulus) for frontend interactivity
- **Propshaft** for asset pipeline
- **Solid Queue**, **Solid Cache**, **Solid Cable** for Rails infrastructure (database-backed)
- **Active Storage** for file uploads (avatars)
- **bcrypt** for password authentication

## Common Development Commands

### Server & Development
```bash
rails server                    # Start development server on port 3000
bin/dev                         # Development script (if configured)
```

### Database
```bash
rails db:create                 # Create databases
rails db:migrate                # Run pending migrations
rails db:rollback               # Rollback last migration
rails db:reset                  # Drop, create, and migrate database
rails db:seed                   # Load seed data
rails db:test:prepare           # Prepare test database
```

### Testing
```bash
bin/rails test                  # Run all tests
bin/rails test:system           # Run system tests only
bin/rails test test/models/user_test.rb           # Run specific test file
bin/rails test test/models/user_test.rb:10        # Run specific test at line 10
```

### Code Quality & Security
```bash
bin/rubocop                     # Lint Ruby code (Omakase style)
bin/rubocop -f github           # Lint with GitHub Actions format
bin/rubocop -a                  # Auto-fix issues
bin/brakeman                    # Security scan for Rails vulnerabilities
bin/bundler-audit               # Check gems for security issues
bin/importmap audit             # Check JavaScript dependencies
bin/ci                          # Run CI checks locally
```

### Asset Management
```bash
bin/importmap pin <package>     # Add JavaScript package
bin/importmap audit             # Audit importmap packages
```

### Background Jobs
```bash
bin/jobs                        # Mission Control for jobs
```

### Deployment
```bash
bin/kamal deploy                # Deploy with Kamal (Docker-based)
```

## Architecture & Data Model

### Core Models & Associations

**User** (`app/models/user.rb`)
- Authentication via `has_secure_password` (bcrypt)
- `has_many :user_messages` (ordered by `created_at: :desc`)
- `has_many :likes, dependent: :destroy`
- `has_many :liked_messages, through: :likes, source: :user_message`
- `has_one_attached :avatar` (Active Storage)
- Avatar system uses `image_name` column to reference files in `public/avatars/`
- Validations: name (max 50), email (unique, valid format), password

**UserMessage** (`app/models/user_message.rb`)
- Represents posts/messages in the system
- `belongs_to :user`
- `has_many :likes, dependent: :destroy`
- Validations: content (max 300 chars, required)

**Like** (`app/models/like.rb`)
- Join model for users liking messages
- `belongs_to :user`
- `belongs_to :user_message`
- Validation: unique per user per message (`uniqueness: { scope: :user_message_id }`)

### Authentication System

Session-based authentication in `ApplicationController` (app/controllers/application_controller.rb):
- `current_user` - Returns logged-in user or nil
- `logged_in?` - Boolean check for authentication
- `require_login` - Before action to protect routes
- `require_logout` - Before action to prevent logged-in access

Routes:
- `GET /login` → `sessions#new`
- `POST /login` → `sessions#create`
- `DELETE /logout` → `sessions#destroy`

### Avatar System

Users have avatars managed through two mechanisms:
1. `image_name` column - references PNG files in `public/avatars/`
2. `has_one_attached :avatar` - Active Storage (may not be fully implemented)

Use `User#avatar_url` method to get avatar path (returns `/avatars/#{image_name}` or `/avatars/default.png`)

Use `User.avatar_options` to get list of available avatar images from `public/avatars/*.png`

### Routes Structure (`config/routes.rb`)

- Root: `GET /` → `home#top`
- Sessions: `/login` (GET/POST), `/logout` (DELETE)
- Resources: `users`, `user_messages`, `likes` (create/destroy only)
- Custom: `GET /users/:id/likes` → `users#likes` (shows messages liked by user)
- Mission Control: `/jobs` (background job monitoring)

## Database Schema

Key tables:
- `users`: name, email, password_digest, image_name
- `user_messages`: content, user_id
- `likes`: user_id, user_message_id
- Solid Queue/Cache/Cable tables for Rails 8 infrastructure

No foreign key constraints defined between users/user_messages/likes (uses integer references).

## Testing

Uses Rails default testing framework (Minitest):
- `test/models/` - Model tests
- `test/controllers/` - Controller tests
- `test/system/` - System tests with Capybara/Selenium
- `test/fixtures/` - Test data (users.yml, user_messages.yml, likes.yml, messages.yml)

System tests save screenshots to `tmp/screenshots/` on failure.

## CI/CD Pipeline (`.github/workflows/ci.yml`)

Four jobs run on PRs and main branch pushes:
1. `scan_ruby` - Brakeman + Bundler Audit
2. `scan_js` - Importmap audit
3. `lint` - RuboCop with caching
4. `test` - Rails tests with test database
5. `system-test` - Capybara system tests

Redis/Valkey service commented out (not currently used).

## Production Configuration

Puma web server configured for Render's 512MB plan:
- 1 worker process
- 2 threads (min and max)
- Preloads app for memory efficiency
- Port from ENV or 3000

## Code Style

Uses `rubocop-rails-omakase` - Rails Omakase Ruby style guide. Configuration in `.rubocop.yml` inherits from gem with minimal overrides.

## Important Notes

- Application enforces modern browser requirements (`allow_browser versions: :modern`)
- Uses `stale_when_importmap_changes` for ETags on HTML responses
- No Redis currently configured (Solid Queue/Cache/Cable use database)
- Legacy `messages` table exists but appears unused (likely replaced by `user_messages`)
