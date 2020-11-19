package com.ssafy.service;

import java.util.List;

import com.ssafy.domain.BizCategory;
import com.ssafy.domain.BizInfo;

public interface BizInfoService {
	List<BizCategory> getLargeCategory() throws Exception;

	List<BizCategory> getMidCategory(String large_code) throws Exception;

	List<BizCategory> getSmallCategory(String mid_code) throws Exception;

	List<BizInfo> getBizList(String dong_name, String small_code);

	List<BizInfo> getBizListByDong(String dong_name);

	List<BizInfo> getBizListByCategory(String small_code);
}
