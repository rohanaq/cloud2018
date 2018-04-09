## Soal 3

### Deskripsi Soal
3. Biasanya pada saat membuat website, data user yang sedang login disimpan pada session. Sesision secara default tersimpan pada memory pada sebuah host. Bagaimana cara mengatasi masalah session ketika kita melakukan load balancing?

### Jawab
Salah satu alternatif yang bisa digunakan adalah dengan menyimpan _session_ pada _datastore_ yang bisa diakses oleh server-server yang di-_loadbalance_.

Opsi lain yang bisa digunakan adalah dengan konsep _"Sticky Sessions"_ atau disebut juga dengan _"Session Affinity"_. Cara ini memungkinkan untuk mengaitkan _session_ milik _user_ kepada server tertentu. Dengan begitu, semua _request user_ pada _session_ tertentu ditangani oleh satu _server_ yang sama. Tinggal nanti menyesuaikan kira-kira berapa lama _load balancer_ akan mengarahkan _request_ dari _user_ yang sama secara konsisten.
