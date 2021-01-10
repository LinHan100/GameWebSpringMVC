package com.web.game.exchange.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.web.game.exchange.model.SupportGameBean;


@Repository
public class SupportDAO {

	@Autowired
	SessionFactory factory;

	// ------------------------testpage
	@SuppressWarnings("unchecked")
	public List<SupportGameBean> changePage(int page) {
		List<SupportGameBean> list = new ArrayList<>();
		Session session = factory.getCurrentSession();
		String queryAll = "FROM SupportGameBean WHERE status = 0";

		int counts = 6;
		int start = 0;
		if (page == 1) {
			start = 0;
		} else {
			page = page - 1;
			start = page * counts;
		}
		list = (List<SupportGameBean>) session.createQuery(queryAll).setFirstResult(start).setMaxResults(counts)
				.getResultList();
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<SupportGameBean> changePageByParam(int page, String search, String param) {
		List<SupportGameBean> list = new ArrayList<>();
		Session session = factory.getCurrentSession();
		String hql = null;
		String queryGamename = "FROM SupportGameBean WHERE status = 0 AND gamename like '%" + param + "%'";
		String queryArea = "FROM SupportGameBean WHERE status = 0 AND gamelocation like '%" + param + "%'";
		System.out.println("dao param" + param);
		if (search.equals("gamename")) {
			hql = queryGamename;
		} else if (search.equals("area")) {
			hql = queryArea;
		}

		int counts = 6;
		int start = 0;
		if (page == 1) {
			start = 0;
		} else {
			page = page - 1;
			start = page * counts;
		}
		list = (List<SupportGameBean>) session.createQuery(hql).setFirstResult(start).setMaxResults(counts).getResultList();
		return list;
	}

	// -------------------------------------------------

//	public List<SupportGameBean> GetAllSupport() {
//		List<SupportGameBean> list = new ArrayList<>();
//		Session session = factory.getCurrentSession();
//		String hql = "FROM SupportGameBean";
//		Query<SupportGameBean> query = session.createQuery(hql);
//		list = query.getResultList();
//		return list;
//
//	}

	@SuppressWarnings("unchecked")
	public List<SupportGameBean> GetMemberSupport(String account) {
		List<SupportGameBean> list = new ArrayList<>();
		Session session = factory.getCurrentSession();
		String hql = "FROM SupportGameBean g WHERE g.gamer = :account";
		list = session.createQuery(hql).setParameter("account", account).getResultList();
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<SupportGameBean> getMemberPending(String account) {
		List<SupportGameBean> list = new ArrayList<>();
		Session session = factory.getCurrentSession();
		String hql = "FROM SupportGameBean g WHERE g.gamer = :account AND g.status = 2";
		list = session.createQuery(hql).setParameter("account", account).getResultList();
		return list;
	}
	
	// 傳回特定物件值
	public SupportGameBean selectSupportGame(int pno) {// 暫時沒用到
		SupportGameBean gb = null;
		Session session = factory.getCurrentSession();
		gb = session.get(SupportGameBean.class, pno);
		return gb;
	}
//	public SupportGameBean getSupportGameByAccount(String gamename,String account) {
//		SupportGameBean SGB = null;
//		Session session = factory.getCurrentSession();
//		String HQL = "FROM SupportGameBean WHERE gamer = :account AND gamename =:gamename";
//		System.out.println("getSupportGameByAccountin"+account);
//		SGB = (SupportGameBean) session.createQuery(HQL).setParameter("account", account).setParameter("gamename", gamename).getSingleResult();
//		System.out.println("getSupportGameByAccountout");
//		return SGB;
//	}

	public boolean insertSupportGame(SupportGameBean gb) {
		int count = 0;
		boolean result = false;
		Session session = factory.getCurrentSession();
		session.save(gb);
		count++;
		if (count > 0) {
			result = true;
		}
		return result;
	}

	public boolean deleteSupportGame(int pno) {
		int count = 0;
		Session session = factory.getCurrentSession();
		boolean result = false;
		SupportGameBean gb = new SupportGameBean();
		gb.setNo(pno);
		session.delete(gb);
		count++;
		if (count > 0) {
			result = true;
		}
		return result;
	}

	public boolean updateSupportGame(SupportGameBean gb) {
		int count = 0;
		Session session = factory.getCurrentSession();
		boolean result = false;
		session.update(gb);
		count++;
		if (count > 0) {
			result = true;
		}
		return result;

	}
	
	

	@SuppressWarnings("unchecked")
	public Map<String, Object> initOption() {
		// 4個list放進map
		Map<String, Object> initOptionMap = new HashMap<String, Object>();
		List<String> initGamenameOptionList = new ArrayList<String>();
		List<String> initAreaOptionList = new ArrayList<String>();
		List<String> initConsoleOptionList = new ArrayList<String>();
		List<String> initConditionOptionList = new ArrayList<String>();

		Session session = factory.getCurrentSession();
		String gamelistHQL = "select sGame FROM GameList";
		String arealistHQL = "select sArea FROM AreaBean";
		String consolelistHQL = "select sConsole FROM ConsoleBean";
		String conditionlistHQL = "select sCondition FROM ConditionBean";

		initGamenameOptionList = session.createQuery(gamelistHQL).getResultList();
		initAreaOptionList = session.createQuery(arealistHQL).getResultList();
		initConsoleOptionList = session.createQuery(consolelistHQL).getResultList();
		initConditionOptionList = session.createQuery(conditionlistHQL).getResultList();
		
		initOptionMap.put("GamenameList", initGamenameOptionList);
		initOptionMap.put("AreaList", initAreaOptionList);
		initOptionMap.put("ConsoleList", initConsoleOptionList);
		initOptionMap.put("ConditionList", initConditionOptionList);

		return initOptionMap;

	}

}
