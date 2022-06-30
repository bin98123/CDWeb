package com.trinhlequockhanh.cdweb.mail;

import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.trinhlequockhanh.cdweb.repository.UserRepository;

@Component
public class Mail {
	@Autowired
	private UserRepository userRepository;

	public void sendMail(String recepient, String id) throws MessagingException {
		System.out.println("Preparing to send mail.....");
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		String myAccountEmail = "quockhanhtl156@gmail.com";
		String password = "lbuoeixyqfzkgmgt";
		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {

				return new PasswordAuthentication(myAccountEmail, password);

			}
		});
		Message message = prepareMessge(session, myAccountEmail, recepient, id);
		Transport.send(message);
		System.out.println("Message have sent successfully!!!");

	}

	public Message prepareMessge(Session session, String myAccountEmail, String recepient, String id) {
		// TODO Auto-generated method stub
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(myAccountEmail));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(recepient));
			message.setSubject("REQUIRE CREATING A ACCOUNT HAS BEEN ACCEPTED");
			String href = "https://localhost:443/process-active?id=" + id + "&confirm=true";
			message.setContent(
					"<h2>ShoesLand account creation request has been accepted</h2>"
							+ "<h3> Plaese click on the button to active your account \n </h3> "
							+ " <a target='_blank' href=" + href + "><button>Active</button></a>",
					"text/html; charset=utf-8");
			return message;
		} catch (Exception e) {
			// TODO: handle exception
			Logger.getLogger(Mail.class.getName()).log(Level.SEVERE, null, e);
		}
		return null;
	}

	public void getPassword(String recepient) throws MessagingException {
		System.out.println("Preparing to send mail.....");
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		String myAccountEmail = "quockhanhtl156@gmail.com";
		String password = "lbuoeixyqfzkgmgt";
		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {

				return new PasswordAuthentication(myAccountEmail, password);

			}
		});
		Message message = getPasswordSub(session, myAccountEmail, recepient);
		Transport.send(message);
		System.out.println("Message have sent successfully!!!");

	}

	public Message getPasswordSub(Session session, String myAccountEmail, String recepient) {
		// TODO Auto-generated method stub
		try {
			String pass = userRepository.getPassword(recepient);
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(myAccountEmail));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(recepient));
			message.setSubject("REQUIRE CREATING A ACCOUNT HAS BEEN ACCEPTED");
			message.setText("Hello,\nRequest get password has been accepted, You password is:\n" + pass);
			return message;
		} catch (Exception e) {
			// TODO: handle exception
			Logger.getLogger(Mail.class.getName()).log(Level.SEVERE, null, e);
		}
		return null;
	}

	public Mail() {

	}

}