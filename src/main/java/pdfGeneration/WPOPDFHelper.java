package pdfGeneration;

import Frameworkpackage.CommonFunctions;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.LinkedHashMap;

/**
 * WPOPDFHelper
 * ─────────────────────────────────────────────────────────────────────────────
 * Generates styled A4 PDF receipts for Akibah Heights society.
 * The letterhead PNG is stamped as a full-page background on every page so the
 * society logo, registration line, contact info and address footer are always
 * present without duplicating them in code.
 *
 * Content is placed inside the safe content zone defined by MARGIN_* constants,
 * which are tuned to clear the letterhead's pre-printed header and footer bands.
 */
public class WPOPDFHelper extends PdfPageEventHelper {

    // ── Letterhead ─────────────────────────────────────────────────────────────
    // Loaded from the classpath so it works from IDE, Maven and packaged JARs.
    private static final String LETTERHEAD_RES = "AkibahLetterHead.png";

    // ── Content-zone margins (points) ──────────────────────────────────────────
    // Top    : clears logo + society name + reg line + contact line (~150 pt)
    // Bottom : clears address / map footer of the letterhead (~52 pt)
    // Left/Right : match the letterhead's inner padding
    private static final float MARGIN_LEFT   = 36f;
    private static final float MARGIN_RIGHT  = 36f;
    private static final float MARGIN_TOP    = 152f;
    private static final float MARGIN_BOTTOM = 52f;

    // ── Brand colours ──────────────────────────────────────────────────────────
    private static final BaseColor BLUE_DARK  = new BaseColor(26,  58,  107); // #1A3A6B
    private static final BaseColor BLUE_MID   = new BaseColor(37,  99,  176); // #2563B0
    private static final BaseColor BLUE_LIGHT = new BaseColor(219, 234, 254); // #DBEAFE
    private static final BaseColor GOLD       = new BaseColor(201, 168,  76); // #C9A84C
    private static final BaseColor GREY_LABEL = new BaseColor(75,   85,  99); // #4B5563
    private static final BaseColor GREY_LIGHT = new BaseColor(245, 245, 245); // alt row

    // ── Shared fonts ───────────────────────────────────────────────────────────
    private static final Font F_LABEL   = FontFactory.getFont(FontFactory.HELVETICA_BOLD,    10, GREY_LABEL);
    private static final Font F_VALUE   = FontFactory.getFont(FontFactory.HELVETICA_BOLD,    10, BaseColor.BLACK);
    private static final Font F_TH      = FontFactory.getFont(FontFactory.HELVETICA_BOLD,    10, BaseColor.WHITE);
    private static final Font F_CELL    = FontFactory.getFont(FontFactory.HELVETICA,         10, BaseColor.BLACK);
    private static final Font F_TOTAL   = FontFactory.getFont(FontFactory.HELVETICA_BOLD,    12, BaseColor.WHITE);
    private static final Font F_WORDS   = FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE,  9, GREY_LABEL);
    private static final Font F_REMARK  = FontFactory.getFont(FontFactory.HELVETICA,         10, BaseColor.BLACK);
    private static final Font F_SIG_TTL = FontFactory.getFont(FontFactory.HELVETICA_BOLD,     9, BLUE_DARK);
    private static final Font F_SIG_NM  = FontFactory.getFont(FontFactory.HELVETICA,          9, GREY_LABEL);
    private static final Font F_RECNO_L = FontFactory.getFont(FontFactory.HELVETICA_BOLD,    10, GREY_LABEL);
    private static final Font F_RECNO_V = FontFactory.getFont(FontFactory.HELVETICA_BOLD,    10, BLUE_DARK);

    // ══════════════════════════════════════════════════════════════════════════
    //  PAGE EVENT — letterhead background on every page
    // ══════════════════════════════════════════════════════════════════════════
    @Override
