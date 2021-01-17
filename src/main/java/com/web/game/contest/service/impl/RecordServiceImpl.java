package com.web.game.contest.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.game.contest.dao.RecordDAO;
import com.web.game.contest.model.RecordBean;
import com.web.game.contest.service.RecordService;

@Service
public class RecordServiceImpl implements RecordService {
	
	@Autowired
	RecordDAO rDAO;

	@Transactional
	@Override
	public Boolean insertRecord(RecordBean rRecordBean) {
		return rDAO.insertRecord(rRecordBean);
	}

	@Transactional
	@Override
	public void deleteRecord(Integer contestNo) {
		rDAO.deleteRecord(contestNo);
	}

	@Transactional
	@Override
	public List<RecordBean> selectContestRecord(Integer contestNo) {
		return rDAO.selectContestRecord(contestNo);
	}

	@Transactional
	@Override
	public void addScore(Integer contestNo, Integer groupNo, List<String> sWinPlayers) {
		rDAO.addScore(contestNo, groupNo, sWinPlayers);
	}
	
	

}