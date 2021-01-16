package com.web.game.withplay.service;


import java.util.List;

import com.web.game.withplay.model.WithOrder;


public interface WithOrderService {
	
	public boolean updateWithOrderSubmit(Integer iNO);
	
	public boolean updateWithOrderReject(Integer iNO);
	
	public boolean insertWithOrder(WithOrder Order);

	public WithOrder getWithOrder(Integer id);
	
	public List<WithOrder> getWithOrderList(Integer id);

	public List<WithOrder> getWithOrderwithList(Integer id);
	
	public List<WithOrder> list();
}
