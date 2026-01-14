package model;

public class BookingModel {
    private int id;
    private String namaPemesan;
    private String noHp;
    private String tanggalAcara;
    private String alamat;
    private int paketId;
    private String kodeBooking;
    private String status;

    // Getter & Setter (Biar datanya bisa diambil/diisi)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getKodeBooking() { return kodeBooking; }
    public void setKodeBooking(String kodeBooking) { this.kodeBooking = kodeBooking; }

    public String getNamaPemesan() { return namaPemesan; }
    public void setNamaPemesan(String namaPemesan) { this.namaPemesan = namaPemesan; }

    public String getNoHp() { return noHp; }
    public void setNoHp(String noHp) { this.noHp = noHp; }

    public String getTanggalAcara() { return tanggalAcara; }
    public void setTanggalAcara(String tanggalAcara) { this.tanggalAcara = tanggalAcara; }

    public String getAlamat() { return alamat; }
    public void setAlamat(String alamat) { this.alamat = alamat; }

    public int getPaketId() { return paketId; }
    public void setPaketId(int paketId) { this.paketId = paketId; }
}