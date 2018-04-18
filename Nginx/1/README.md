## Soal 1

### Deskripsi Soal
1. Buatlah Vagrantfile sekaligus provisioning-nya untuk menyelesaikan kasus.

### STEP
1. Vagrant box yang digunakan adalah `ubuntu/xenial64`

2. VM menggunakan private network
- __192.168.0.2__ IP Load Blancer
- __192.168.0.3__ IP Worker 1
- __192.168.0.4__ IP Worker 2

3. Script provisioning untuk Load Balancer:
```bash
sudo apt-get update
sudo apt-get install -y nginx
sudo service nginx restart
```

4. Script provisioning untuk Worker:
```bash
sudo apt-get update
sudo apt-get install -y php7.0 php7.0-cgi php7.0-cli apache2 libapache2-php7.0
sudo a2enmod libapache2-php7.0
sudo service apache2 restart
```

5. Untuk konfigurasi pada VM yang dijadikan Load Balancer, kami menggunakan fitur sync folder dari vagrant:
Pada __/etc/nginx/sites-enabled/default__ konfigurasinya menjadi:
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
