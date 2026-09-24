package com.crystal.commonfunctions;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Flags;
import javax.mail.Flags.Flag;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.MimeMultipart;
import javax.mail.search.FlagTerm;

import com.crystal.customizedpos.Configuration.ConfigurationDaoImpl;
import Frameworkpackage.CommonFunctions;

public class ReadEmailAndSaveToDB {
	
	
	
	public static void main(String[] args) throws MessagingException, ClassNotFoundException, SQLException, IOException 
	{
		CommonFunctions cf=new CommonFunctions();	
		ConfigurationDaoImpl lobjconfig=new ConfigurationDaoImpl();
		cf.initializeApplication();
		
		cf.setApplicationConfig();
		
			  
			    Properties props = new Properties();
			    props.put("mail.store.protocol","imaps");
			    Session session = Session.getDefaultInstance(props, null);
			    Store store = session.getStore("imaps");
			    store.connect("imap.gmail.com", "info.elhaam@gmail.com", "ldalgtphnvbhetwf");
			    Connection Con=cf.getConnectionJDBC();
		    
		    while(true)
		    {
		    	try
				{
		    	System.out.println("Reading PhonePayPayments payments directory");
			    Folder inbox = store.getFolder("PhonePayPayments");	    
			    inbox.open(Folder.READ_WRITE);	    
			    FlagTerm ft = new FlagTerm(new Flags(Flags.Flag.SEEN), false);
		        Message messages[] = inbox.search(ft);
		        System.out.println("Number of messages found"+messages.length);
		        
		        for (int m = 0; m < messages.length; m++) 
			    {	           
		        	
		        	String emailText=getTextFromMessage(messages[m]).toString().replaceAll("\\s", "");
		        	HashMap<String, String> hm=getDetailsOfPayment(emailText);
		        	System.out.println(hm);
		        	hm.putAll(lobjconfig.getuserIdFromStoreName(hm,Con));
		        	lobjconfig.savePaymentToDB(hm,Con);
		           messages[m].setFlag(Flag.SEEN, true);
		        }
		        Thread.sleep(5000);
		        
				}
		        
		    	catch (javax.mail.MessagingException e) {
					
		    		e.printStackTrace();
		    		if(!store.isConnected())
		    		{
		    		    store.connect("imap.gmail.com", "info.elhaam@gmail.com", "ldalgtphnvbhetwf");
		    		}
		    		
				}
		        
		        catch(Exception e)
				{
					e.printStackTrace();
					//Con.close();
					
				}
		    	
                

		    }
		}
		
		
		


	

	private static HashMap<String, String> getDetailsOfPayment(String emailTextTrimmed) throws MessagingException, IOException, ParseException 
	{
		
		
		System.out.println("Email String received is "+emailTextTrimmed);
		
		String PaymentDate=emailTextTrimmed;		
		PaymentDate = PaymentDate.substring(0, PaymentDate.indexOf("Received"));
		
		if(PaymentDate.length()==10 ||PaymentDate.length()==18 || PaymentDate.length()==11 ||PaymentDate.length()==17)
		{
		    PaymentDate=PaymentDate.substring(1);
		}
		
		
		String Amount=emailTextTrimmed;
		Amount = Amount.substring(Amount.indexOf("Received") + "Received".length());
		Amount = Amount.substring(1, Amount.indexOf("Txn"));
		
		
		String orderId=emailTextTrimmed;
		orderId = orderId.substring(orderId.indexOf("Txn.ID:") + "Txn.ID:".length());
		orderId = orderId.substring(1, orderId.indexOf("StoreName"));
		
		
		String StoreName=emailTextTrimmed;
		StoreName = StoreName.substring(StoreName.indexOf("StoreName") + "StoreName".length());
		StoreName = StoreName.substring(1, StoreName.indexOf("Paidby"));
		
		
		
		String bhimupiid=emailTextTrimmed;
		bhimupiid = bhimupiid.substring(bhimupiid.indexOf("Paidby") + "Paidby".length());
		bhimupiid = bhimupiid.substring(1, bhimupiid.indexOf("Txn.status"));
		
		
		HashMap<String, String> hm=new HashMap<>();
		hm.put("amount",Amount);
		hm.put("orderId",orderId);
		hm.put("StoreName",StoreName);
		hm.put("bhimupiid",bhimupiid);
		
		
		DateFormat format =null;
		if(PaymentDate.length()==10)
		{
			format=new SimpleDateFormat("MMMdd,yyyy", Locale.ENGLISH);
		}
		else
            if(PaymentDate.length()==9)
            {
                format=new SimpleDateFormat("MMMd,yyyy", Locale.ENGLISH);
            }
		
		else
		    if(PaymentDate.length()==17)
	        {
		        format=new SimpleDateFormat("hh:mmaMMMdd,yyyy", Locale.ENGLISH);
	        }
		    else
		{
			format=new SimpleDateFormat("hh:mmaMMMd,yyyy", Locale.ENGLISH);
		}
		
		 
		
		Date date = format.parse(PaymentDate);
		
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		System.out.println(formatter.format(date));
		
		
		
		
		hm.put("PaymentDate",formatter.format(date));
		
		
		return hm;
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

}
