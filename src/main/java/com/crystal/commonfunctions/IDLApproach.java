package com.crystal.commonfunctions;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Locale;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Flags.Flag;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.event.MessageCountAdapter;
import javax.mail.event.MessageCountEvent;
import javax.mail.internet.MimeMultipart;

import com.crystal.customizedpos.Configuration.ConfigurationDaoImpl;
import Frameworkpackage.CommonFunctions;
import com.sun.mail.imap.IMAPFolder;
import com.sun.mail.imap.IMAPStore;

public class IDLApproach {
	
/*	private static final String username = "studentattendancesys@gmail.com";
    private static final String password = "vttnejmcrfzycurl";*/
    
    private static final String username = "info.elhaam@gmail.com";
    private static final String password = "ldalgtphnvbhetwf";
    
 
    static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(IDLApproach.class.getName());
    
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Properties properties = new Properties();
        // properties.put("mail.debug", "true");
        properties.put("mail.store.protocol", "imaps");
        properties.put("mail.imaps.host", "imap.gmail.com");
        properties.put("mail.imaps.port", "993");
        properties.put("mail.imaps.timeout", "10000");

        Session session = Session.getInstance(properties); // not
                                                           // getDefaultInstance
        IMAPStore store = null;
        Folder inbox = null;
        
        try {
            store = (IMAPStore) session.getStore("imaps");
            store.connect(username, password);
            
            ConfigurationDaoImpl lobjConfigurationDaoImpl=new ConfigurationDaoImpl();
            CommonFunctions cf=new CommonFunctions();
            if (!store.hasCapability("IDLE")) {
                throw new RuntimeException("IDLE not supported");
            }

            inbox = (IMAPFolder) store.getFolder("PaytmPaymentMails");
            inbox.addMessageCountListener(new MessageCountAdapter() {

                @Override
                public void messagesAdded(MessageCountEvent event) {
                    Message[] messages = event.getMessages();

                    for (Message message : messages) {
                        try {
                        	
                        	logger.info("Mail Received:- ");
                        	//logger.info("Mail Subject:- " + message.getSubject() + new Date());
                            
                        	//logger.info("Mail content "+ getTextFromMessage(message));
                        	logger.info("Scraped content "+ getDetailsOfPayment(message));
                        	Connection con=cf.getConnectionJDBC();
                        	con.setAutoCommit(false);
                        	HashMap<String, String> scrapedDetails=getDetailsOfPayment(message);
                        	lobjConfigurationDaoImpl.addIncomingPaymentPetrol(con, scrapedDetails);
                        	con.commit();con.close();
             	           message.setFlag(Flag.SEEN, true);
                        } catch (Exception e) {
                        	try {
								message.setFlag(Flag.SEEN, false);
							} catch (MessagingException e1) {
								// TODO Auto-generated catch block
								e1.printStackTrace();
							}
                        	logger.error(e);
                            e.printStackTrace();
                        }
                    }
                }
            });
            
            IdleThread idleThread = new IdleThread(inbox);
            idleThread.setDaemon(false);
            idleThread.start();

            idleThread.join();
            // idleThread.kill(); //to terminate from another thread

        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            close(inbox);
            close(store);
        }
    }
	
	private static class IdleThread extends Thread {
        private final Folder folder;
        private volatile boolean running = true;

        public IdleThread(Folder folder) {
            super();
            this.folder = folder;
        }

        public synchronized void kill() {

            if (!running)
                return;
            this.running = false;
        }

        @Override
        public void run() {
            while (running) {

                try {
                    ensureOpen(folder);
                    logger.info("enter idle");
                    ((IMAPFolder) folder).idle();
                } catch (Exception e) {
                    // something went wrong
                    // wait and try again
                    e.printStackTrace();
                    try {
                        Thread.sleep(100);
                    } catch (InterruptedException e1) {
                        // ignore
                    }
                }

            }
        }
    }
	
	public static void close(final Folder folder) {
        try {
            if (folder != null && folder.isOpen()) {
                folder.close(false);
            }
        } catch (final Exception e) {
            // ignore
        }

    }

    public static void close(final Store store) {
        try {
            if (store != null && store.isConnected()) {
                store.close();
            }
        } catch (final Exception e) {
            // ignore
        }

    }

    public static void ensureOpen(final Folder folder) throws MessagingException {

        if (folder != null) {
            Store store = folder.getStore();
            if (store != null && !store.isConnected()) {
                store.connect(username, password);
            }
        } else {
            throw new MessagingException("Unable to open a null folder");
        }

        if (folder.exists() && !folder.isOpen() && (folder.getType() & Folder.HOLDS_MESSAGES) != 0) {
        	logger.info("open folder " + folder.getFullName());
            folder.open(Folder.READ_WRITE);
            if (!folder.isOpen())
                throw new MessagingException("Unable to open folder " + folder.getFullName());
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
		
		if(emailContent.contains("BHIM UPI "))
		{
			returnMap.put("bhim_upi_id", getStringBetweenTwoStrings(emailContent, "BHIM UPI ", "In Account of").trim());
		}
		
		String amount=getStringBetweenTwoStrings(emailContent, "Payment Received ", " Rupee");
		amount=amount.substring(2,amount.length());
		returnMap.put("amount", amount);
		
		
		returnMap.put("order_id", getStringBetweenTwoStrings(emailContent, "Order ID:", "For any assistance").trim());
		
		if(emailContent.contains("Mobile No. "))
		{
			returnMap.put("mobile_no", getStringAfterStringWithLimit(emailContent,"Mobile No. ", 10));
		}
		else
		{
			returnMap.put("mobile_no", ""); // setting mobile number as blank
		}
		
		
		
		returnMap.put("app_id", "208"); // hardcoded it for nayara pump need to change this

		
		
		
		String string = getStringBetweenTwoStrings(emailContent,"Elhaam Corporation", "Order ID:").trim();
		//String string="Aug 7, 2022 12:50 AM";
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM d, yyyy h:m a", Locale.ENGLISH);
		LocalDateTime date = LocalDateTime.parse(string, formatter);
		
		
		
		String dateAsMysqlFormat = date.format(DateTimeFormatter. ofPattern("yyyy-MM-dd HH:mm"));
		returnMap.put("date_time_from_payment",dateAsMysqlFormat);
		 
		 
		
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
// try in this one 