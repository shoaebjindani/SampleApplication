package com.crystal.commonfunctions;

import java.io.IOException;
import java.util.HashMap;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.MimeMultipart;

import org.apache.log4j.Logger;

import Frameworkpackage.CommonFunctions;

public class ReceiveMail {
	
	
	static Logger logger = Logger.getLogger(CommonFunctions.class.getName());

	public static void main(String[] args) {
		try {
			Properties props = new Properties();
			props.put("mail.store.protocol", "imaps");
			Session session = Session.getDefaultInstance(props, null);
			Store store = session.getStore("imaps");
			store.connect("imap.gmail.com", "info.elhaam@gmail.com", "ldalgtphnvbhetwf");
			//store.connect("imap.gmail.com", "studentattendancesys@gmail.com", "vttnejmcrfzycurl");
			

			
			Folder inbox=null;
			for(int f=0;f<1000;f++)
			{				
				logger.info("store.getFolder");
				inbox = store.getFolder("PaytmPaymentMails");
				logger.info("Folder.READ_WRITE");
				inbox.open(Folder.READ_WRITE);
				logger.info("newFlag term");
				logger.info("inbox search");
				Message messages[] = inbox.getMessages();
				System.out.println("Scanning Inbox for unread Emails..");
				System.out.println("Unread Emails found "+messages.length);
				System.out.println("-----------------------");
				for (int m = 0; m < messages.length; m++) {
					//logger.info("getting subject");
					System.out.println(messages[m].getSubject());
					//logger.info("gettingText Message");

					//logger.info("getDetailsOfPayment");
					//scrapedDetails = getDetailsOfPayment(messages[m]);
					//logger.info("showing Scraped Details");
					//System.out.println(scrapedDetails);
			           //messages[m].setFlag(Flag.SEEN, true);

					
					
					
				}
			}

			inbox.close(true);
			store.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		

	}

	private static String getTextFromMessage(Message message) throws MessagingException, IOException {
		String result = "";
		if (message.isMimeType("text/plain")) {
			result = message.getContent().toString();
		} else if (message.isMimeType("multipart/*")) {
			MimeMultipart mimeMultipart = (MimeMultipart) message.getContent();
			result = getTextFromMimeMultipart(mimeMultipart);
		}
		return result;
	}

	private static String getTextFromMimeMultipart(MimeMultipart mimeMultipart) throws MessagingException, IOException {
		String result = "";
		int count = mimeMultipart.getCount();
		for (int i = 0; i < count; i++) {
			BodyPart bodyPart = mimeMultipart.getBodyPart(i);
			if (bodyPart.isMimeType("text/plain")) {
				result = result + "\n" + bodyPart.getContent();
				break; // without break same text appears twice in my tests
			} else if (bodyPart.isMimeType("text/html")) {
				String html = (String) bodyPart.getContent();
				result = result + "\n" + org.jsoup.Jsoup.parse(html).text();
			} else if (bodyPart.getContent() instanceof MimeMultipart) {
				result = result + getTextFromMimeMultipart((MimeMultipart) bodyPart.getContent());
			}
		}
		return result;
	}
	
	
	private static HashMap<String, String> getDetailsOfPayment(Message message) throws MessagingException, IOException {
		
		String emailContent=getTextFromMessage(message);
		HashMap<String, String> returnMap=new HashMap<>();
		
		
		returnMap.put("bhim_upi_id", getStringBetweenTwoStrings(emailContent, "BHIM UPI ", "In Account of"));
		
		String amount=getStringBetweenTwoStrings(emailContent, "Payment Received ", " Rupee");
		amount=amount.substring(2,amount.length());
		returnMap.put("amount", amount);
		
		
		returnMap.put("order_id", getStringBetweenTwoStrings(emailContent, "Order ID:", "For any assistance"));
		
		if(emailContent.contains("Mobile No. "))
		{
			returnMap.put("mobile_no", getStringAfterStringWithLimit(emailContent,"Mobile No. ", 10));
		}
		returnMap.put("date_time",getStringBetweenTwoStrings(emailContent,"Elhaam Corporation", "Order ID:"));
		 
		 
		
		return returnMap;

	}
	
	
	private static String getStringBetweenTwoStrings(String theString, String fromString,String toString)
	{	
		int startIndex=theString.indexOf(fromString) +fromString.length();
		int endIndex=theString.indexOf(toString);
		return theString.substring(startIndex,endIndex);		
	}
	
	
	private static String getStringAfterStringWithLimit(String theString, String fromString,int Limit)
	{	
		int startIndex=theString.indexOf(fromString) +fromString.length();
		
		return theString.substring(startIndex,startIndex+Limit);		
	}


}