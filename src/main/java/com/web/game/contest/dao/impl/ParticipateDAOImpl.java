package com.web.game.contest.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.game.contest.dao.ParticipateDAO;
import com.web.game.contest.model.ParticipateBean;

@Repository
public class ParticipateDAOImpl implements ParticipateDAO {

	@Autowired
	SessionFactory factory;
	
	@Override
	public Boolean insertParticipate(ParticipateBean pParticipateBean) {
		Session session = factory.getCurrentSession();
		try {
			session.save(pParticipateBean);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public Boolean deleteParticipate(Integer contestNo, String sPlayer) {
		String hql = "delete from ParticipateBean where contestNo = :contestNo and sPlayer = :sPlayer";
		Session session = factory.getCurrentSession();
		try {
			Integer result = session.createQuery(hql)
									.setParameter("contestNo", contestNo)
									.setParameter("sPlayer", sPlayer)
									.executeUpdate();
//			System.out.println("result: " + result);
			if(result != 1) {
				new Exception();
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}



	@SuppressWarnings("unchecked")
	@Override
	public List<ParticipateBean> selectParticipate(String user) {
		String hql = "from ParticipateBean where sPlayer = :user";
		Session session = factory.getCurrentSession();
		return session.createQuery(hql).setParameter("user", user).getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ParticipateBean> selectContestParticipate(Integer contestNo) {
		String hql = "from ParticipateBean where contestNo = :contestNo";
		Session session = factory.getCurrentSession();
		return session.createQuery(hql).setParameter("contestNo", contestNo).getResultList();
	}

	
	
}
