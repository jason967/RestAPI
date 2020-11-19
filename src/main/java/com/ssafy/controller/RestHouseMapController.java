package com.ssafy.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.domain.HouseInfo;
import com.ssafy.domain.SidoGugunCode;
import com.ssafy.service.HospitalService;
import com.ssafy.service.HouseMapService;
import com.ssafy.service.ScreeningService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;


@CrossOrigin(origins = {"*"},maxAge = 6000)
@RestController
@Api(value = "Map",description = "map controller")
public class RestHouseMapController {

	private HouseMapService houseMapService;

	@Autowired
	public void setHouseMapService(HouseMapService houseMapService) {
		this.houseMapService = houseMapService;
	}

	private HospitalService hospitalService;

	@Autowired
	public void setHospitalService(HospitalService hospitalService) {
		this.hospitalService = hospitalService;
	}

	private ScreeningService screeningService;

	@Autowired
	public void setScreeningService(ScreeningService screeningService) {
		this.screeningService = screeningService;
	}

	@ApiOperation(value = "act:시도,구군,동  / code: 코드")
	@ApiResponses({
        @ApiResponse(code = 200, message = "OK !!"),
        @ApiResponse(code = 500, message = "Internal Server Error !!"),
        @ApiResponse(code = 404, message = "Not Found !!")
})
	@GetMapping("/map/{act}/{code}")
	public ResponseEntity<List<SidoGugunCode>> getSido( @PathVariable("act") String act,@PathVariable("code") String code) throws Exception {
		
		if("sido".equals(act) ) {
			return new ResponseEntity<List<SidoGugunCode>>( houseMapService.getSido(),HttpStatus.OK) ;
		}
		else if("gugun".equals(act)){
			return new ResponseEntity<List<SidoGugunCode>>( houseMapService.getGugunInSido(code),HttpStatus.OK) ;
		}
		else if("dong".equals(act)){
			return new ResponseEntity<List<SidoGugunCode>>( houseMapService.getDongInGugun(code),HttpStatus.OK) ;
		}
		/*
		else if("apt".equals(act)){
			String dongName = houseMapService.getDongNameByCode(code);
			return new ResponseEntity<List<HouseInfo>>( houseMapService.getAptInDong(dongName),HttpStatus.OK) ;
		}
		*/
		return new ResponseEntity<>( HttpStatus.INTERNAL_SERVER_ERROR);
	}
	/*
	@GetMapping("/map")
	public void HouseMap(HouseInfo house, HttpSession sseion, HttpServletRequest request, HttpServletResponse response,
			Model model) throws IOException {
		response.setCharacterEncoding("UTF-8");
		String act = request.getParameter("act");
		else if ("searchByAptName".equals(act)) {
			String name = request.getParameter("aptName");
			PrintWriter out = response.getWriter();
			List<HouseInfo> list = null;
			JSONArray arr = new JSONArray();
			try {
				list = houseMapService.getAptByName(name);
				for (HouseInfo dto : list) {
					JSONObject obj = new JSONObject();
					obj.put("no", dto.getNo());
					obj.put("dong", dto.getDong());
					obj.put("aptName", dto.getAptName());
					obj.put("code", dto.getCode());
					obj.put("jibun", dto.getJibun());
					arr.add(obj);
				}
			} catch (Exception e) {
				arr = new JSONArray();
				JSONObject obj = new JSONObject();
				obj.put("message_code", "-1");
				arr.add(obj);
				e.printStackTrace();
			} finally {
				out.print(arr.toJSONString());
				out.close();
			}
		} else if ("detail".equals(act)) {
			String name = request.getParameter("name");
			String dong = request.getParameter("dong");
			PrintWriter out = response.getWriter();

			List<HouseDeal> list = null;
			JSONArray arr = new JSONArray();
			try {
				list = houseMapService.getAptDetail(name, dong);
				for (HouseDeal dto : list) {
					JSONObject obj = new JSONObject();
					obj.put("no", dto.getNo());
					obj.put("dong", dto.getDong());
					obj.put("aptName", dto.getAptName());
					obj.put("code", dto.getCode());
					obj.put("dealAmount", dto.getDealAmount());
					arr.add(obj);
				}
			} catch (Exception e) {
				arr = new JSONArray();
				JSONObject obj = new JSONObject();
				obj.put("message_code", "-1");
				arr.add(obj);
				e.printStackTrace();
			} finally {
				out.print(arr.toJSONString());
				out.close();
			}
		} else if ("hospital".equals(act)) {
			String guguncode = request.getParameter("gugun");
			PrintWriter out = response.getWriter();

			List<Hospital> list = null;
			JSONArray arr = new JSONArray();
			try {
				String gugun = (String) houseMapService.getSidoGugunName(guguncode).getGugunName();
				list = (ArrayList<Hospital>) hospitalService.getHospitalInGugun(gugun);

				for (Hospital dto : list) {
					JSONObject obj = new JSONObject();
					obj.put("hospitalName", dto.getName());
					obj.put("address", dto.getAddress());
					obj.put("tel", dto.getTel());
					arr.add(obj);
				}
			} catch (Exception e) {
				arr = new JSONArray();
				JSONObject obj = new JSONObject();
				obj.put("message_code", "-1");
				arr.add(obj);
				e.printStackTrace();
			} finally {
				out.print(arr.toJSONString());
				out.close();
			}
		} else if ("screening".equals(act)) {
			String guguncode = request.getParameter("gugun");
			PrintWriter out = response.getWriter();

			List<Screening> list = null;
			JSONArray arr = new JSONArray();
			try {
				String gugun = (String) houseMapService.getSidoGugunName(guguncode).getGugunName();
				list = (ArrayList<Screening>) screeningService.getScreeninginGugun(gugun);

				for (Screening dto : list) {
					JSONObject obj = new JSONObject();
					System.out.println();
					obj.put("hospitalName", dto.getName());
					obj.put("address", dto.getAddress());
					obj.put("weektime", dto.getWeektime());
//					obj.put("tel", dto.getTel());					
					obj.put("possible", dto.getPossible());
					arr.add(obj);
				}
			} catch (Exception e) {
				arr = new JSONArray();
				JSONObject obj = new JSONObject();
				obj.put("message_code", "-1");
				arr.add(obj);
				e.printStackTrace();
			} finally {
				out.print(arr.toJSONString());
				out.close();
			}
		}

	}*/

}