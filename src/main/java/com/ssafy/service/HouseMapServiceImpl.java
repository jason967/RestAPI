package com.ssafy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.domain.HouseDeal;
import com.ssafy.domain.HouseInfo;
import com.ssafy.domain.SidoGugunCode;
import com.ssafy.mapper.HouseMapDAO;

@Service
public class HouseMapServiceImpl implements HouseMapService {

	private HouseMapDAO houseMapDao;

	@Autowired
	public void setHouseMapDao(HouseMapDAO houseMapDao) {
		this.houseMapDao = houseMapDao;
	}

	@Override
	public List<SidoGugunCode> getSido() throws Exception {
		System.out.println();
		return houseMapDao.getSido();
	}

	@Override
	public List<SidoGugunCode> getGugunInSido(String sido) throws Exception {
		return houseMapDao.getGugunInSido(sido);
	}

	@Override
	public List<SidoGugunCode> getDongInGugun(String gugun) throws Exception {
		return houseMapDao.getDongInGugun(gugun);
	}

	@Override
	public List<HouseInfo> getAptInDong(String dong) throws Exception {
		return houseMapDao.getAptInDong(dong);
	}

	@Override
	public List<HouseInfo> getAptByName(String aptName) throws Exception {
		return houseMapDao.getAptByName(aptName);
	}

	@Override
	public List<HouseDeal> getAptDetail(String aptName, String dong) throws Exception {
		System.out.println(aptName + " " + dong);
		return houseMapDao.getAptDetail(aptName, dong);
	}

	@Override
	public SidoGugunCode getSidoGugunName(String guguncode) throws Exception {
		return houseMapDao.getSidoGugunName(guguncode);
	}

	@Override
	public String getDongNameByCode(String code) throws Exception {
		return houseMapDao.getDongNameByCode(code);
	}

}
