package com.web.game.member.service.Impl;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.game.member.dao.MemberDao;
import com.web.game.member.model.MemberBean;
import com.web.game.member.service.MemberService;


@Transactional
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao dao;
	
	@Override
	public Boolean InsertMember(MemberBean InsertMB) {
		dao.InsertMember(InsertMB);
		return true;
	}

	@Override
	public Boolean DeleteMember(Integer iNo) {
			dao.DeleteMember(iNo);
		return true;
	}

	@Override
	public Boolean UpdateMember(MemberBean UpdateMB) {	
		dao.UpdateMember(UpdateMB);	
		return true;
	}

	@Override
	public Boolean SigninMember(String sAccount, String sPassword) {
		boolean Signin = false ;
		if(dao.SigninMember(sAccount, sPassword)) {
			return true;
		}else {
			return Signin ;
		}
	}

	@Override
	public MemberBean Selectmember(String sAccount) {
		return dao.Selectmember(sAccount);
	}

	@Override
	public List<MemberBean> getAllMembers() {
		List<MemberBean> list = new ArrayList<>();
		list = dao.getAllMembers();
		return list;
	}

	@Override
	public String Checkmember(String sAccount) {
		return dao.Checkmember(sAccount);
	}

}
