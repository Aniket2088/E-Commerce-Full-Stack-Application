package com.aniket.ecommerce.controller;

import com.aniket.ecommerce.entity.Merchant;
import com.aniket.ecommerce.entity.Order;
import com.aniket.ecommerce.entity.OrderItem;
import com.aniket.ecommerce.entity.User;
import com.aniket.ecommerce.service.OrderService;
import com.aniket.ecommerce.service.UserService;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.itextpdf.text.pdf.draw.LineSeparator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class InvoiceController {

    @Autowired private OrderService orderService;
    @Autowired private UserService  userService;

    // ── Colours ──────────────────────────────────────────────────
    private static final BaseColor PRIMARY      = new BaseColor(42,  63,  84);
    private static final BaseColor ACCENT       = new BaseColor(52,  152, 219);
    private static final BaseColor SECONDARY    = new BaseColor(231, 76,  60);
    private static final BaseColor LIGHT_BG     = new BaseColor(248, 249, 250);
    private static final BaseColor MID_GRAY     = new BaseColor(108, 117, 125);
    private static final BaseColor SUCCESS      = new BaseColor(46,  204, 113);
    private static final BaseColor MERCHANT_BG  = new BaseColor(232, 245, 253); // soft blue

    // ── Fonts ─────────────────────────────────────────────────────
    private static final Font F_BRAND    = new Font(Font.FontFamily.HELVETICA, 26, Font.BOLD,   PRIMARY);
    private static final Font F_TITLE    = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD,   BaseColor.WHITE);
    private static final Font F_SECTION  = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD,   PRIMARY);
    private static final Font F_LABEL    = new Font(Font.FontFamily.HELVETICA, 8,  Font.BOLD,   MID_GRAY);
    private static final Font F_VALUE    = new Font(Font.FontFamily.HELVETICA, 9,  Font.NORMAL, PRIMARY);
    private static final Font F_TH       = new Font(Font.FontFamily.HELVETICA, 9,  Font.BOLD,   BaseColor.WHITE);
    private static final Font F_TD       = new Font(Font.FontFamily.HELVETICA, 9,  Font.NORMAL, PRIMARY);
    private static final Font F_TD_SMALL = new Font(Font.FontFamily.HELVETICA, 8,  Font.ITALIC, MID_GRAY);
    private static final Font F_TOTAL_V  = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD,   SECONDARY);
    private static final Font F_FOOTER   = new Font(Font.FontFamily.HELVETICA, 8,  Font.ITALIC, MID_GRAY);
    private static final Font F_PAID     = new Font(Font.FontFamily.HELVETICA, 22, Font.BOLD,   SUCCESS);
    private static final Font F_MERCHANT = new Font(Font.FontFamily.HELVETICA, 9,  Font.BOLD,   ACCENT);

    // ─────────────────────────────────────────────────────────────
    @GetMapping("/downloadInvoice/{orderId}")
    public void downloadInvoice(@PathVariable("orderId") int orderId,
                                HttpSession session,
                                HttpServletResponse response) throws IOException, DocumentException {

        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) { response.sendRedirect("/userLogin"); return; }

        User  user  = userService.findById(sessionUser.getId());
        Order order = orderService.findById(orderId);

        if (order == null || order.getUser().getId() != user.getId()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN); return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "attachment; filename=ShopEase_Invoice_" + orderId + ".pdf");

        Document doc = new Document(PageSize.A4, 40, 40, 40, 60);
        PdfWriter writer = PdfWriter.getInstance(doc, response.getOutputStream());
        writer.setPageEvent(new FooterEvent());
        doc.open();

        // ════════════════════════════════════════════════
        // 1. HEADER BAR
        // ════════════════════════════════════════════════
        PdfPTable header = new PdfPTable(2);
        header.setWidthPercentage(100);
        header.setWidths(new float[]{1.5f, 1f});

        // Brand side
        PdfPCell brandCell = new PdfPCell();
        brandCell.setBorder(Rectangle.NO_BORDER);
        brandCell.setBackgroundColor(PRIMARY);
        brandCell.setPadding(16);
        brandCell.addElement(new Paragraph("ShopEase", F_BRAND));
        Font tagFont = new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL,
                new BaseColor(180, 200, 220));
        brandCell.addElement(new Paragraph("Your Trusted Online Store", tagFont));
        header.addCell(brandCell);

        // Invoice title side
        PdfPCell titleCell = new PdfPCell();
        titleCell.setBorder(Rectangle.NO_BORDER);
        titleCell.setBackgroundColor(ACCENT);
        titleCell.setPadding(16);
        titleCell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        Paragraph invoiceTitle = new Paragraph("INVOICE", F_TITLE);
        invoiceTitle.setAlignment(Element.ALIGN_RIGHT);
        titleCell.addElement(invoiceTitle);
        Font invNoFont = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, BaseColor.WHITE);
        Paragraph invNo = new Paragraph("#INV-" + String.format("%05d", orderId), invNoFont);
        invNo.setAlignment(Element.ALIGN_RIGHT);
        titleCell.addElement(invNo);
        header.addCell(titleCell);
        doc.add(header);
        doc.add(Chunk.NEWLINE);

        // ════════════════════════════════════════════════
        // 2. THREE-COLUMN INFO ROW
        //    [BILL TO]  |  [ORDER DETAILS]  |  [SOLD BY]
        // ════════════════════════════════════════════════

        // Collect unique merchants from this order
        Map<Integer, Merchant> merchantMap = new LinkedHashMap<>();
        for (OrderItem item : order.getOrderItems()) {
            if (item.getProduct() != null && item.getProduct().getMerchant() != null) {
                Merchant m = item.getProduct().getMerchant();
                merchantMap.put(m.getId(), m);
            }
        }

        PdfPTable infoTable = new PdfPTable(3);
        infoTable.setWidthPercentage(100);
        infoTable.setWidths(new float[]{1f, 1f, 1f});
        infoTable.setSpacingAfter(14);

        // Bill To
        infoTable.addCell(infoSection("BILL TO",
                user.getName()  + "\n" +
                user.getEmail() + "\n" +
                safe(user.getPhone()),
                LIGHT_BG));

        // Order Details
        String orderDate = "N/A";
        if (order.getOrderDate() != null) {
            try { orderDate = order.getOrderDate().toString()
                    .substring(0, 16).replace("T", "  "); }
            catch (Exception ignored) {}
        }
        infoTable.addCell(infoSection("ORDER DETAILS",
                "Order ID : #" + orderId             + "\n" +
                "Date     : "  + orderDate            + "\n" +
                "Status   : "  + order.getPaymentStatus(),
                LIGHT_BG));

        // Sold By — list every merchant in this order
        StringBuilder soldBy = new StringBuilder();
        if (merchantMap.isEmpty()) {
            soldBy.append("N/A");
        } else {
            boolean first = true;
            for (Merchant m : merchantMap.values()) {
                if (!first) soldBy.append("\n"); // gap between merchants
                first = false;
                soldBy.append(m.getName()).append("\n");
                if (!empty(m.getEmail()))       soldBy.append(m.getEmail()).append("\n");
                if (!empty(m.getBankName()))     soldBy.append("Bank : ").append(m.getBankName()).append("\n");
                if (!empty(m.getIfscCode()))     soldBy.append("IFSC : ").append(m.getIfscCode());
            }
        }
        infoTable.addCell(infoSection("SOLD BY", soldBy.toString().trim(), MERCHANT_BG));
        doc.add(infoTable);

        // ════════════════════════════════════════════════
        // 3. ITEMS TABLE
        //    Product | Merchant | Category | Price | Qty | Subtotal
        // ════════════════════════════════════════════════
        doc.add(sectionHeading("ORDER ITEMS"));
        doc.add(Chunk.NEWLINE);

        PdfPTable itemsTable = new PdfPTable(6);
        itemsTable.setWidthPercentage(100);
        itemsTable.setWidths(new float[]{2.8f, 1.6f, 1.2f, 1.2f, 0.7f, 1.3f});
        itemsTable.setSpacingAfter(12);

        String[] ths   = {"PRODUCT", "MERCHANT", "CATEGORY", "UNIT PRICE", "QTY", "SUBTOTAL"};
        int[]    aligns = {Element.ALIGN_LEFT, Element.ALIGN_LEFT, Element.ALIGN_CENTER,
                           Element.ALIGN_RIGHT, Element.ALIGN_CENTER, Element.ALIGN_RIGHT};
        for (int i = 0; i < ths.length; i++) {
            PdfPCell th = new PdfPCell(new Phrase(ths[i], F_TH));
            th.setBackgroundColor(PRIMARY);
            th.setPadding(8);
            th.setHorizontalAlignment(aligns[i]);
            th.setBorder(Rectangle.NO_BORDER);
            itemsTable.addCell(th);
        }

        double grandTotal = 0;
        boolean stripe = false;
        for (OrderItem item : order.getOrderItems()) {
            double subtotal = item.getPriceAtTime() * item.getQuantity();
            grandTotal += subtotal;
            BaseColor rowBg = stripe ? LIGHT_BG : BaseColor.WHITE;
            stripe = !stripe;

            // Product name + short description below it
            PdfPCell productCell = new PdfPCell();
            productCell.setBackgroundColor(rowBg);
            productCell.setPadding(7);
            productCell.setBorderColor(new BaseColor(230, 230, 230));
            productCell.setBorderWidth(0.5f);
            productCell.addElement(new Phrase(item.getProduct().getProductName(), F_TD));
            productCell.addElement(new Phrase(
                    truncate(item.getProduct().getProductDescription(), 45), F_TD_SMALL));
            itemsTable.addCell(productCell);

            // Merchant name — blue bold to stand out
            String mName = (item.getProduct().getMerchant() != null)
                    ? item.getProduct().getMerchant().getName() : "—";
            PdfPCell mCell = new PdfPCell(new Phrase(mName, F_MERCHANT));
            mCell.setBackgroundColor(rowBg);
            mCell.setPadding(7);
            mCell.setBorderColor(new BaseColor(230, 230, 230));
            mCell.setBorderWidth(0.5f);
            itemsTable.addCell(mCell);

            itemsTable.addCell(tdCell(item.getProduct().getCategory(),   Element.ALIGN_CENTER, rowBg));
            itemsTable.addCell(tdCell(rupee(item.getPriceAtTime()),       Element.ALIGN_RIGHT,  rowBg));
            itemsTable.addCell(tdCell(String.valueOf(item.getQuantity()), Element.ALIGN_CENTER, rowBg));
            itemsTable.addCell(tdCell(rupee(subtotal),                    Element.ALIGN_RIGHT,  rowBg));
        }
        doc.add(itemsTable);

        // ════════════════════════════════════════════════
        // 4. BARCODE  +  TOTALS BOX
        // ════════════════════════════════════════════════
        double tax   = grandTotal * 0.18;
        double total = grandTotal + tax;

        PdfPTable totalsWrapper = new PdfPTable(2);
        totalsWrapper.setWidthPercentage(100);
        totalsWrapper.setWidths(new float[]{1.8f, 1f});

        // Barcode cell (left)
        PdfPCell barcodeCell = new PdfPCell();
        barcodeCell.setBorder(Rectangle.NO_BORDER);
        barcodeCell.setPaddingTop(8);
        Barcode128 barcode = new Barcode128();
        barcode.setCode("SHOPEASE-" + String.format("%05d", orderId));
        barcode.setBarHeight(40);
        barcode.setX(1.2f);
        barcode.setFont(null);
        PdfContentByte cb = writer.getDirectContent();
        Image barcodeImg = barcode.createImageWithBarcode(cb, PRIMARY, PRIMARY);
        barcodeImg.scaleToFit(180, 55);
        Paragraph bcLabel = new Paragraph("Order Barcode", F_LABEL);
        bcLabel.setSpacingAfter(3);
        barcodeCell.addElement(bcLabel);
        PdfPTable bcWrap = new PdfPTable(1);
        bcWrap.setWidthPercentage(65);
        bcWrap.setHorizontalAlignment(Element.ALIGN_LEFT);
        PdfPCell bcImgCell = new PdfPCell(barcodeImg);
        bcImgCell.setBorder(Rectangle.BOX);
        bcImgCell.setBorderColor(new BaseColor(220, 220, 220));
        bcImgCell.setPadding(6);
        bcWrap.addCell(bcImgCell);
        barcodeCell.addElement(bcWrap);
        barcodeCell.addElement(new Paragraph(
                "Ref: SHOPEASE-" + String.format("%05d", orderId), F_FOOTER));
        totalsWrapper.addCell(barcodeCell);

        // Totals box (right)
        PdfPTable totalsBox = new PdfPTable(2);
        totalsBox.setWidthPercentage(100);
        addTotalRow(totalsBox, "Subtotal",  rupee(grandTotal), BaseColor.WHITE);
        addTotalRow(totalsBox, "Tax (18%)", rupee(tax),        LIGHT_BG);
        addTotalRow(totalsBox, "Shipping",  "FREE",            BaseColor.WHITE);

        Font gtFont    = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.WHITE);
        Font gtValFont = new Font(Font.FontFamily.HELVETICA, 13, Font.BOLD, BaseColor.WHITE);
        PdfPCell gtLabel = new PdfPCell(new Phrase("GRAND TOTAL", gtFont));
        gtLabel.setBackgroundColor(PRIMARY); gtLabel.setPadding(10); gtLabel.setBorder(Rectangle.NO_BORDER);
        PdfPCell gtValue = new PdfPCell(new Phrase(rupee(total), gtValFont));
        gtValue.setBackgroundColor(SECONDARY); gtValue.setPadding(10);
        gtValue.setHorizontalAlignment(Element.ALIGN_RIGHT); gtValue.setBorder(Rectangle.NO_BORDER);
        totalsBox.addCell(gtLabel);
        totalsBox.addCell(gtValue);

        PdfPCell totalsBoxCell = new PdfPCell(totalsBox);
        totalsBoxCell.setBorder(Rectangle.NO_BORDER);
        totalsWrapper.addCell(totalsBoxCell);
        doc.add(totalsWrapper);
        doc.add(Chunk.NEWLINE);

        // ════════════════════════════════════════════════
        // 5. PAID STAMP
        // ════════════════════════════════════════════════
        if ("PAID".equalsIgnoreCase(order.getPaymentStatus())) {
            PdfPTable stampTable = new PdfPTable(1);
            stampTable.setWidthPercentage(28);
            stampTable.setHorizontalAlignment(Element.ALIGN_RIGHT);
            PdfPCell stampCell = new PdfPCell(new Phrase("  PAID", F_PAID));
            stampCell.setBorder(Rectangle.BOX);
            stampCell.setBorderColor(SUCCESS);
            stampCell.setBorderWidth(2.5f);
            stampCell.setPadding(10);
            stampCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            stampTable.addCell(stampCell);
            doc.add(stampTable);
        }

        // ════════════════════════════════════════════════
        // 6. FOOTER STRIP
        // ════════════════════════════════════════════════
        doc.add(Chunk.NEWLINE);
        doc.add(new Chunk(new LineSeparator(1, 100,
                new BaseColor(220, 220, 220), Element.ALIGN_CENTER, -2)));
        doc.add(Chunk.NEWLINE);
        Paragraph thanks = new Paragraph(
            "Thank you for shopping with ShopEase!  |  support@shopease.com  |  www.shopease.com",
            F_FOOTER);
        thanks.setAlignment(Element.ALIGN_CENTER);
        doc.add(thanks);
        Paragraph tnc = new Paragraph(
            "Computer-generated invoice — no signature required. Quote Order ID for queries.",
            F_FOOTER);
        tnc.setAlignment(Element.ALIGN_CENTER);
        tnc.setSpacingBefore(3);
        doc.add(tnc);

        doc.close();
    }

    // ── Small helpers ─────────────────────────────────────────────

    private String rupee(double v) { return String.format("Rs. %.2f", v); }
    private String safe(String s)  { return s == null ? "" : s; }
    private boolean empty(String s){ return s == null || s.trim().isEmpty(); }

    private String truncate(String s, int max) {
        if (s == null) return "";
        return s.length() <= max ? s : s.substring(0, max) + "...";
    }

    private PdfPCell infoSection(String title, String content, BaseColor bg) {
        PdfPCell cell = new PdfPCell();
        cell.setBorder(Rectangle.BOX);
        cell.setBorderColor(new BaseColor(220, 220, 220));
        cell.setPadding(11);
        cell.setBackgroundColor(bg);
        Paragraph t = new Paragraph(title, F_LABEL);
        t.setSpacingAfter(5);
        cell.addElement(t);
        for (String line : content.split("\n")) {
            if (!line.trim().isEmpty())
                cell.addElement(new Paragraph(line.trim(), F_VALUE));
        }
        return cell;
    }

    private Paragraph sectionHeading(String text) {
        Paragraph p = new Paragraph(text, F_SECTION);
        p.setSpacingBefore(4);
        return p;
    }

    private PdfPCell tdCell(String text, int align, BaseColor bg) {
        PdfPCell cell = new PdfPCell(new Phrase(text, F_TD));
        cell.setHorizontalAlignment(align);
        cell.setPadding(7);
        cell.setBackgroundColor(bg);
        cell.setBorderColor(new BaseColor(230, 230, 230));
        cell.setBorderWidth(0.5f);
        return cell;
    }

    private void addTotalRow(PdfPTable table, String label, String value, BaseColor bg) {
        PdfPCell lc = new PdfPCell(new Phrase(label, F_VALUE));
        lc.setBorder(Rectangle.NO_BORDER); lc.setPadding(6); lc.setBackgroundColor(bg);
        PdfPCell vc = new PdfPCell(new Phrase(value, F_TOTAL_V));
        vc.setBorder(Rectangle.NO_BORDER); vc.setPadding(6);
        vc.setHorizontalAlignment(Element.ALIGN_RIGHT); vc.setBackgroundColor(bg);
        table.addCell(lc);
        table.addCell(vc);
    }

    // ── Page-number footer ────────────────────────────────────────
    static class FooterEvent extends PdfPageEventHelper {
        private static final Font FF = new Font(Font.FontFamily.HELVETICA, 8,
                Font.ITALIC, new BaseColor(150, 150, 150));
        @Override
        public void onEndPage(PdfWriter writer, Document document) {
            ColumnText.showTextAligned(writer.getDirectContent(), Element.ALIGN_CENTER,
                new Phrase("ShopEase Invoice  |  Page " + writer.getPageNumber() +
                           "  |  Confidential", FF),
                (document.right() - document.left()) / 2 + document.leftMargin(),
                document.bottom() - 15, 0);
        }
    }
}