
package pdfGeneration;

import Frameworkpackage.CommonFunctions;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.stream.Stream;
 
public class MOMPDFHelper  extends PdfPageEventHelper
{
	
	public static void generatePDFForMOM(String destinationPath, 
                                     LinkedHashMap<String, Object> momHeaderDetails, 
                                     List<LinkedHashMap<String, Object>> agendaList) throws Exception {
                                        CommonFunctions cf=new CommonFunctions();

    Document document = new Document(PageSize.A4, 36, 36, 36, 36);
    PdfWriter.getInstance(document, new FileOutputStream(destinationPath));
    document.open();

    Font titleFont = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
    Font headerFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
    Font normalFont = new Font(Font.FontFamily.HELVETICA, 11, Font.NORMAL);

    // Title
    Paragraph title = new Paragraph("Minutes of Meeting", titleFont);
    title.setAlignment(Element.ALIGN_CENTER);
    title.setSpacingAfter(15f);
    document.add(title);

  // Compact Header Table - 4 columns (Label, Value, Label, Value)
PdfPTable headerTable = new PdfPTable(4);
headerTable.setWidths(new float[]{1.2f, 2.5f, 1.2f, 2.5f});
headerTable.setWidthPercentage(100);
headerTable.setSpacingAfter(6f); // reduced space

addHeaderCell(headerTable, "MOM No", momHeaderDetails.get("mom_no"), headerFont, normalFont);
addHeaderCell(headerTable, "MOM Date", momHeaderDetails.get("mom_date"), headerFont, normalFont);
addHeaderCell(headerTable, "Prepared By", momHeaderDetails.get("prepared_by"), headerFont, normalFont);
addHeaderCell(headerTable, "", "", headerFont, normalFont); // Optional: leave blank or add another field

document.add(headerTable);

    if (momHeaderDetails.containsKey("attendees") && momHeaderDetails.get("attendees") instanceof List) {
    List<LinkedHashMap<String, Object>> attendeeList = (List<LinkedHashMap<String, Object>>) momHeaderDetails.get("attendees");
    if (!attendeeList.isEmpty()) {
        Paragraph attendeesTitle = new Paragraph("Attendees", headerFont);
        attendeesTitle.setSpacingBefore(10f);
        attendeesTitle.setSpacingAfter(5f);
        document.add(attendeesTitle);

        PdfPTable attendeesTable = new PdfPTable(new float[]{3, 2, 3, 2}); // 4 columns
        attendeesTable.setWidthPercentage(100);
        attendeesTable.setSpacingAfter(10f);

        // Header Row
        Stream.of("Name & Designation", "Signature", "Name & Designation", "Signature").forEach(header -> {
            PdfPCell cell = new PdfPCell(new Phrase(header, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10)));
            cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setPadding(4f);
            attendeesTable.addCell(cell);
        });

        for (int i = 0; i < attendeeList.size(); i += 2) {
            // First attendee
            LinkedHashMap<String, Object> att1 = attendeeList.get(i);
            PdfPCell att1Details = new PdfPCell(new Phrase(
                getString(att1.get("name")) + "\n" + getString(att1.get("designation")), normalFont));
            att1Details.setPadding(4f);
            attendeesTable.addCell(att1Details);
            attendeesTable.addCell(new PdfPCell(new Phrase(""))); // Signature cell

            // Second attendee (if exists)
            if (i + 1 < attendeeList.size()) {
                LinkedHashMap<String, Object> att2 = attendeeList.get(i + 1);
                PdfPCell att2Details = new PdfPCell(new Phrase(
                    getString(att2.get("name")) + "\n" + getString(att2.get("designation")), normalFont));
                att2Details.setPadding(4f);
                attendeesTable.addCell(att2Details);
                attendeesTable.addCell(new PdfPCell(new Phrase(""))); // Signature cell
            } else {
                // Fill empty cells to complete the row
                attendeesTable.addCell(new PdfPCell(new Phrase("")));
                attendeesTable.addCell(new PdfPCell(new Phrase("")));
            }
        }

        document.add(attendeesTable);
    }
}


    
document.add(Chunk.NEWLINE);
document.add(Chunk.NEWLINE);
    // Agendas
    for (HashMap<String, Object> agenda : agendaList) {
        PdfPTable agendaBlock = new PdfPTable(1);
        agendaBlock.setWidthPercentage(100);
        agendaBlock.getDefaultCell().setBorder(Rectangle.BOX);
        agendaBlock.getDefaultCell().setPadding(8f);
        agendaBlock.getDefaultCell().setBorderColor(BaseColor.DARK_GRAY);
        agendaBlock.getDefaultCell().setBackgroundColor(new BaseColor(240, 240, 240));

        Paragraph agendaTitle = new Paragraph("Agenda: " + agenda.get("agenda_name"), FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12));
        PdfPCell agendaTitleCell = new PdfPCell(agendaTitle);
        agendaTitleCell.setBorder(Rectangle.BOX);
        agendaTitleCell.setPaddingBottom(6f);
        agendaBlock.addCell(agendaTitleCell);

