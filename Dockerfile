# ベースイメージとして公式のRuby 3.2イメージ（ Debian/Ubuntu ベース）を使用
FROM ruby:3.2

#  1 必要なLinuxパッケージをインストール
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

# @          @@          @@          @@          @@          @@          @@          @@          @
# 1. build-essential
# **build-essential**は、Ubuntu/Debian系環境でCやC++のコンパイルツールや`make`をインストールするためのメタパッケージです。
# Rubyで使用する一部のGem（例: pgやnokogiri）はCやC++のネイティブ拡張を含んでいるため、これらをビルドするために必要です。
# **Railsを使わない理由との関連**
# Railsを使用する場合でもネイティブ拡張Gemのビルドに必要ですが、フレームワークを使わない開発ではGemの選定やビルドを自分で管理する必要があるため、特に重要になります。
# **使用シーン**
# PostgreSQL用Gem（pg）やXML解析用Gem（nokogiri）などをインストールする際に必要になります。

# 2. nodejs
# **nodejs**はJavaScriptの実行環境で、フロントエンドのアセット管理やJavaScriptライブラリを活用するために使用されます。
# Railsを使う場合にはWebpackerやAsset Pipelineなどで必要になりますが、Railsを使わない場合には、これを手動で設定して使用します。
# **Railsを使わない理由との関連**
# フロントエンド開発の自由度を高めるためにWebpackや独自のアセット管理ツールを導入する必要があり、そのためNode.jsが必須です。
# **使用シーン**
# BootstrapやVue.js、Reactといったフロントエンドライブラリを手動でインストールして利用する場合に必要です。

# 3. npm
# **npm**はNode.jsの公式パッケージマネージャーで、JavaScriptライブラリやツールをインストールして管理するために使用されます。
# 例として、BootstrapやWebpack、ESLintなどを利用する場合にnpmを使用します。
# **Railsを使わない理由との関連**
# Railsを使わない場合、npmを使用してフロントエンドの依存関係を管理し、独自に設定する必要があります。
# **使用シーン**
# BootstrapやWebpackなどの依存関係をインストールする際、npmを使用して必要なパッケージを管理します。

# 4. apt-get clean
# **apt-get clean**は、パッケージのインストール時にダウンロードされた一時的なキャッシュファイルを削除します。
# Dockerイメージのサイズを軽量化するために使用されます。
# **Railsを使わない理由との関連**
# Railsを使わない場合でも、Dockerイメージを効率的に管理するための軽量化は必須です。Railsの依存を減らし、軽量なイメージを構築するための一環です。

# 5. rm -rf /var/lib/apt/lists/*
# **/var/lib/apt/lists/**ディレクトリには、`apt-get`がダウンロードしたパッケージリストが保存されています。
# このディレクトリを削除することで、Dockerイメージのサイズをさらに削減できます。
# **Railsを使わない理由との関連**
# Railsでは依存関係が多いためにイメージが大きくなりがちですが、Railsを使わない場合、軽量な環境を構築できる利点が強調されます。
# **使用シーン**
# 軽量なDockerイメージを作成し、CI/CDパイプラインの効率を向上させる場合に活用します。
