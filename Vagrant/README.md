# Tugas Sesi Lab Modul 1

1. Buat vagrant virtualbox dan buat user 'awan' dengan password 'buayakecil'

2. Buat vagrant virtualbox dan lakukan provisioning install Phoenix Web Framework

3. Buat vagrant virtualbox dan lakukan provisioning install:
	1. php
	2. mysql
	3. composer
	4. nginx
	
	Setelah melakukan provisioning, clone https://github.com/fathoniadi/pelatihan-laravel.git pada folder yang sama dengan vagrantfile di komputer host. Setelah itu sinkronisasi folder pelatihan-laravel host ke vagrant ke **/var/www/web** dan jangan lupa install vendor laravel agar dapat dijalankan. Setelah itu setting root document nginx ke **/var/www/web**. webserver VM harus dapat diakses pada port 8080 komputer host dan mysql pada vm dapat diakses pada port 6969 komputer host

4. Buat vagrant virtualbox dan lakukan provisioning install:
	1. Squid Proxy
	2. Bind9

Untuk melakukan provisioning install Squid Proxy dan Bind9 langkah yang diperlukan adalah dengan menghilangkan comment mulai baris `config.vm.provision "shell", inline: <<-SHELL` hingga `SHELL` dan mengganti perintah yang ada di dalamnya menjadi:

```
sudo apt-get update
sudo apt-get install -y squid3
sudo apt-get install -y bind9
```

![4-1](files/images/4-1.png)

Untuk mengecek apakah Squid Proxy dan Bind9 sudah terinstall pada Virtual Machine, ketikkan perintah _service squid3 status_ dan _service bind9 status_, bila keduanya sudah running maka Squid Proxy dan Bind9 sudah terinstall pada Virtual Machine.

![4-2](files/images/4-2.png)