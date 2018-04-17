Create image dengan perintah:
```
docker image build . -t mysql_reservasi
```

Untuk docker compose sudah bisa sampe jadi container. DB nya juga sudah bisa diakses. Tinggal aplikasinya belum mau connect ke container mysql.

IP nya sengaja dibuat static semua.

> Note: untuk bisa menjalankan `docker-compose up` (alias membuat container berulang-ulang), perlu menghapus docker network yang dibuat lewat docker compose
