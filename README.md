# gopher-run

## ホスト側での設定手順

### 1. X11 サーバーの設定

Wails のデスクトップモードを使用するために、ホストの X11 サーバーが Docker コンテナからの接続を許可する必要があります。

1. **`DISPLAY` 環境変数を確認**
   - 以下のコマンドを実行して、`DISPLAY` 環境変数が設定されていることを確認します。
     ```bash
     echo $DISPLAY
     ```
   - 通常、`:0` または `:1` のような値が表示されます。

2. **X11 サーバーのアクセスを許可**
   - 以下のコマンドを実行して、Docker コンテナからの接続を許可します。
     ```bash
     xhost +local:docker
     ```

---

### 2. 必要なパッケージのインストール

ホスト側で以下のパッケージがインストールされている必要があります。

- **X11 サーバー関連ツール**
  - Ubuntu/Debian 系:
    ```bash
    sudo apt-get update
    sudo apt-get install x11-xserver-utils
    ```
  - Fedora/RHEL 系:
    ```bash
    sudo dnf install xorg-x11-server-utils
    ```
  - Arch Linux 系:
    ```bash
    sudo pacman -S xorg-xhost
    ```

---

### 3. Docker のセットアップ

1. **Docker と Docker Compose のインストール**
   - Docker:
     ```bash
     sudo apt-get update
     sudo apt-get install docker.io
     ```
   - Docker Compose:
     ```bash
     sudo apt-get install docker-compose
     ```

2. **Docker の権限設定**
   - Docker コマンドを非 root ユーザーで実行できるようにするには、以下を実行します。
     ```bash
     sudo usermod -aG docker $USER
     ```
   - 設定を反映するために、ログアウトして再ログインしてください。

---

### 4. プロジェクトの起動

1. **Docker イメージのビルド**
   - プロジェクトのルートディレクトリで以下を実行します。
     ```bash
     docker-compose build
     ```

2. **Docker コンテナの起動**
   - 以下のコマンドでコンテナを起動します。
     ```bash
     docker-compose up
     ```

3. **アプリケーションの動作確認**
   - デスクトップモードの場合、Wails アプリケーションのウィンドウが表示されます。
   - ブラウザモードの場合、ブラウザで `http://localhost:5173` にアクセスしてください。

---

### 5. トラブルシューティング

1. **X11 サーバーに接続できない場合**
   - 以下のコマンドで X11 サーバーが動作しているか確認します。
     ```bash
     echo $DISPLAY
     ```
   - `xhost` コマンドでアクセスを再許可します。
     ```bash
     xhost +local:docker
     ```

2. **GTK 関連のエラーが発生する場合**
   - 必要な GTK ライブラリがインストールされていることを確認してください。
     ```bash
     sudo apt-get install libgtk-3-dev libwebkit2gtk-4.0-dev
     ```

---

これで、ホスト側の設定が完了し、プロジェクトを正しく動作させることができます。