package com.web.game.contest.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.game.contest.dao.ContestDAO;
import com.web.game.contest.model.ContestBean;

@Repository
public class ContestDAOImpl implements ContestDAO {
	
	@Autowired
	SessionFactory factory;

	@Override
	public Boolean insertOrUpdateContest(ContestBean cContestBean) {
		Session session = factory.getCurrentSession();
		try {
			session.saveOrUpdate(cContestBean);			
			return true;
		}catch (Exception e) {
			return false;
		}
	}

	@Override
	public Boolean deleteContest(ContestBean cContestBean) {
		Session session = factory.getCurrentSession();
		try {
			session.delete(cContestBean);			
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public Boolean updateContest(ContestBean cContestBean) {
		return null;
	}

	@Override
	public ContestBean selectOneContest(Integer iNo) {
		String hql = "from ContestBean where iNo = :iNo";
		Session session = factory.getCurrentSession();
		return (ContestBean)session.createQuery(hql).setParameter("iNo", iNo).getSingleResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ContestBean> selectUserContest(String user) {
		String hql = "from ContestBean where sHost = :user";
		Session session = factory.getCurrentSession();
		return session.createQuery(hql).setParameter("user", user).getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ContestBean> selectAllContest() {
		String hql = "from ContestBean";
		Session session = factory.getCurrentSession();
		return session.createQuery(hql).getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ContestBean> searchContests(String sSearch, String sGame, String sSignDate) {
		String hql = "from ContestBean where sName like '%" + sSearch + "%' and sGame like '%" + sGame + "%'" + sSignDate ;
		System.out.println(hql);
		Session session = factory.getCurrentSession();
		return session.createQuery(hql).getResultList();
	}

}
