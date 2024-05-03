package com.example.demo.configuration;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;

import org.springframework.web.multipart.MultipartFile;

public class TraitementImage {
	
	
	  public Blob multipartFileToBlob(MultipartFile file) throws IOException, SQLException {
	        if (file == null || file.isEmpty()) {
	            return null;
	        }
	        byte[] bytes = file.getBytes();
	        return new javax.sql.rowset.serial.SerialBlob(bytes);
	    }
	  
	    public String convertBlobToBase64(Blob blob) {
	        try {
	            byte[] bytes = blob.getBytes(1, (int) blob.length());
	            return Base64.getEncoder().encodeToString(bytes);
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return null;
	        }
	    }
}
