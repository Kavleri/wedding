package model;

public class PackageModel {
    private int id;
    private String namaPaket; // <--- UDAH DIGANTI
    private String deskripsi;
    private double harga;
    private String gambar;
    private int kategoriId; // Tambahan FK
    private String namaKategori; // Tambahan untuk Display

    public PackageModel() {}

    // Getter & Setter (Otomatis menyesuaikan)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    // Perhatikan huruf besar kecilnya (CamelCase)
    public String getNamaPaket() { return namaPaket; } 
    public void setNamaPaket(String namaPaket) { this.namaPaket = namaPaket; }

    public String getDeskripsi() { return deskripsi; }
    public void setDeskripsi(String deskripsi) { this.deskripsi = deskripsi; }

    public double getHarga() { return harga; }
    public void setHarga(double harga) { this.harga = harga; }

    public String getGambar() { return gambar; }
    public void setGambar(String gambar) { this.gambar = gambar; }
    
    public int getKategoriId() { return kategoriId; }
    public void setKategoriId(int kategoriId) { this.kategoriId = kategoriId; }
    
    public String getNamaKategori() { return namaKategori; }
    public void setNamaKategori(String namaKategori) { this.namaKategori = namaKategori; }
}