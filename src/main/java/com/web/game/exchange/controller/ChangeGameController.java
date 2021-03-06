package com.web.game.exchange.controller;


import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import com.web.game.exchange.model.ChangeHistoryBean;
import com.web.game.exchange.model.MyGameBean;
import com.web.game.exchange.model.SupportGameBean;
import com.web.game.exchange.service.ExchangeService;
import com.web.game.member.controller.JavaMail;
import com.web.game.member.model.MemberBean;
import com.web.game.member.service.MemberService;


@Controller
@SessionAttributes("user")
@RequestMapping("/exchange")
public class ChangeGameController {

	@Autowired
	ExchangeService exchangeService;
	@Autowired
	MemberService memberService;
	
//	@GetMapping("/applyFor")//applicationForm form:form無法接物件屬性 暫時沒用到
//	public String applyForChange(
//			@RequestParam String gamer,
//			@RequestParam Integer no,
//			Model model
//			) {
//		System.out.println("!!!!");
//		MemberBean partyB = (MemberBean) model.getAttribute("user");
//		List<MyGameBean> myGameBeansOption = (List<MyGameBean>) exchangeService.getMemberGamesName(partyB.getsAccount());
//		MemberBean partyA = memberService.Selectmember(gamer);
//		SupportGameBean supportGame = exchangeService.FindsupportGame(no);
//		System.out.println("!!!!");
//		
//		model.addAttribute("partyA",partyA);
//		model.addAttribute("supportGame",supportGame);
//		model.addAttribute("partyB",partyB);
//		model.addAttribute("myGameBeans",myGameBeansOption);
//		System.out.println("!!!!");
//		return "exchange/EXCApplicationForm";
//	}
	
	@PostMapping("/applyForAjax")
	public @ResponseBody boolean createTransaction(
			Model model,
			@RequestParam String partyA,
			@RequestParam Integer supportGameNo,
			@RequestParam String partyB,
			@RequestParam Integer myGameNo
			) {
		System.out.println("supportGameNo"+supportGameNo);
		System.out.println("myGameNo"+myGameNo);
		ChangeHistoryBean CHB = new ChangeHistoryBean();
		System.out.println("--");
		MemberBean mbPartyA = memberService.Selectmember(partyA);
		System.out.println("--");
		MemberBean mbPartyB = memberService.Selectmember(partyB);
		System.out.println("--");
		SupportGameBean sgSupportGame = exchangeService.FindsupportGame(supportGameNo);
		System.out.println("--!!");
		MyGameBean mgMyGame=exchangeService.getMyGame(myGameNo);
		System.out.println("--!!");
		SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
    	String sTimeString = sdf.format(new Date());
    	Timestamp time = Timestamp.valueOf(sTimeString);
		
    	System.out.println("getData!!");
		
		CHB.setPartyA(mbPartyA);
		System.out.println("1");
		CHB.setPartyB(mbPartyB);
		System.out.println("2");
		System.out.println("mgMyGame"+mgMyGame);
		CHB.setMygamebean(mgMyGame);
		System.out.println("3");
		CHB.setSupportgamebean(sgSupportGame);
		System.out.println("4");
		CHB.setStatus(0);
		CHB.setDate(time);
		
		if(exchangeService.insertChangeHistory(CHB)) {
			JavaMail mail = new JavaMail();
			mail.SendChangeMail(mbPartyA.getsEmail(), mgMyGame.getGamename(), mbPartyB.getsAccount(), sgSupportGame.getGamename());
			return true;
		}
		return false;
	}
	
	@GetMapping("/showApplyFor")
	public String getApplyFor(Model model,
			          		  @RequestParam Integer no
			) {
		ChangeHistoryBean chChangeHistory = new ChangeHistoryBean();
		chChangeHistory = exchangeService.getHistory(no);
		model.addAttribute("changeHistoryBean",chChangeHistory);
		
		return "exchange/EXCShowApplyFor";
	}
	
	@GetMapping("/ApplyForReject")
	public @ResponseBody boolean updateApplyForReject(
			Model model,
			@RequestParam Integer no
			) {
		boolean result = false;
		System.out.println("RejectIn");
		System.out.println(no);
		ChangeHistoryBean chChangeHistory = new ChangeHistoryBean();
		chChangeHistory = exchangeService.getHistory(no);
		if(exchangeService.updateChangeHistoryReject(chChangeHistory)) {	
			result = true;
		} 
		
		System.out.println("result"+result);
		System.out.println("RejectOut");
		return result;
	}
	
	@GetMapping("/ApplyForSubmit")
	public boolean updateApplyForSubmit(
			Model model,
			          		  @RequestParam Integer no
			) {
		boolean result = false;
		System.out.println("submitIn");
		System.out.println(no);
		ChangeHistoryBean chChangeHistory = new ChangeHistoryBean();
		chChangeHistory = exchangeService.getHistory(no);
		if(exchangeService.updateChangeHistorySubmit(chChangeHistory)) {	
			result = true;
		} 
		
		System.out.println(chChangeHistory);
		System.out.println("submitOut");
		return result;
	}
	
	
	@GetMapping("/memberHistoryList")
	public String getMemberHistoryList(Model model) {
		System.out.println("memberHistoryIn");
		List<ChangeHistoryBean> list = new ArrayList<ChangeHistoryBean>();
		MemberBean user = (MemberBean) model.getAttribute("user");
		Integer iUserid = user.getiNo();
		list = exchangeService.getHistoryList(iUserid);
		System.out.println("HistotyList"+list.size());
		model.addAttribute("HistotyList",list);
		
		System.out.println("memberHistoryIn");
		
		return "exchange/NewFile";
		
	}
	
	
}
