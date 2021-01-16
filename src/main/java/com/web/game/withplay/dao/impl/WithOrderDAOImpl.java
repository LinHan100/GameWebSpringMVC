package com.web.game.withplay.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.game.withplay.dao.WithOrderDao;
import com.web.game.withplay.model.WithOrder;

@Repository
public class WithOrderDAOImpl implements WithOrderDao{
	
	@Autowired
	SessionFactory factory;
	
	public boolean insertWithOrder(WithOrder Order) {
		int count = 0;
		boolean result = false;
		Session session = factory.getCurrentSession();
		session.save(Order);
		
		
		count++;
		if (count > 0) {
			result = true;
		}
		return result;
	}
	
	public boolean deleteWithOrder(WithOrder Order) {
		int count = 0;
		boolean result = false;
		Session session = factory.getCurrentSession();
		session.delete(Order);
		count++;
		if (count > 0) {
			result = true;
		}
		return result;
	}
	
	public WithOrder getWithOrder(Integer id) {
		Session session = factory.getCurrentSession();
		WithOrder Order = new WithOrder();
		Order = session.get(WithOrder.class, id);
		return Order;
		
	}
	
	public boolean updateWithOrder(WithOrder Order) {
		int count = 0;
		boolean result = false;
		Session session = factory.getCurrentSession();
		session.update(Order);
		count++;
		if (count > 0) {
			result = true;
		}
		return result;
		
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<WithOrder> getWithOrderlist(Integer id) {
		
		Session session = factory.getCurrentSession();
		System.out.println("id"+id);
		List<WithOrder> listPartyA = new ArrayList<WithOrder>();
		String HQLMemberBean = "FROM WithOrder WHERE MPlay = :id";
		listPartyA = (List<WithOrder>) session.createQuery(HQLMemberBean).setParameter("id", id).getResultList();
		System.out.println("listPartyA"+listPartyA);
		
		return listPartyA;
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<WithOrder> getWithOrderwithList(Integer id) {
		Session session = factory.getCurrentSession();
		System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
		System.out.println("id"+id);
		List<WithOrder> list = new ArrayList<WithOrder>();
		String HQLMemberBean = "FROM WithOrder WHERE Play = :id";
		list = (List<WithOrder>) session.createQuery(HQLMemberBean).setParameter("id", id).getResultList();
		System.out.println("listParty"+list);		
		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<WithOrder> list() {
		Session session = factory.getCurrentSession();
		String hql = "FROM WithOrder";
		List<WithOrder> list = session.createQuery(hql).getResultList();
		return list;
	}


}