
package pdfGeneration;

import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.ListItem;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfGState;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;

public class QuotePDFHelper extends PdfPageEventHelper {
	public static void main(String[] args) throws DocumentException, MalformedURLException, IOException {


	}

	public static void generateQuotePDF(String path,LinkedHashMap<String, Object> quoteDetails, List<String> termsAndConditions)
			throws DocumentException, MalformedURLException, IOException {

		Document document = new Document(PageSize.A4, 20, 20, 20, 60);
		PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(path));
		writer.setCompressionLevel(9);
		writer.setFullCompression();
		
		List<LinkedHashMap<String, Object>> listOfItems=(List<LinkedHashMap<String, Object>>)quoteDetails.get("listOfItems");
		
		

		QuotePDFHelper event = new QuotePDFHelper();
		writer.setPageEvent(event);
		document.open();

		PdfPTable table = new PdfPTable(1);
		PdfPCell cell;
		// Font boldFont = newFont(Font.FontFamily.TIMES_ROMAN, 18, Font.UNDERLINE);
		Font regSmallFont = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL);
		cell = new PdfPCell(new Phrase("QUOTATION", new Font(Font.FontFamily.TIMES_ROMAN, 20, Font.BOLD)));
		cell.setBorder(Rectangle.NO_BORDER);

		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell);
		document.add(table);

		document.add(new Paragraph("\n"));

		table = new PdfPTable(3);
		table.setWidthPercentage(100);
		table.setWidths(new int[] { 1, 1, 2 });
		cell = new PdfPCell(new Phrase(""));
		cell.setBorder(Rectangle.NO_BORDER);
		table.addCell(cell);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase("Quote Ref No :-"+quoteDetails.get("quote_no").toString(), regSmallFont));
		cell.setBorder(Rectangle.NO_BORDER);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase(""));
		cell.setBorder(Rectangle.NO_BORDER);
		table.addCell(cell);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase(quoteDetails.get("theQuoteDate").toString(), regSmallFont));
		cell.setBorder(Rectangle.NO_BORDER);
		cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase("Kind Attention,", regSmallFont));
		cell.setBorder(Rectangle.NO_BORDER);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase(""));
		cell.setBorder(Rectangle.NO_BORDER);
		table.addCell(cell);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase(quoteDetails.get("customer_name").toString(), new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
		cell.setBorder(Rectangle.NO_BORDER);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		table.addCell(cell);
		cell = new PdfPCell(new Phrase(""));
		cell.setBorder(Rectangle.NO_BORDER);
		table.addCell(cell);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase("company name", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
		cell.setBorder(Rectangle.NO_BORDER);
		cell.setColspan(3);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase(quoteDetails.get("address").toString(), new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
		cell.setBorder(Rectangle.NO_BORDER);
		cell.setColspan(3);
		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		table.addCell(cell);

		if (!quoteDetails.get("mobile_number").equals("")) {
			cell = new PdfPCell(
					new Phrase("Contact +" + quoteDetails.get("mobile_number").toString(), new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
			cell.setBorder(Rectangle.NO_BORDER);
			cell.setColspan(3);
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(cell);
		}

		document.add(table);

		document.add(new Paragraph("\n"));

		table = new PdfPTable(8);

		table.setWidthPercentage(100);

		table.setWidths(new int[] { 5, 25, 47, 12, 18, 10,12,15});

		cell = new PdfPCell(new Phrase("SN", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setFixedHeight(40f);

		table.addCell(cell);

		cell = new PdfPCell(new Phrase("Code", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);

		cell = new PdfPCell(
				new Phrase("Item Name", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);
		
		
		cell = new PdfPCell(
				new Phrase("HSN", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);
		
		
		cell = new PdfPCell(
				new Phrase("Page No", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase("Qty", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);
		
		cell = new PdfPCell(new Phrase("Rate/PC", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);


		cell = new PdfPCell(new Phrase("Total", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);

		

		int srno = 1;
		for (HashMap<String, Object> prod : listOfItems) {

			cell = new PdfPCell(
					new Phrase(String.valueOf(srno++), new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL)));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			cell.setFixedHeight(40f);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase(prod.get("product_code").toString(),
					new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL)));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			table.addCell(cell);

			cell = new PdfPCell(new Phrase(prod.get("item_name").toString(),
					new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL)));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			table.addCell(cell);
			
			String hsnCode=prod.get("hsn_code")==null?"":prod.get("hsn_code").toString();

			cell = new PdfPCell(
					new Phrase(hsnCode, new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL)));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			table.addCell(cell);
			
			String catalogNo=prod.get("catalog_no")==null?"":prod.get("catalog_no").toString();
			
			cell = new PdfPCell(
					new Phrase(catalogNo, new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL)));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			table.addCell(cell);
			
			cell = new PdfPCell(new Phrase(prod.get("qty").toString(),
					new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL)));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			table.addCell(cell);
			
			
			cell = new PdfPCell(new Phrase(prod.get("custom_rate").toString(),
					new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL)));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			table.addCell(cell);
			
			String custom_rate = prod.get("custom_rate").toString();
			
			
			
			
			String qty=prod.get("qty").toString();
			
			double amount=Double.parseDouble(custom_rate)*Double.parseDouble(qty);
			

			

			

			cell = new PdfPCell(new Phrase(String.valueOf(amount), new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL)));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
			table.addCell(cell);

			

		}

		cell = new PdfPCell(new Phrase("", new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setColspan(2);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase("", new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.BOLD)));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);

		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase("", new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.BOLD)));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setFixedHeight(30f);
		table.addCell(cell);

		cell = new PdfPCell(new Phrase("Total Amount :- "+quoteDetails.get("total_amount").toString()+"/-", new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.BOLD)));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setColspan(4);
		table.addCell(cell);

		

		cell = new PdfPCell(new Phrase("", new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL)));
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		table.addCell(cell);

		document.add(table);

		
		if (!quoteDetails.get("remarks").equals("")) {
			document.add(new Paragraph("\n"));
			document.add(new Paragraph("\n"));
			table = new PdfPTable(1);
			table.setWidthPercentage(100);

			cell = new PdfPCell(new Phrase("Remarks :- " + quoteDetails.get("remarks"),
					new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD, BaseColor.RED)));
			cell.setBorder(Rectangle.NO_BORDER);
			cell.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(cell);
			document.add(table);
		}

		
		addTermsAndConditions(termsAndConditions, document); // addSign();

		table = new PdfPTable(1);
		table.setWidthPercentage(100);
		regSmallFont = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.NORMAL);

		// document.add(table);

		document.close();

		System.out.println("generated Image");

	}

	public static void addTermsAndConditions(List<String> terms, Document document) throws DocumentException {
		
		document.add(new Paragraph("\n"));
		PdfPTable table = new PdfPTable(1);
		table.setWidthPercentage(100);

		PdfPCell cell = new PdfPCell(
				new Phrase("TERMS AND CONDITIONS", new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
		cell.setBorder(Rectangle.NO_BORDER);

		cell.setHorizontalAlignment(Element.ALIGN_LEFT);
		table.addCell(cell);
		document.add(table);

		document.add(new Paragraph("\n"));
		table = new PdfPTable(1);
		table.setWidthPercentage(100);

		cell = new PdfPCell();

		com.itextpdf.text.List list = new com.itextpdf.text.List(com.itextpdf.text.List.ORDERED);

		for (String s : terms) {
			list.add(new ListItem(s));
		}

		document.add(list);
		document.add(table);

	}

	public void onStartPage(PdfWriter writer, Document document) {
		try {
			//addHeader(document);
			//addWaterMark(document, writer);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void onEndPage(PdfWriter writer, Document document) {
		try {/*
				 * 
				 * PdfPTable table = new PdfPTable(1); table.setWidthPercentage(100);
				 * table.setTotalWidth(500);
				 * 
				 * PdfPCell cell;
				 * 
				 * cell = new PdfPCell(new
				 * Phrase("THIS IS A SYSTEM GENERATED DOCUMENT AND DOES NOT REQUIRE SIGNATURE",
				 * new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL)));
				 * cell.setBorder(Rectangle.NO_BORDER);
				 * cell.setHorizontalAlignment(Element.ALIGN_CENTER); table.addCell(cell);
				 * 
				 * URL resource = QuotePDFHelper.class.getResource("footer.png"); Image img1 =
				 * Image.getInstance(resource);
				 * 
				 * img1.scalePercent(40); cell = new PdfPCell(img1);
				 * cell.setHorizontalAlignment(Image.ALIGN_RIGHT);
				 * cell.setBorder(Rectangle.NO_BORDER); table.addCell(cell);
				 * 
				 * table.writeSelectedRows(0, -1, 0, 60, writer.getDirectContent());
				 */

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void addWaterMark(Document documen, PdfWriter writer)
			throws MalformedURLException, IOException, DocumentException {
		PdfContentByte canvas = writer.getDirectContentUnder();

		URL resource = QuotePDFHelper.class.getResource("watermark.png");
		Image image = Image.getInstance(resource);

		image.setAbsolutePosition(115, 230);
		image.scaleAbsolute(400, 400);
		canvas.saveState();
		PdfGState state = new PdfGState();
		state.setFillOpacity(0.1f);
		canvas.setGState(state);
		canvas.addImage(image);
		canvas.restoreState();

	}

	public static void addHeader(Document document) throws MalformedURLException, IOException, DocumentException {

		PdfPTable table = new PdfPTable(2);
		table.setWidthPercentage(100);

		URL resource = QuotePDFHelper.class.getResource("topLeft.png");
		Image img1 = Image.getInstance(resource);

		resource = QuotePDFHelper.class.getResource("topRight.jpg");
		Image img2 = Image.getInstance(resource);
		PdfPCell cell;
		img1.scalePercent(40);
		cell = new PdfPCell(img1);
		img2.setAlignment(Image.ALIGN_LEFT);
		cell.setBorder(Rectangle.NO_BORDER);
		table.addCell(cell);
		img2.scalePercent(22);
		cell = new PdfPCell(img2);
		cell.setHorizontalAlignment(Image.ALIGN_RIGHT);
		cell.setBorder(Rectangle.NO_BORDER);
		table.addCell(cell);
		document.add(table);

		document.add(new Paragraph("\n"));
	}

}