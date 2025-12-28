package com.aniket.ecommerce.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aniket.ecommerce.entity.Merchant;
import com.aniket.ecommerce.entity.Product;
import com.aniket.ecommerce.entity.User;
import com.aniket.ecommerce.service.MerchantService;
import com.aniket.ecommerce.service.ProductService;
import com.aniket.ecommerce.service.UserService;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;


@Controller

public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private MerchantService merchantService;
	
	@Autowired
	private UserService userService;
	
	
	
	@GetMapping(path ="/AddProduct")
	protected String AddProduct()
	{
		return "AddProduct";
	}
	
	 @GetMapping("/orders")
	    public String viewOrders(HttpSession session, Model model) {
		        User user = (User) session.getAttribute("user");
	        if (user == null) {
	            return "redirect:/userLogin";
	        }
	        
	        // Get all products with payment status true for this user
	        List<Product> purchasedProducts = productService.findByPaymentStatusTrue(user);
	        model.addAttribute("purchasedProducts", purchasedProducts);
	        
	        return "orders";
	    }
	@PostMapping("/saveProduct/{merchantId}")
	public String saveProduct(
	        @PathVariable("merchantId") int merchantId,
	        @RequestParam("productName") String productName,
	        @RequestParam("productDescription") String productDescription,
	        @RequestParam("productPrice") double productPrice,
	        @RequestParam("category") String category,
	        @RequestParam("image") MultipartFile imageFile,
	        ModelMap model) {

	    try {
	        Merchant merchant = merchantService.findMerchantById(merchantId);
	        if (merchant == null) {
	            throw new RuntimeException("Merchant not found");
	        }

	        Product product = new Product();
	        product.setProductName(productName);
	        product.setProductDescription(productDescription);
	        product.setProductPrice(productPrice);
	        product.setCategory(category);
	        product.setMerchant(merchant);

	        if (!imageFile.isEmpty()) {
	            product.setImage(imageFile.getBytes());
	        }

	        productService.saveProduct(product);
	        List<Product> products = merchant.getProducts();
	        model.addAttribute("products", products);
	        model.addAttribute("success", "Product saved successfully!");

	        return "MerchantproductView";

	    } catch (Exception e) {
	        model.addAttribute("error", "Error saving product: " + e.getMessage());
	        return "MerchantproductView";
	    }
	}

	
	@GetMapping("/products")
	public String getProductsByCategory(
	      @RequestParam(name = "category", required = false) String category,
	      HttpSession session,
	      Model model) {
	    User sessionUser = (User) session.getAttribute("user");
	    if (sessionUser != null) {
	        User currentUser = userService.findById(sessionUser.getId());
	        session.setAttribute("user", currentUser);
	    }
	    List<String> categories = productService.getAllCategories();
	    model.addAttribute("categories", categories);
	    Map<String, Long> categoryProductsCount = productService.getCategoryProductCounts();
	    model.addAttribute("categoryProductsCount", categoryProductsCount);
	    List<Product> products;
	    if (category != null && !category.isEmpty()) {
	        products = productService.getProductsByCategory(category);
	        model.addAttribute("selectedCategory", category);
	    } else {
	        products = productService.getAllProducts();
	    }
	    model.addAttribute("products", products);
	    
	    return "ProductsByCategory";
	}
	@GetMapping("/invoice/{productId}")
	public void generateInvoice(
	        @PathVariable("productId") int productId,
	        HttpServletResponse response,
	        HttpSession session) throws Exception {

	    User user = (User) session.getAttribute("user");
	    Product product = productService.findProductById(productId);
	    System.out.println(product.getMerchant());
	    Merchant merchant = product.getMerchant();

	    response.setContentType("application/pdf");
	    response.setHeader("Content-Disposition",
	            "attachment; filename=Invoice_" + productId + ".pdf");

	    Document document = new Document(PageSize.A4);
	    PdfWriter.getInstance(document, response.getOutputStream());
	    document.open();

	    Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
	    Font headingFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
	    Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 10);

	    // ===== COMPANY TITLE =====
	    Paragraph title = new Paragraph("SHOP EASE - TAX INVOICE", titleFont);
	    title.setAlignment(Element.ALIGN_CENTER);
	    document.add(title);
	    document.add(new Paragraph(" "));

	    // ===== MERCHANT DETAILS =====
	    document.add(new Paragraph("Seller Details", headingFont));
	    document.add(new Paragraph("Merchant ID : " + merchant.getId(), normalFont));
	    document.add(new Paragraph("Name        : " + merchant.getName(), normalFont));
	    document.add(new Paragraph("Email       : " + merchant.getEmail(), normalFont));
	    document.add(new Paragraph("Phone       : " + merchant.getPhone(), normalFont));
	    document.add(new Paragraph("Bank Name   : " + merchant.getBankName(), normalFont));
	    document.add(new Paragraph("Account No : " + merchant.getAccountNumber(), normalFont));
	    document.add(new Paragraph("IFSC Code  : " + merchant.getIfscCode(), normalFont));
	    document.add(new Paragraph(" "));

	    // ===== CUSTOMER DETAILS =====
	    document.add(new Paragraph("Bill To", headingFont));
	    document.add(new Paragraph("Customer Name : " + user.getName(), normalFont));
	    document.add(new Paragraph("Email         : " + user.getEmail(), normalFont));
	    document.add(new Paragraph(" "));

	    // ===== INVOICE META =====
	    document.add(new Paragraph("Invoice No : INV-" + product.getId(), normalFont));
	    document.add(new Paragraph("Invoice Date : " + LocalDate.now(), normalFont));
	    document.add(new Paragraph("Payment Status : PAID", normalFont));
	    document.add(new Paragraph(" "));

	    // ===== PRODUCT TABLE =====
	    PdfPTable table = new PdfPTable(5);
	    table.setWidthPercentage(100);
	    table.setWidths(new int[]{2, 4, 4, 2, 3});

	    table.addCell("Product ID");
	    table.addCell("Product Name");
	    table.addCell("Category");
	    table.addCell("Qty");
	    table.addCell("Price");

	    table.addCell(String.valueOf(product.getId()));
	    table.addCell(product.getProductName());
	    table.addCell(product.getCategory());
	    table.addCell("1");
	    table.addCell("₹ " + product.getProductPrice());

	    document.add(table);
	    document.add(new Paragraph(" "));

	    // ===== TOTAL =====
	    Paragraph total = new Paragraph(
	            "Total Amount : ₹ " + product.getProductPrice(),
	            headingFont);
	    total.setAlignment(Element.ALIGN_RIGHT);
	    document.add(total);

	    document.add(new Paragraph(" "));
	    document.add(new Paragraph(
	            "This is a computer-generated invoice and does not require a signature.",
	            normalFont));

	    document.close();
	}

	
}
