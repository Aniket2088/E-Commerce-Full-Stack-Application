package com.aniket.ecommerce.service;



import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
@Service
public class ImageUploadService {
	
	@Autowired
	private Cloudinary cloudinary;
	
	public String uploadProductImage(MultipartFile file,int productId) throws IOException
	{
	       Map uploadResult = cloudinary.uploader().upload(
	               file.getBytes(),
	               ObjectUtils.asMap(
	                   "public_id", "products/product_" + productId,  // organized folder
	                   "overwrite", true,
	                   "resource_type", "image"
	               )
	           );
	           return (String) uploadResult.get("secure_url");
	}
	
	public void deleteProductImage(String imageUrl) throws IOException
	{
		  String publicId = imageUrl
		            .substring(imageUrl.lastIndexOf("/upload/") + 8)
		            .replaceAll("\\.[^.]+$", "");
		  cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
	}

}
