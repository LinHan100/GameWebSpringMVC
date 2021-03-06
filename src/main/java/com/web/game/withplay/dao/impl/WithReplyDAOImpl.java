package com.web.game.withplay.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.game.forum.model.ReplyBean;
import com.web.game.withplay.dao.WithReplyDAO;
import com.web.game.withplay.model.WithPlay;
import com.web.game.withplay.model.WithReplyBean;

@Repository
public class WithReplyDAOImpl implements WithReplyDAO{
	
	@Autowired
	SessionFactory factory;
	

	@Override
	public Boolean insertReply(WithReplyBean rReplyBean) {
		Session session = factory.getCurrentSession();
		try {
			session.save(rReplyBean);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}


	@Override
	public Boolean delete(Integer iId) {
		Session session = factory.getCurrentSession();
		WithReplyBean Wp = new WithReplyBean();
		Wp.setiNo(iId);
		try{
			session.delete(Wp);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}


	@Override
	public WithReplyBean selectOneReply(Integer iNo) {
		Session session = factory.getCurrentSession();
		return session.get(WithReplyBean.class, iNo);
	}


	@Override
	public Boolean deleteReply(WithReplyBean rReplyBean) {
		Session session = factory.getCurrentSession();
		try {
			session.delete(rReplyBean);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}


	@Override
	public Boolean updateReply(WithReplyBean rReplyBean) {
		Session session = factory.getCurrentSession();
		try {
			session.update(rReplyBean);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

}
