package com.example.demo.entity;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import javax.imageio.ImageIO;
import java.util.Base64;

public class ImageResizer {

    public static String resizeImage(String imageData, int targetWidth, int targetHeight) throws Exception {
        byte[] imageBytes = Base64.getDecoder().decode(imageData);
        ByteArrayInputStream inputStream = new ByteArrayInputStream(imageBytes);
        BufferedImage originalImage = ImageIO.read(inputStream);

        // Calculate the new width and height while maintaining the aspect ratio
        int originalWidth = originalImage.getWidth();
        int originalHeight = originalImage.getHeight();
        int newWidth, newHeight;
        if (originalWidth > originalHeight) {
            newWidth = targetWidth;
            newHeight = (originalHeight * targetWidth) / originalWidth;
        } else {
            newHeight = targetHeight;
            newWidth = (originalWidth * targetHeight) / originalHeight;
        }

        // Create a scaled instance of the image
        Image scaledImage = originalImage.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH);

        // Create a BufferedImage object of the new size and type
        BufferedImage resizedImage = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_RGB);

        // Get the graphics context of the resized image and draw the scaled image onto it
        Graphics2D graphics2D = resizedImage.createGraphics();
        graphics2D.drawImage(scaledImage, 0, 0, null);
        graphics2D.dispose();

        // Convert the resized image to bytes
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        ImageIO.write(resizedImage, "jpg", outputStream);

        // Convert the resized image bytes to Base64 string
        byte[] resizedImageBytes = outputStream.toByteArray();
        String resizedImageData = Base64.getEncoder().encodeToString(resizedImageBytes);

        return resizedImageData;
    }
}