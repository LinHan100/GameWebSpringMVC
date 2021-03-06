package com.web.game.forum.service.impl;

import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.game.forum.dao.ForumDAO;
import com.web.game.forum.model.ForumBean;
import com.web.game.forum.service.ForumService;

@Service
public class FourmServiceImpl implements ForumService {
	
	@Autowired
	ForumDAO fDAO;
	
	@Transactional
	@Override
	public Boolean insertOrUpdateForum(ForumBean fForumBean) {
		return fDAO.insertOrUpdateForum(fForumBean);
	}

	@Transactional
	@Override
	public void deleteForum(Integer iNo) {
		fDAO.deleteForum(iNo);
	}

	@Override
	public Boolean updateForum(ForumBean fForumBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional
	@Override
	public ForumBean selectOneForum(Integer iNo) {
		return fDAO.selectOneForum(iNo);
	}

	@Transactional
	@Override
	public List<ForumBean> selectUserForum(String user) {
		return fDAO.selectUserForum(user);
	}

	@Transactional
	@Override
	public List<ForumBean> selectAllForum() {
		return fDAO.selectAllForum();
	}

	@Transactional
	@Override
	public List<ForumBean> searchForum(String sCategory, String sSearch, Integer scrollInt) {
		return fDAO.searchForum(sCategory, sSearch, scrollInt);
	}
	
	@Transactional
	@Override
	public List<Object[]> searchHotForums(String sCategory, String sSearch, String sHot, Integer scrollInt) {
		return fDAO.searchHotForums(sCategory, sSearch, sHot, scrollInt);
	}

	@Override
	public void setTime(ForumBean fForumBean) {
		SimpleDateFormat dateSdf = new SimpleDateFormat( "yyyy-MM-dd");
    	SimpleDateFormat timeSdf = new SimpleDateFormat( "HH:mm:ss");
    	String sDateString = dateSdf.format(new java.util.Date());
    	String sTimeString = timeSdf.format(new java.util.Date());
    	Date dDate = Date.valueOf(sDateString);
    	Time tTime = Time.valueOf(sTimeString);
    	fForumBean.setdDate(dDate);
    	fForumBean.settTime(tTime);
	}
	
	

}
