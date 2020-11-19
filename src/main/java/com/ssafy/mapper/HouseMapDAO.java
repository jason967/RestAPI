package com.ssafy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ssafy.domain.HouseDeal;
import com.ssafy.domain.HouseInfo;
import com.ssafy.domain.SidoGugunCode;

@Repository
@Mapper
public interface HouseMapDAO {
	List<SidoGugunCode> getSido();

	List<SidoGugunCode> getGugunInSido(String sido);

	List<SidoGugunCode> getDongInGugun(String gugun);

	List<HouseInfo> getAptInDong(String dong);

	List<HouseInfo> getAptByName(String name);

	List<HouseDeal> getAptDetail(@Param("aptName") String aptName, @Param("dong") String dong);

	SidoGugunCode getSidoGugunName(String guguncode);

	String getDongNameByCode(String code);
}
