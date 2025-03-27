# Dockerfile.dev – Wails初期化のみで動作確認するための開発用Dockerfile
FROM golang:1.23

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    curl \
    pkg-config \
    libgtk-3-dev \
    libwebkit2gtk-4.0-dev \
    x11-apps

# Node.js のインストール（Wailsのdevコマンドでnpmコマンドが必要な場合に備える）
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
  && apt-get install -y nodejs

# Wails CLI のインストール
RUN go install github.com/wailsapp/wails/v2/cmd/wails@latest
ENV PATH="/go/bin:${PATH}"

# プロジェクト全体をコピー（backend/wails.json, go.mod, main.go などが含まれる想定）
WORKDIR /app
COPY . .

# 作業ディレクトリを backend に移動
WORKDIR /app/GopherBackend

# 必要なポートの公開
EXPOSE 8080
EXPOSE 5173

# Wailsの開発モードを起動
CMD ["wails", "dev"]
