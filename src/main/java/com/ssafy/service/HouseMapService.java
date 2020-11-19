package com.ssafy.service;

import java.util.List;

import com.ssafy.domain.HouseDeal;
import com.ssafy.domain.HouseInfo;
import com.ssafy.domain.SidoGugunCode;

public interface HouseMapService {

	List<SidoGugunCode> getSido() throws Exception;

	List<SidoGugunCode> getGugunInSido(String sido) throws Exception;

	List<HouseInfo> getDongInGugun(String gugun) throws Exception;

	List<HouseInfo> getAptInDong(String dong) throws Exception;

	List<HouseInfo> getAptByName(String aptName) throws Exception;

	List<HouseDeal> getAptDetail(String aptName, String dong) throws Exception;

	SidoGugunCode getSidoGugunName(String guguncode) throws Exception;
}
