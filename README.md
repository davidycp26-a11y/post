# README

# My sample on render
https://post-jvax.onrender.com/

# Post

A simple Ruby on Rails application for managing posts or messages with basic CRUD functionality.  
Repository: [https://github.com/davidycp26-a11y/post](https://github.com/davidycp26-a11y/post)

## 🔧 Requirements

- Ruby **3.4.7**  
- Rails **8.x**  
- PostgreSQL (for development and production)  
- Node.js and Yarn/NPM (for frontend assets if needed)  
- Bundler (for managing gems)

## ⚙️ Installation & Setup (Local Development)

1. Clone the repository  
   ～bash
   git clone https://github.com/davidycp26-a11y/post.git
   cd post

2. Install gems
   ～bash
   bundle install

3. Set up the database
   Edit config/database.yml and set correct username, password, and host
   Make sure PostgreSQL is installed and running

   ～bash
   rails db:create
   rails db:migrate

4. Start the Rails server
   ～bash
   rails server


## 📁 Project Structure

app/models – Rails models

app/controllers – Controllers

app/views – Views (ERB templates)

app/assets/stylesheets – SCSS/CSS files

config/routes.rb – Route definitions

config/database.yml – Database configuration
