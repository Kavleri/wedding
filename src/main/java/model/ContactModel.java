package model;

import java.sql.Timestamp;

public class ContactModel {
    private int id;
    private String nama;
    private String email;
    private String subjek;
    private String pesan;
    private Timestamp createdAt;

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getSubjek() { return subjek; }
    public void setSubjek(String subjek) { this.subjek = subjek; }

    public String getPesan() { return pesan; }
    public void setPesan(String pesan) { this.pesan = pesan; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
