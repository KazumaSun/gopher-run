-- init.sql: 初期化スクリプト例
CREATE TABLE IF NOT EXISTS example (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);
