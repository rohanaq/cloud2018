## Soal

1. Buat 3 VM, 2 Ubuntu 16.04 sebagai worker, 1 Debian 9 sebagai DB server
2. Pada vm Debian install Mysql dan setup agar koneksi DB bisa diremote dan memiliki user:
    username: regal
    password: bolaubi

3. Pada worker:
    2.1. Install Nginx
    2.2. Install PHP 7.2
    2.3. Install composer
    2.4. Install Git

    dan pastikan worker dapat menjalankan Laravel 5.6
    
4. Clone [https://github.com/udinIMM/Hackathon](https://github.com/udinIMM/Hackathon) pada setiap worker dan setup database pada .env mengarah ke DB server.

5. Setup root directory nginx ke folder Laravel hasil clone repo diatas

## Penyelesaian
1. Grouping host pada file `hosts`
```
[db]
db ansible_host=10.151.36.185 ansible_ssh_user=ubuntu ansible_become_pass=ubuntu

[worker]
node1 ansible_host=10.151.36.187 ansible_ssh_user=ubuntu ansible_become_pass=ubuntu
node2 ansible_host=10.151.36.188 ansible_ssh_user=ubuntu ansible_become_pass=ubuntu
```

Kemudian jalankan perintah:
```
ansible -i ./hosts -m ping all -k
```

![ping](images/1.png)

2. Membuat file `master.yml` dengan isi sebagai berikut:
```
- hosts: worker
  become: yes
  pre_tasks:
    - name: uninstall apache2
      apt: name=apache2 state=absent
  roles:
    - { role: php7.2 }
    - { role: nginx }
    - { role: git }
    - { role: composer }
  vars:
    proxy_env: 'http://ITS-552131-cb09f:6aea3@proxy.its.ac.id:8080'
    sites: hackathon
    user_git: rohanaq
    path_to_app: /var/www/hackathon

- hosts: db
  become: yes
  become_user: root
  become_method: su
  vars:
    proxy_env: 'http://ITS-552131-cb09f:6aea3@proxy.its.ac.id:8080'
    username: 'regal'
    password: 'bolaubi'
  roles:
    - { role: db }
```

__Penjelasan:__
File `master.yml` digunakan untuk mengatur seluruh instalasi dan konfigurasi pada VM yang akan diremote.
- hosts: nama grup yang ada pada file `hosts`
- become: menjalankan proses sebagai root
- pre_task: sama seperti task tapi dijalankan terlebih dahulu
- roles: file roles yang terdapat pada direktori [roles](/Ansible/worker/roles)
- vars: variabel

Kemudian jalankan playbook dengan perintah:
```
ansible-playbook -i hosts master.yml -k
```
![playbook](images/2.png)

3. Cek pada browser
Worker 1 - 10.151.36.187
![worker1](images/3.png)

Worker 2 - 10.151.36.188
![worker2](images/4.png)