        // TASKS
        List<HashMap<String, Object>> tasks = (List<HashMap<String, Object>>) agenda.get("tasks");
        if (tasks != null && !tasks.isEmpty()) {
            PdfPTable taskTable = new PdfPTable(new float[]{2, 2, 2, 2, 1.5f, 2});
            taskTable.setWidthPercentage(100);
            Stream.of("Task Name", "Task Type", "Task Date", "Target Date", "Priority", "Assigned To").forEach(header -> {
                PdfPCell cell = new PdfPCell(new Phrase(header, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10)));
                cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
                taskTable.addCell(cell);
            });
            for (HashMap<String, Object> task : tasks) {
                taskTable.addCell(String.valueOf(task.get("task_name")));
                taskTable.addCell(String.valueOf(task.get("task_type")));
                taskTable.addCell(String.valueOf(cf.getDateASDDMMYYYYFromYYYYMMDD(task.get("task_date").toString())));
                taskTable.addCell(String.valueOf(cf.getDateASDDMMYYYYFromYYYYMMDD(task.get("target_date").toString())));
                taskTable.addCell(String.valueOf(task.get("priority")));
                taskTable.addCell(String.valueOf(task.get("assigned_to")));
            }
            PdfPCell taskLabel = new PdfPCell(new Phrase("Tasks", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10)));
            taskLabel.setBorder(Rectangle.NO_BORDER);
            taskLabel.setPaddingTop(6f);
            agendaBlock.addCell(taskLabel);
            agendaBlock.addCell(new PdfPCell(taskTable) {{ setBorder(Rectangle.NO_BORDER); setPaddingTop(4f); }});
        }

        // ANNOUNCEMENTS
        List<HashMap<String, Object>> announcements = (List<HashMap<String, Object>>) agenda.get("announcements");
        if (announcements != null && !announcements.isEmpty()) {
            PdfPTable annTable = new PdfPTable(1);
            annTable.setWidthPercentage(100);
            annTable.addCell(new PdfPCell(new Phrase("Announcement", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10))) {{
                setBackgroundColor(BaseColor.LIGHT_GRAY);
            }});
            for (HashMap<String, Object> ann : announcements) {
                annTable.addCell(String.valueOf(ann.get("announcement")));
            }
            agendaBlock.addCell(new PdfPCell(annTable) {{ setBorder(Rectangle.NO_BORDER); setPaddingTop(4f); }});
        }

        // DISCUSSIONS
        List<HashMap<String, Object>> discussions = (List<HashMap<String, Object>>) agenda.get("discussions");
        if (discussions != null && !discussions.isEmpty()) {
            PdfPTable discTable = new PdfPTable(1);
            discTable.setWidthPercentage(100);
            discTable.addCell(new PdfPCell(new Phrase("Discussion", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10))) {{
                setBackgroundColor(BaseColor.LIGHT_GRAY);
            }});
            for (HashMap<String, Object> d : discussions) {
                discTable.addCell(String.valueOf(d.get("discussion_text")));
            }
            agendaBlock.addCell(new PdfPCell(discTable) {{ setBorder(Rectangle.NO_BORDER); setPaddingTop(4f); }});
        }

        document.add(agendaBlock);
        document.add(Chunk.NEWLINE);
    }

    // Conclusion
    if (momHeaderDetails.get("mom_conclusion") != null) {
        Paragraph conclusionTitle = new Paragraph("Conclusion", headerFont);
        conclusionTitle.setSpacingBefore(10f);
        conclusionTitle.setSpacingAfter(5f);
        document.add(conclusionTitle);

        Paragraph conclusionText = new Paragraph(getString(momHeaderDetails.get("mom_conclusion")), normalFont);
        document.add(conclusionText);
    }

    document.close();
}

private static void addHeaderRow(PdfPTable table, String label, Object value, Font labelFont, Font valueFont) {
    PdfPCell labelCell = new PdfPCell(new Phrase(label, labelFont));
    labelCell.setBorder(Rectangle.NO_BORDER);
    table.addCell(labelCell);

    PdfPCell valueCell = new PdfPCell(new Phrase(getString(value), valueFont));
    valueCell.setBorder(Rectangle.NO_BORDER);
    table.addCell(valueCell);
}

private static void addTableHeader(PdfPTable table, String[] headers, Font headerFont) {
    for (String header : headers) {
        PdfPCell headerCell = new PdfPCell(new Phrase(header, headerFont));
        headerCell.setBackgroundColor(BaseColor.DARK_GRAY);
        headerCell.setHorizontalAlignment(Element.ALIGN_CENTER);
        headerCell.setPadding(5);
        table.addCell(headerCell);
    }
}

private static String getString(Object obj) {
    return obj == null ? "" : obj.toString();
}


	 public void onStartPage(PdfWriter writer, Document document)
	 {
		 try
		 {
			 //addHeader(document);
			 /*addWaterMark(document,writer);*/
		 }
		 catch(Exception e)
		 {
			 e.printStackTrace();
		 }
    }
	 
	 public void onEndPage(PdfWriter writer, Document document)
	 {
		 try
		 {}
		 catch(Exception e)
		 {
			 e.printStackTrace();
		 }
    }

    // Helper method for compact header rows
private static void addHeaderCell(PdfPTable table, String label, Object value, Font labelFont, Font valueFont) {
    PdfPCell labelCell = new PdfPCell(new Phrase(label, labelFont));
    labelCell.setBackgroundColor(BaseColor.LIGHT_GRAY);
    labelCell.setPadding(4f);
    table.addCell(labelCell);

    PdfPCell valueCell = new PdfPCell(new Phrase(getString(value), valueFont));
    valueCell.setPadding(4f);
    table.addCell(valueCell);
}
	 
	
	
	
	
		
	
}