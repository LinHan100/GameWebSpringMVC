package com.web.game.member.controller;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.transaction.annotation.Transactional;

public class JavaMail {
	private String userName = "GameBar20210128@gmail.com";
	private String password = "gamebar20210128";
	private String customer = "" ;
	private String subject = "親愛的GameBar會員您好，這是封更改密碼通知的信件";
//	private String PasswordSet = "http://localhost:8080/GameWebSpringMVC/src/main/webapp/WEB-INF/views/member/MemberPasswordSet";
//	private Integer No = null ;  
//	private String txt = "請點選下面網址更改密碼<br><a href=\"" + "http://localhost:8080/GameWebSpringMVC/member/forget/PasswordSet?"+No + "\">點擊我</a>";
	private String txt = "";

	 @SuppressWarnings("static-access")
	 public void SendMail(String sEmail, Integer iNo) {
		System.out.println("傳進來的iNo="+iNo);
		txt="請點選下面網址更改密碼<br><a href=\"" + "http://localhost:8080/GameWebSpringMVC/member/forget/PasswordSet?iNo="+iNo+"\">點擊我</a>";
		customer = sEmail ;
		Properties prop = new Properties();
		prop.setProperty("mail.transport.protocol", "smtp");

		// Host:smtp.gmail.com
		prop.setProperty("mail.host", "smtp.gmail.com");

		// host port 465
		prop.put("mail.smtp.port", "465");

//		寄件者帳號需要驗證需要安全資料傳輸層 (SSL)：是
		prop.put("mail.smtp.auth", "true");

//		需要傳輸層安全性 (TLS)：是 (如果可用)
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

//		安全資料傳輸層 (SSL) 通訊埠：465
		prop.put("mail.smtp.socketFactory.port", "465");

		prop.put("mail.debug", "true");

		// 透過類別
//		Session session = Session.getDefaultInstance(prop, new Authenticator() {
//
//			@Override
//			protected PasswordAuthentication getPasswordAuthentication() {
//				return new PasswordAuthentication(userName, password);
//			}
//			
//			
//		});

		// 一般Class
		Auth auth = new Auth(userName, password);
		Session session = Session.getDefaultInstance(prop, auth);

		MimeMessage message = new MimeMessage(session);

		try {
			// 寄件者
//				message.setSender(new InternetAddress(userName));

			InternetAddress sender = new InternetAddress(userName);
			message.setSender(sender);

			// 收件者
			message.setRecipient(RecipientType.TO, new InternetAddress(customer));
			// 標題
			message.setSubject(subject);
			// 內容
			message.setContent(txt, "text/html;charset=utf-8");

			Transport transport = session.getTransport();
			System.out.println("txt="+txt);
			transport.send(message);
			System.out.println("成功寄出");
			transport.close();

		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}

	class Auth extends Authenticator {

		private String userName;
		private String password;

		public Auth(String userName, String password) {
			this.userName = userName;
			this.password = password;

		}

		@Override
		protected PasswordAuthentication getPasswordAuthentication() {
			PasswordAuthentication pa = new PasswordAuthentication(userName, password);
			return pa;
		}

	}
	
	@SuppressWarnings("static-access")
	public void SendChangeMail(String sEmail, String parryBgame,String partyB,String parryAgame) {
		
		subject = "親愛的GameBar會員您好，這是封交換申請通知的信件";
			txt="親愛的GameBar會員:<br>"+
					"您有一筆新的交換申請<br>"+
					"詳情如下:<br>會員: "+
					partyB +" 欲用 <h1>"+parryBgame+"</h1>與您交換<h1>"+parryAgame+"</h1>"+
					"<br>趕快至<a href='http://localhost:8080/GameWebSpringMVC/'>GameBar</a>確認吧";

		
		
		customer = sEmail ;
		Properties prop = new Properties();
		prop.setProperty("mail.transport.protocol", "smtp");
		prop.setProperty("mail.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", "465");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		prop.put("mail.smtp.socketFactory.port", "465");
		prop.put("mail.debug", "true");
		
		// 一般Class
		Auth auth = new Auth(userName, password);
		Session session = Session.getDefaultInstance(prop, auth);
		
		MimeMessage message = new MimeMessage(session);
		
		try {
			// 寄件者
//				message.setSender(new InternetAddress(userName));
			
			InternetAddress sender = new InternetAddress(userName);
			message.setSender(sender);
			
			// 收件者
			message.setRecipient(RecipientType.TO, new InternetAddress(customer));
			// 標題
			message.setSubject(subject);
			// 內容
			message.setContent(txt, "text/html;charset=utf-8");
			
			Transport transport = session.getTransport();
			System.out.println("txt="+txt);
			transport.send(message);
			System.out.println("成功寄出");
			transport.close();
			
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
	}
	
	 @SuppressWarnings("static-access")
	 public void SendContestMail(String sEmail, Integer iContestNo,String sCorP) {
		 
		 if(sCorP.equals("contest")) {
			 this.subject = "親愛的GameBar會員您好，您已新增一場比賽";
			 txt="親愛的GameBar會員:<br>"+
					 "您的比賽已建立！<a href='http://localhost:8080/GameWebSpringMVC/contest/Information?contestNo="+ iContestNo + "'>點擊我進入比賽詳細資料</a><br>"+
					 "*請留意報名時間、比賽時間、比賽地點,本網站不負比賽無法如期舉辦等官方責任與賠償";
		 }else if(sCorP.equals("participate")) {
			 this.subject = "親愛的GameBar會員您好，您已參加一場比賽";
			 txt="親愛的GameBar會員:<br>"+
					 "恭喜您報名成功！祝您武運昌隆！<a href='http://localhost:8080/GameWebSpringMVC/contest/Information?contestNo="+ iContestNo + "'>點擊我進入比賽詳細資料</a><br>"+
					 "*請留意報名時間、比賽時間,於比賽往頁確認賽程與戰績";
		 }
		
		
		
		
		customer = sEmail ;
		Properties prop = new Properties();
		prop.setProperty("mail.transport.protocol", "smtp");
		prop.setProperty("mail.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", "465");
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		prop.put("mail.smtp.socketFactory.port", "465");
		prop.put("mail.debug", "true");

		// 一般Class
		Auth auth = new Auth(userName, password);
		Session session = Session.getDefaultInstance(prop, auth);

		MimeMessage message = new MimeMessage(session);

		try {
			// 寄件者
//				message.setSender(new InternetAddress(userName));

			InternetAddress sender = new InternetAddress(userName);
			message.setSender(sender);

			// 收件者
			message.setRecipient(RecipientType.TO, new InternetAddress(customer));
			// 標題
			message.setSubject(subject);
			// 內容
			message.setContent(txt, "text/html;charset=utf-8");

			Transport transport = session.getTransport();
			System.out.println("txt="+txt);
			transport.send(message);
			System.out.println("成功寄出");
			transport.close();

		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}

	
}
