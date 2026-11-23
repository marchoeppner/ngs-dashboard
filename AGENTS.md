# Agent Instructions: Rails Application Rules

You are an expert Rails developer working locally via Continue in VScodium. 
Always verify your work using local commands and inspect existing code for pattern matching before writing new code.

## 1. Stack & Environment
- **Core:** Rails 8+, Ruby 3.3+, SQLite.
- **Frontend:** Hotwire (Turbo & Stimulus) and standard ERB templates. (No React/SPA frameworks unless explicitly stated).
- **Security & Auth:** Rails built-in authentication.
- **Local Dev Constraint:** You are running locally. Do not attempt external API calls or internet-dependent lookups during your execution workflow.

## 2. Code Generation & Architecture Rules
- **Framework Defaults:** Trust Rails conventions. Do not rewrite native helper methods.
- **Fat Models, Lean Controllers:** Keep business logic in models or explicit Service Objects (`app/services/`). 
- **Pattern Matching:** Before creating a new Controller, Model, or Policy, inspect the nearest sibling file to perfectly match its naming convention, style, and testing setup.
- **I18n:** Never hardcode user-facing strings in views or controllers. Always append them to `config/locales/en.yml` and use `I18n.t()`.

## 3. Testing & Verification Requirements
- **Framework:** RSpec for unit/system tests. FactoryBot for test data.
- **Mandatory Output:** You must run tests for any code you modify. Do not guess if it works.
- **Access Control:** Any change to a controller or policy *must* include a corresponding test checking both authorized and unauthorized states.

## 4. Exact Execution Commands
Use these exact syntax blocks when running or validating code. Do not use generic placeholders.

- **Run specific test:** `bundle exec rspec spec/models/user_spec.rb`
- **Run full suite:** `bundle exec rspec`
- **Linter & Code Style:** `bundle exec rubocop -A` (Run and auto-correct before finalizing your task).
- **Database Migrations:** `bin/rails db:migrate dev:prime`

## 5. Context Map (Where to find things)
If a task requires deep domain knowledge, read these specific reference files first before editing code:
- **Authorization rules:** Look at `app/policies/application_policy.rb`
- **Data seeding / mocking:** Look at `db/seeds.rb` and `spec/factories/`
- **Background Jobs:** Look at `app/jobs/` (We use Solid Queue).
