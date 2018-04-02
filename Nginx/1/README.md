## Soal 1

### Deskripsi Soal
1. Buatlah Vagrantfile sekaligus provisioning-nya untuk menyelesaikan kasus.

### STEP
1. Vagrant box yang digunakan adalah `ubuntu/xenial64`
2. VM menggunakan private network
- __192.168.0.2__ IP Load Blancer
- __192.168.0.3__ IP Worker 1
- __192.168.0.4__ IP Worker 2
3. Script provisioning:
```bash
sudo apt-get update
sudo apt-get install -y php7.0 php7.0-cgi php7.0-fpm nginx
```
4. Konfigurasi pada VM
Pada __/etc/nginx/sites-available/default__ ubah konfigurasinya menjadi:
```
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        index index.php index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
                proxy_pass http://worker;
        }

        location ~ \.php$ {
            include snippets/fastcgi-php.conf;
            fastcgi_pass 127.0.0.1:9000;

        }

        location ~ /\.ht {
                deny all;
        }
}
```
Untuk mengaktifkan suatu konfigurasi ketikkan perintah `sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/`

Pada __/etc/php/7.0/fpm/php.ini__, ubah baris yang berisi `#cgi.fix_pathinfo=1` menjadi `cgi.fix_pathinfo=0`

Pada __/etc/php/7.0/fpm/pool.d/www.conf__, comment baris yang berisi `listen = /run/php/php7.0-fpm.sock` kemudian tambahkan `listen = 127.0.0.1:9000` pada baris setelahnya

Jangan lupa restart Nginx dan php-fpm
```
sudo service nginx restart
sudo service php7.0-fpm restart
```

5. Menjadikan VM sebagai Load Balancer:
Pada __/etc/nginx/sites-available/default__ tambahkan konfigurasi berikut sebelum segmen server sehingga konfigurasi akhir menjadi:
```
# INI BUAT LOAD BALANCER
upstream worker {
   server 192.168.0.3;
   server 192.168.0.4;
}

server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        index index.php index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
                proxy_pass http://worker;
        }

        location ~ \.php$ {
            include snippets/fastcgi-php.conf;
            fastcgi_pass 127.0.0.1:9000;

        }

        location ~ /\.ht {
                deny all;
        }
}
```
Secara default, Nginx menggunakan algoritma __Round-Robin__ untuk load balancing. Untuk mengubah algoritma yang digunakan menjadi __Least Connections__ ubah segmen untuk load balancing menjadi:
```
upstream worker {
   least_conn;
   server 192.168.0.3;
   server 192.168.0.4;
}
```
Sedangkan untuk algoritma __IP Hash__, ubah menjadi:
```
upstream worker {
   ip_hash;
   server 192.168.0.3;
   server 192.168.0.4;
}
```
6. Membuat file index.php pada Worker 1 dan Worker 2 untuk testing.