package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.net.URI;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.ssafy.happyhouse.model.dto.GuguncodeDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.dto.SidocodeDto;
import com.ssafy.happyhouse.service.SidoGugunDongService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping(value = "/main")
@Api(value = "SSAFY", description = "SSAFY Resouces Management 2021")
public class MainController {
	
	@Autowired
	private SidoGugunDongService sidoGugunDongService;
	
	@ApiOperation(value = "시,도 정보를 받아서 넘긴다.")
	@RequestMapping(value = "/sido", method = RequestMethod.GET)
	public List<SidocodeDto> getsido() {
		List<SidocodeDto> list = null;
		try {
			list = sidoGugunDongService.getAllSidocode();
		} catch (Exception e) {
			return list = null;
		}
		
		return list;
	}
	@ApiOperation(value = "시도 정보를 통해 구군 코드를 반환한다.")
	@RequestMapping(value = "/gugun/{sido}", method = RequestMethod.GET)
	public List<GuguncodeDto> getgugun(@PathVariable String sido) {
		List<GuguncodeDto> list = null;
		try {
			list = sidoGugunDongService.getGuguncode(sido);
		} catch (Exception e) {
			return list = null;
		}
		
		return list;
	}
	@ApiOperation(value = "구군 코드를 통해 동 코드를 반환한다.")
	@RequestMapping(value = "/dong/{gugun}", method = RequestMethod.GET)
	public List<HouseInfoDto> getdong(@PathVariable String gugun) {
		List<HouseInfoDto> list = null;
		try {
			list = sidoGugunDongService.getDongcodes(gugun);
		} catch (Exception e) {
			return list = null;
		}
		
		return list;
	}
	
	@ApiOperation(value = "아파트 정보를 10개 얻어온다.")
	@RequestMapping(value = "/findAll", method = RequestMethod.GET)
	public ResponseEntity<String> getAptinfo(@RequestParam("dongCode") String sidoCode) throws IOException {
    	String key = "DK8KcTemKVSqu1vOCqowaxNH5hH8TxfvO4cvmO4HdSYixe6hiu6Q%2FO9OMVmCvL4oV52lUUZVVhH4caJqiZW6hQ%3D%3D";
    	//String key = "9Xo0vlglWcOBGUDxH8PPbuKnlBwbWU6aO7%2Bk3FV4baF9GXok1yxIEF%2BIwr2%2B%2F%2F4oVLT8bekKU%2Bk9ztkJO0wsBw%3D%3D";
    	
    	System.out.println("지역 코드(구군) : " + sidoCode);
    	// 지역코드 (동코드)
    	String LAWD_CD = sidoCode;
    	// 계약월
    	String DEAL_YMD = "202012";
    	
		//지역코드, 계약월에 맞게 다 가져오는 API
    	String url = "http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade?LAWD_CD=" + LAWD_CD +
    			"&DEAL_YMD=" + DEAL_YMD + 
    			"&serviceKey=" + key; /*URL*/
		
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		HttpEntity<HttpHeaders> entity = new HttpEntity<>(headers);
		
		ResponseEntity<String> response = restTemplate.exchange(URI.create(url), HttpMethod.GET, entity, String.class);
		
		return response;
	}
	
	@ApiOperation(value = "아파트 정보를 10개 얻어온다.")
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ResponseEntity<String> getinfo() throws IOException {
    	String key = "DK8KcTemKVSqu1vOCqowaxNH5hH8TxfvO4cvmO4HdSYixe6hiu6Q%2FO9OMVmCvL4oV52lUUZVVhH4caJqiZW6hQ%3D%3D";
    	
    	//페이지 번호
    	String pageNo = "";
    	// 한 페이지에 표시할 결과 수
    	String numOfRows = "";
    	// 지역코드 (동코드)
    	String LAWD_CD = "";
    	// 계약월
    	String DEAL_YMD = "";
    	
		//지역코드, 계약월, page별로 n개씩 가져오는 API
    	String url = "http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev?LAWD_CD=" + LAWD_CD +
    			"&pageNo=" + pageNo + 
    			"&numOfRows=" + numOfRows + 
    			"&DEAL_YMD=" + DEAL_YMD + 
    			"&serviceKey=" + key; /*URL*/
		//지역코드, 계약월에 맞게 다 가져오는 API
//    	String url2 = "http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade?LAWD_CD=" + LAWD_CD +
//    			"&DEAL_YMD=" + DEAL_YMD + 
//    			"&serviceKey=" + key; /*URL*/
		
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		HttpEntity<HttpHeaders> entity = new HttpEntity<>(headers);
		
		ResponseEntity<String> response = restTemplate.exchange(URI.create(url+key), HttpMethod.GET, entity, String.class);
		
		return response;
	}
	
	
}
