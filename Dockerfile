# ベースイメージとして公式のRuby 3.2イメージ（ Debian/Ubuntu ベース）を使用
FROM ruby:3.2

# 必要なLinuxパッケージをインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /app

# GemfileとGemfile.lockをコピー（依存関係インストールのため）
COPY Gemfile Gemfile.lock ./

# Bundlerを使用してGemをインストール
RUN gem install bundler && bundle install

# コンテナ内で起動するデフォルトコマンドを設定
CMD ["irb"]