public void onEndPage(PdfWriter writer, Document document) {
    try {

        Rectangle page = document.getPageSize();

        /*
         * Letterhead Background
         */
        PdfContentByte under = writer.getDirectContentUnder();

        URL res = WPOPDFHelper.class.getResource(LETTERHEAD_RES);

        if (res != null) {
            Image bg = Image.getInstance(res);

            bg.setAbsolutePosition(0, 0);
            bg.scaleAbsolute(page.getWidth(), page.getHeight());

            under.addImage(bg);
        }

        /*
         * Footer Watermark
         */
        PdfContentByte over = writer.getDirectContent();

        BaseFont bf = BaseFont.createFont(
                BaseFont.HELVETICA,
                BaseFont.WINANSI,
                BaseFont.NOT_EMBEDDED);

        over.saveState();

        over.beginText();

        over.setFontAndSize(bf, 12);

        // light grey
        over.setColorFill(new BaseColor(200, 200, 200));

        over.showTextAligned(
                Element.ALIGN_CENTER,
                "Powered by www.abcdomain.in",
                page.getWidth() / 2,
                45,
                0);

        over.endText();

        over.restoreState();

    } catch (Exception e) {
        e.printStackTrace();
    }
}

    // ══════════════════════════════════════════════════════════════════════════
    //  generatePDFForReceipt — Society Maintenance Receipt
    // ══════════════════════════════════════════════════════════════════════════
    public static void generatePDFForReceipt(
            String destinationPath,
            LinkedHashMap<String, String> rd)
            throws DocumentException, MalformedURLException, IOException {

        Document doc = new Document(
                PageSize.A4, MARGIN_LEFT, MARGIN_RIGHT, MARGIN_TOP, MARGIN_BOTTOM);

        PdfWriter writer = PdfWriter.getInstance(doc, new FileOutputStream(destinationPath));
        writer.setPageEvent(new WPOPDFHelper());
        doc.open();

        // ── Receipt No bar ────────────────────────────────────────────────────
        doc.add(receiptNoBar(rd.get("receipt_no")));
        doc.add(gap(5));

        // ── "Received With Thanks" banner ─────────────────────────────────────
        doc.add(receivedFromRow("Received With Thanks From", rd.get("owner_name")));
        doc.add(gap(6));

        // ── Details grid ──────────────────────────────────────────────────────
        PdfPTable details = twoColTable();
        addDetailCell(details, "Receipt Date",       rd.get("formattedCollectionDate"),   false);
        addDetailCell(details, "Block No",           rd.get("block_name"),                false);
        addDetailCell(details, "Flat No",            rd.get("flat_name"),                 true);
        addDetailCell(details, "Payment Mode",       rd.get("payment_mode"),              true);
        addDetailCell(details, "Maintenance From",   rd.get("maintenenceFromDateFormatted"), false);
        addDetailCell(details, "Maintenance To",     rd.get("maintenenceToDateFormatted"),   false);
        doc.add(details);
        doc.add(gap(8));

        // ── Particulars table ─────────────────────────────────────────────────
        doc.add(particularsTable(
                "Society Maintenance",
                rd.get("amount"),
                null,           // no remarks for maintenance receipt
                true));         // show amount-in-words
        doc.add(gap(20));

        // ── Signatures ────────────────────────────────────────────────────────
        doc.add(signatureTable());

        doc.close();
    }

    // ══════════════════════════════════════════════════════════════════════════
    //  generatePDFForTransferReceipt — Ownership Transfer Receipt
    // ══════════════════════════════════════════════════════════════════════════
    public static void generatePDFForTransferReceipt(
            String destinationPath,
            LinkedHashMap<String, String> rd)
            throws DocumentException, MalformedURLException, IOException {

        Document doc = new Document(
                PageSize.A4, MARGIN_LEFT, MARGIN_RIGHT, MARGIN_TOP, MARGIN_BOTTOM);

        PdfWriter writer = PdfWriter.getInstance(doc, new FileOutputStream(destinationPath));
        writer.setPageEvent(new WPOPDFHelper());
        doc.open();

        // ── Receipt No bar ────────────────────────────────────────────────────
        doc.add(receiptNoBar(rd.get("receipt_no")));
        doc.add(gap(5));

        // ── Ownership transfer info rows ──────────────────────────────────────
        PdfPTable transferInfo = oneColTable();
        addFullWidthRow(transferInfo, "From Owner",   rd.get("fromOwner"),    false);
        addFullWidthRow(transferInfo, "To Owner",     rd.get("toOwner"),      true);
        addFullWidthRow(transferInfo, "Reference No", rd.get("reference_no"), false);
        doc.add(transferInfo);
        doc.add(gap(6));

        // ── Details grid ──────────────────────────────────────────────────────
        PdfPTable details = twoColTable();
        addDetailCell(details, "Payment Date",  rd.get("paymentDate"),  false);
        addDetailCell(details, "Transfer Date", rd.get("transferDate"), false);
        addDetailCell(details, "Block No",      rd.get("block_name"),   true);
        addDetailCell(details, "Flat No",       rd.get("flat_name"),    true);
        addDetailCell(details, "Payment Mode",  rd.get("payment_mode"), false);
        // 6th cell — keep grid even
        PdfPCell blank = new PdfPCell(new Phrase(""));
        blank.setBackgroundColor(BaseColor.WHITE);
        blank.setBorderColor(new BaseColor(191, 219, 254));
        blank.setBorderWidth(0.5f);
        blank.setPadding(7f);
        details.addCell(blank);
        doc.add(details);
        doc.add(gap(8));

        // ── Particulars table ─────────────────────────────────────────────────
        doc.add(particularsTable(
                "Ownership Transfer Fees",
                rd.get("amount"),
                rd.get("remarks"),
                false));       // no amount-in-words for transfer receipt
        doc.add(gap(20));

        // ── Signatures ────────────────────────────────────────────────────────
        doc.add(signatureTable());

        doc.close();
    }

    // ══════════════════════════════════════════════════════════════════════════
    //  SHARED BUILDING BLOCKS
    // ══════════════════════════════════════════════════════════════════════════

    /**
     * Blue-light bar showing the receipt number aligned right.
     * Replaces the old grey header row — sits just below the letterhead.
     */
    private static PdfPTable receiptNoBar(String receiptNo) throws DocumentException {
        PdfPTable t = new PdfPTable(1);
        t.setWidthPercentage(100);
        t.setSpacingAfter(0);

        Phrase p = new Phrase();
        p.add(new Chunk("Receipt No :  ", F_RECNO_L));
        p.add(new Chunk(safe(receiptNo),  F_RECNO_V));

        PdfPCell c = new PdfPCell(p);
        c.setBackgroundColor(BLUE_DARK);
        c.setHorizontalAlignment(Element.ALIGN_CENTER);
        c.setPadding(8f);
        c.setBorder(Rectangle.NO_BORDER);

        // override text colour to white for the dark background
        Phrase pw = new Phrase();
        Font fl = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.WHITE);
        Font fv = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, GOLD);
        pw.add(new Chunk("Receipt No :  ", fl));
        pw.add(new Chunk(safe(receiptNo),  fv));
        c = new PdfPCell(pw);
        c.setBackgroundColor(BLUE_DARK);
        c.setHorizontalAlignment(Element.ALIGN_CENTER);
        c.setPadding(9f);
        c.setBorder(Rectangle.NO_BORDER);
        t.addCell(c);

        // Gold accent line below
        PdfPCell accent = new PdfPCell(new Phrase(""));
        accent.setFixedHeight(3f);
        accent.setBackgroundColor(GOLD);
        accent.setBorder(Rectangle.NO_BORDER);
        t.addCell(accent);

        return t;
    }

    /** Full-width "Received With Thanks From" / "From Owner" style banner. */
    private static PdfPTable receivedFromRow(String label, String value)
            throws DocumentException {
        PdfPTable t = new PdfPTable(1);
        t.setWidthPercentage(100);

        Phrase p = new Phrase();
        p.add(new Chunk(label + " :  ", F_LABEL));
        p.add(new Chunk(safe(value), F_VALUE));

        PdfPCell c = new PdfPCell(p);
        c.setBackgroundColor(BLUE_LIGHT);
        c.setBorderColor(BLUE_MID);
        c.setBorderWidth(0.8f);
        c.setPadding(9f);
        t.addCell(c);
        return t;
    }

    /** Base 2-column table for the details grid. */
    private static PdfPTable twoColTable() throws DocumentException {
        PdfPTable t = new PdfPTable(2);
        t.setWidthPercentage(100);
        t.setWidths(new float[]{1f, 1f});
        return t;
    }

    /** Base 1-column table for full-width info rows. */
    private static PdfPTable oneColTable() throws DocumentException {
        PdfPTable t = new PdfPTable(1);
        t.setWidthPercentage(100);
        return t;
    }

    /** Adds a label+value cell to a 2-col details table with alternating tint. */
    private static void addDetailCell(PdfPTable t, String label, String value, boolean tinted) {
        Phrase p = new Phrase();
        p.add(new Chunk(label + " :  ", F_LABEL));
        p.add(new Chunk(safe(value), F_VALUE));

        PdfPCell c = new PdfPCell(p);
        c.setBackgroundColor(tinted ? BLUE_LIGHT : BaseColor.WHITE);
        c.setBorderColor(new BaseColor(191, 219, 254));
        c.setBorderWidth(0.5f);
        c.setPadding(7f);
        t.addCell(c);
    }

    /** Adds a full-width label+value row to a 1-col table. */
    private static void addFullWidthRow(PdfPTable t, String label, String value, boolean tinted) {
        Phrase p = new Phrase();
        p.add(new Chunk(label + " :  ", F_LABEL));
        p.add(new Chunk(safe(value), F_VALUE));

        PdfPCell c = new PdfPCell(p);
        c.setBackgroundColor(tinted ? BLUE_LIGHT : BaseColor.WHITE);
        c.setBorderColor(new BaseColor(191, 219, 254));
        c.setBorderWidth(0.5f);
        c.setPadding(7f);
        t.addCell(c);
    }

    /**
     * Particulars table — header row, one data row, total row.
     * Optionally shows remarks row and/or amount-in-words.
     */
    private static PdfPTable particularsTable(
            String particular,
            String amount,
            String remarks,
            boolean showAmountInWords) throws DocumentException {

        PdfPTable t = new PdfPTable(2);
        t.setWidthPercentage(100);
        t.setWidths(new float[]{2.5f, 1f});

        // ── Header ─────────────────────────────────────────────────────────────
        t.addCell(thCell("Particulars", Element.ALIGN_CENTER));
        t.addCell(thCell("Amount (₹)",  Element.ALIGN_RIGHT));

        // ── Data row ───────────────────────────────────────────────────────────
        t.addCell(dataCell(safe(particular), Element.ALIGN_LEFT,  BaseColor.WHITE));
        t.addCell(dataCell(safe(amount),     Element.ALIGN_RIGHT, BaseColor.WHITE));

        // ── Remarks row (transfer receipt only) ────────────────────────────────
        if (remarks != null && !remarks.trim().isEmpty()) {
            Phrase rp = new Phrase();
            rp.add(new Chunk("Remarks :  ", F_LABEL));
            rp.add(new Chunk(safe(remarks), F_REMARK));
            PdfPCell rc = new PdfPCell(rp);
            rc.setColspan(2);
            rc.setBackgroundColor(GREY_LIGHT);
            rc.setBorderColor(new BaseColor(191, 219, 254));
            rc.setBorderWidth(0.5f);
            rc.setPadding(7f);
            t.addCell(rc);
        }

        // ── Total row ──────────────────────────────────────────────────────────
        PdfPCell totalCell = new PdfPCell(
                new Phrase("Total Amount :  ₹ " + safe(amount) + " /-", F_TOTAL));
        totalCell.setColspan(2);
        totalCell.setBackgroundColor(BLUE_MID);
        totalCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        totalCell.setPadding(10f);
        totalCell.setBorderWidthTop(2.5f);
        totalCell.setBorderColorTop(GOLD);
        totalCell.setBorderWidthBottom(0);
        totalCell.setBorderWidthLeft(0);
        totalCell.setBorderWidthRight(0);
        t.addCell(totalCell);

        // ── Amount in words ────────────────────────────────────────────────────
        if (showAmountInWords) {
            String words = new CommonFunctions().convertToIndianCurrency(safe(amount));
            PdfPCell wc = new PdfPCell(
                    new Phrase("Amount in Words :  " + words, F_WORDS));
            wc.setColspan(2);
            wc.setHorizontalAlignment(Element.ALIGN_RIGHT);
            wc.setBorder(Rectangle.NO_BORDER);
            wc.setPaddingTop(5f);
            wc.setPaddingBottom(2f);
            t.addCell(wc);
        }

        return t;
    }

    /** Signature block — Chairman left, Secretary right. */
    private static PdfPTable signatureTable() throws DocumentException {
        PdfPTable t = new PdfPTable(2);
        t.setWidthPercentage(100);
        t.setWidths(new float[]{1f, 1f});
        t.addCell(sigCell("Chairman", "Mukhtar Shaikh"));
        t.addCell(sigCell("Secretary", "Abidhusen Shaikh"));
        return t;
    }

    // ══════════════════════════════════════════════════════════════════════════
    //  CELL FACTORIES
    // ══════════════════════════════════════════════════════════════════════════

    private static PdfPCell thCell(String text, int align) {
        PdfPCell c = new PdfPCell(new Phrase(text, F_TH));
        c.setBackgroundColor(BLUE_DARK);
        c.setHorizontalAlignment(align);
        c.setPadding(9f);
        c.setBorder(Rectangle.BOX);
        c.setBorderColor(BLUE_DARK);
        return c;
    }

    private static PdfPCell dataCell(String text, int align, BaseColor bg) {
        PdfPCell c = new PdfPCell(new Phrase(text, F_CELL));
        c.setBackgroundColor(bg);
        c.setHorizontalAlignment(align);
        c.setPadding(8f);
        c.setBorderColor(new BaseColor(191, 219, 254));
        c.setBorderWidth(0.5f);
        return c;
    }

    private static PdfPCell sigCell(String role, String name) {
        Phrase p = new Phrase();
        p.add(new Chunk("_______________________\n", F_SIG_TTL));
        p.add(new Chunk(role + "\n", F_SIG_TTL));
        p.add(new Chunk(name, F_SIG_NM));

        PdfPCell c = new PdfPCell(p);
        c.setBorder(Rectangle.NO_BORDER);
        c.setHorizontalAlignment(Element.ALIGN_CENTER);
        c.setPaddingTop(4f);
        c.setPaddingBottom(4f);
        return c;
    }

    // ══════════════════════════════════════════════════════════════════════════
    //  UTILITIES
    // ══════════════════════════════════════════════════════════════════════════

    private static Paragraph gap(float pts) {
        Paragraph p = new Paragraph(" ");
        p.setSpacingAfter(pts);
        return p;
    }

    private static String safe(String s) {
        return (s == null) ? "" : s;
    }
}