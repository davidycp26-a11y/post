# Post - 投稿管理アプリ

### 📝 概要
PostはRuby on Railsで構築されたシンプルな投稿管理アプリケーションです。基本的なCRUD（作成・読取・更新・削除）機能を提供します。

**デモサイト**: https://post-jvax.onrender.com/

### ✨ 機能
- 投稿の作成、表示、編集、削除
- PostgreSQLデータベースによるデータ管理
- レスポンシブなユーザーインターフェース
- Dockerサポート

### 🔧 必要要件
- **Ruby**: 3.4.7
- **Rails**: 8.x
- **PostgreSQL**: 最新版推奨
- **Node.js** と **Yarn/NPM**: フロントエンドアセット管理用
- **Bundler**: Gemの依存関係管理用

### ⚙️ セットアップ手順

#### 1. リポジトリのクローン
```bash
git clone https://github.com/davidycp26-a11y/post.git
cd post
```

#### 2. 依存関係のインストール
```bash
bundle install
```

#### 3. データベースの設定
`config/database.yml` を編集して、PostgreSQLの接続情報（ユーザー名、パスワード、ホスト）を設定してください。

```bash
# データベースの作成とマイグレーション
rails db:create
rails db:migrate
```

#### 4. サーバーの起動
```bash
rails server
```

ブラウザで `http://localhost:3000` にアクセスしてください。

### 📁 プロジェクト構成
```
post/
├── app/
│   ├── models/          # データモデル
│   ├── controllers/     # コントローラー
│   ├── views/           # ビュー（ERBテンプレート）
│   └── assets/          # CSS/SCSS、JavaScript
├── config/
│   ├── routes.rb        # ルート定義
│   └── database.yml     # データベース設定
├── db/                  # データベース関連ファイル
└── test/                # テストファイル
```

### 🐳 Docker での実行
```bash
docker build -t post-app .
docker run -p 3000:3000 post-app
```

### 🧪 テストの実行
```bash
rails test
```

### 📄 ライセンス
このプロジェクトはオープンソースです。

### 🤝 コントリビューション
プルリクエストを歓迎します！バグ報告や機能リクエストは Issue からお願いします。

---
### 📝 Overview
Post is a simple Ruby on Rails application for managing posts with basic CRUD (Create, Read, Update, Delete) functionality.

**Live Demo**: https://post-jvax.onrender.com/

### ✨ Features
- Create, read, update, and delete posts
- PostgreSQL database for data persistence
- Responsive user interface
- Docker support

### 🔧 Requirements
- **Ruby**: 3.4.7
- **Rails**: 8.x
- **PostgreSQL**: Latest version recommended
- **Node.js** and **Yarn/NPM**: For frontend asset management
- **Bundler**: For managing gem dependencies

### ⚙️ Installation & Setup

#### 1. Clone the Repository
```bash
git clone https://github.com/davidycp26-a11y/post.git
cd post
```

#### 2. Install Dependencies
```bash
bundle install
```

#### 3. Database Configuration
Edit `config/database.yml` and set your PostgreSQL credentials (username, password, host).

```bash
# Create and migrate the database
rails db:create
rails db:migrate
```

#### 4. Start the Server
```bash
rails server
```

Visit `http://localhost:3000` in your browser.

### 📁 Project Structure
```
post/
├── app/
│   ├── models/          # Rails models
│   ├── controllers/     # Controllers
│   ├── views/           # Views (ERB templates)
│   └── assets/          # CSS/SCSS, JavaScript
├── config/
│   ├── routes.rb        # Route definitions
│   └── database.yml     # Database configuration
├── db/                  # Database files
└── test/                # Test files
```

### 🐳 Running with Docker
```bash
docker build -t post-app .
docker run -p 3000:3000 post-app
```

### 🧪 Running Tests
```bash
rails test
```

### 📄 License
This project is open source.

### 🤝 Contributing
Pull requests are welcome! For bug reports or feature requests, please open an issue.

---
### 🌟 Acknowledgments
Built with Ruby on Rails 8.x and PostgreSQL.
