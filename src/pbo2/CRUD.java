package pbo2;

//import java.sql.DriverManager;
//import java.sql.Driver;
//import java.sql.Connection;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;

import java.sql.*;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class CRUD {
    private String database = "pbo_2";
    private String username = "root";
    private String password = "";
    private String url = "jdbc:mysql://localhost/" + database;
    public Connection koneksiDB;
    public String var_nama, var_status, var_telp = null;
    public boolean validasi = false;
    
    public CRUD() {
        try {
            Driver driverKoneksi = new com.mysql.jdbc.Driver();
            DriverManager.registerDriver(driverKoneksi);
            
            koneksiDB = DriverManager.getConnection(url, username, password);
            
            System.out.println("Berhasil koneksi!");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
        }
    }
    
    public void loadAnggota(JTable tabel, String namaTabel) {
        try {
            Statement perintah = koneksiDB.createStatement();
            ResultSet dataset = perintah.executeQuery("SELECT * FROM " + namaTabel);
            
            ResultSetMetaData metaData = dataset.getMetaData();
            int jumlahKolom = metaData.getColumnCount();
            
            DefaultTableModel model = new DefaultTableModel();
            
            for (int i = 1; i <= jumlahKolom; i++) {
                model.addColumn(metaData.getColumnName(i));
            }
            
            model.getDataVector().clear();
            model.fireTableDataChanged();
            
            while (dataset.next()) {
                Object[] baris = new Object[jumlahKolom];
                for (int i = 1; i <= jumlahKolom; i++) {
                    baris[i - 1] = dataset.getObject(i);
                }
            
                model.addRow(baris);
            }
            
            tabel.setModel(model);
        } catch (Exception e) {
        }
    }
    
    public void loadAnggotaSQL(JTable tabel, String sql) {
        try {
            Statement perintah = koneksiDB.createStatement();
            ResultSet dataset = perintah.executeQuery(sql);
            
            ResultSetMetaData metaData = dataset.getMetaData();
            int jumlahKolom = metaData.getColumnCount();
            
            DefaultTableModel model = new DefaultTableModel();
            
            for (int i = 1; i <= jumlahKolom; i++) {
                model.addColumn(metaData.getColumnName(i));
            }
            
            model.getDataVector().clear();
            model.fireTableDataChanged();
            
            while (dataset.next()) {
                Object[] baris = new Object[jumlahKolom];
                for (int i = 1; i <= jumlahKolom; i++) {
                    baris[i - 1] = dataset.getObject(i);
                }
            
                model.addRow(baris);
            }
            
            tabel.setModel(model);
        } catch (Exception e) {
        }
    }
    
    public void simpanAnggotaStatement(String id, String nama, String status, String telp) {
        try {
            Statement checkData = koneksiDB.createStatement();
            String checkPrimary = "SELECT * FROM anggota WHERE id_anggota='" +id+ "'";
            ResultSet result = checkData.executeQuery(checkPrimary);
            
            if (result.next()) {
                String isi = "Nama: " + result.getString("nama")
                        + "\nStatus: " + result.getString("status")
                        + "\nTelp: " + result.getString("telp");
                
                JOptionPane.showMessageDialog(null, "id_anggota sudah terdaftar!\n\n" + isi);
                
                this.validasi = true;
                this.var_nama = result.getString("nama");
                this.var_status = result.getString("status");
                this.var_telp = result.getString("telp");
            }
            else {
                String sql = "INSERT INTO anggota VALUE ('" 
                        +id+ "', '" 
                        +nama+ "', '" 
                        +status+ "', '" 
                        +telp+ "')";
            
                Statement perintah = koneksiDB.createStatement();
                perintah.execute(sql);
            
                JOptionPane.showMessageDialog(null, "Berhasil disimpan!");
                
                this.validasi = false;
                this.var_nama = null;
                this.var_status = null;
                this.var_telp = null;
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
    }
    
    public void simpanAnggotaPrepared(String id, String nama, String status, String telp) {
        try {
            String checkPrimary = "SELECT * FROM anggota WHERE id_anggota='" +id+ "'";
            Statement checkData = koneksiDB.createStatement();
            ResultSet res = checkData.executeQuery(checkPrimary);
            
            if (res.next()) {
                String isi = "Nama: " + res.getString("nama")
                        + "\nStatus: " + res.getString("status")
                        + "\nTelp: " + res.getString("telp");
                
                JOptionPane.showMessageDialog(null, "IDAnggota sudah terdaftar!\n" + isi);
                
                this.validasi = true;
                this.var_nama = res.getString("nama");
                this.var_status = res.getString("status");
                this.var_telp = res.getString("telp");
            }
            else {
                String sql = "INSERT INTO anggota VALUE (?, ?, ?, ?)";
                PreparedStatement perintah = koneksiDB.prepareStatement(sql);
                perintah.setString(1, id);
                perintah.setString(2, nama);
                perintah.setString(3, status);
                perintah.setString(4, telp);
                perintah.executeUpdate();
            
                JOptionPane.showMessageDialog(null, "Berhasil disimpan!");
                
                this.validasi = false;
                this.var_nama = null;
                this.var_status = null;
                this.var_telp = null;
            }                  
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
    }
    
    public void ubahAnggotaStatement(String id, String nama, String status, String telp) {
        try {
            String sqlUbah = "UPDATE anggota SET nama='" 
                    +nama+ "', status='" 
                    +status+ "', telp='" 
                    +telp+ "' WHERE idAnggota='" 
                    +id+ "'";
            
            Statement ubah = koneksiDB.createStatement();
            ubah.execute(sqlUbah);
            JOptionPane.showMessageDialog(null, "Data Berhasil Diubah ");
            
            } catch (Exception e) {   
                JOptionPane.showMessageDialog(null, e.getMessage());
            }        
        }
    
    public void ubahAnggotaPrepared(String id, String nama, String status, String telp) {
        try {
            String sqlUbah = "UPDATE anggota SET nama=?, status=?, telp=? WHERE id_anggota=?";
            
            PreparedStatement ubah = koneksiDB.prepareStatement(sqlUbah);
            ubah.setString(1, nama);
            ubah.setString(2, status);
            ubah.setString(3, telp);
            ubah.setString(4, id);
            
            ubah.executeUpdate();
            JOptionPane.showMessageDialog(null, "Data Berhasil Diubah ");            
        } catch (Exception e) {   
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
    }
    
    public void hapusAnggotaStatement(String id) {
        try {
            String sqlHapus = "DELETE FROM anggota WHERE id_anggota='" +id+ "'";
            Statement hapus = koneksiDB.createStatement();
            hapus.execute(sqlHapus);
            
            JOptionPane.showMessageDialog(null, "Data berhasil dihapus!");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
    }
    
    public void hapusAnggotaPrepared(String id) {
        try {
            String sqlHapus = "DELETE FROM anggota WHERE id_anggota='" +id+ "'";
            Statement hapus = koneksiDB.prepareStatement(sqlHapus);
            hapus.executeUpdate(sqlHapus);
            
            JOptionPane.showMessageDialog(null, "Data Berhasil Dihapus ! ");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
    }

}
