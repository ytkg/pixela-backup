# pixela-backup

Pixelaのグラフをバックアップするためのスクリプト

## 使い方

### 環境変数の設定
```bash
cp .env.sample .env
vim .env
```

### 実行
```bash
bundle install
bundle exec ruby app.rb source_graph_id target_graph_id
```
