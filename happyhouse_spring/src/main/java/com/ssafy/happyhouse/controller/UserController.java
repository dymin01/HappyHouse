package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.ssafy.happyhouse.model.dto.FavoriteAreaDto;
import com.ssafy.happyhouse.model.dto.UserDto;
import com.ssafy.happyhouse.model.dto.NoticeDto;
import com.ssafy.happyhouse.service.UserService;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@CrossOrigin
@Controller
@RequestMapping("/user")
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ResponseEntity<UserDto> login(@RequestBody Map<String, String> map, Model model, HttpSession session, HttpServletResponse response) {
		UserDto userDto = null;
		try {
			userDto = userService.login(map);
			if(userDto != null) {
				
				session.setAttribute("userinfo", userDto);
				
				Cookie cookie = new Cookie("ssafy_id", userDto.getUserid());
				cookie.setPath("/");
				if("saveok".equals(map.get("idsave"))) {
					cookie.setMaxAge(60 * 60 * 24 * 365 * 40);//40년간 저장.
				} else {
					cookie.setMaxAge(0);
				}
				response.addCookie(cookie);
				
			} else {
				model.addAttribute("msg", "아이디 또는 비밀번호 확인 후 로그인해 주세요.");

				return new ResponseEntity<UserDto>(userDto, HttpStatus.BAD_REQUEST); 
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "로그인 중 문제가 발생했습니다.");

			return new ResponseEntity<UserDto>(userDto, HttpStatus.BAD_REQUEST); 
		}
		return new ResponseEntity<UserDto>(userDto, HttpStatus.OK); 
	}
	
	@RequestMapping(value = "/check/{userid}", method = RequestMethod.GET)
	public ResponseEntity<Boolean> login(@PathVariable String userid) {
		return new ResponseEntity<Boolean>(userService.checkDuplication(userid), HttpStatus.OK); 
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public ResponseEntity<Boolean> join(@RequestBody UserDto userDto, Model model, HttpSession session, HttpServletResponse response) {
		try {
			System.out.println(userDto);
			userService.userRegister(userDto);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "회원가입 중 문제가 발생했습니다.");
//			return "error/error";
		}
		return new ResponseEntity<Boolean>(true, HttpStatus.OK); 
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public ResponseEntity<Boolean> modify(@RequestBody UserDto userDto) {
		try {
			userService.userModify(userDto);
			System.out.println(userDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Boolean>(true, HttpStatus.OK); 
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ResponseEntity<List<UserDto>> getUserList() {
		List<UserDto> userlist = userService.userList();
		
		if(userlist == null || userlist.size() == 0) {
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}
		
		return new ResponseEntity<List<UserDto>>(userlist, HttpStatus.OK); 
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public ResponseEntity<Boolean> delete(@RequestBody String userid) {
		int res = userService.userDelete(userid);
		if(res == 0) {
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}else {
			return new ResponseEntity<Boolean>(true, HttpStatus.OK);
		}
	}
	
	@RequestMapping(value = "/delete/{userid}", method = RequestMethod.GET)
	public ResponseEntity<Boolean> userDelete(@PathVariable String userid) {
		userService.userDelete(userid);
		return new ResponseEntity<Boolean>(true, HttpStatus.OK); 
	}
	
	@RequestMapping(value = "/{user_idx}", method = RequestMethod.GET)
	public ResponseEntity<UserDto> login(@PathVariable int user_idx) {
	    UserDto userDto = userService.userInfo(user_idx);
	    return new ResponseEntity<UserDto>(userDto, HttpStatus.OK); 
	}

	@RequestMapping(value = "/area/list/{user_idx}", method = RequestMethod.GET)
	public ResponseEntity<List<FavoriteAreaDto>> areaList(@PathVariable int user_idx) {
	    return new ResponseEntity<List<FavoriteAreaDto>>(userService.areaList(user_idx), HttpStatus.OK); 
	}

	@RequestMapping(value = "/area/add", method = RequestMethod.POST)
	public ResponseEntity<Boolean> addArea(@RequestBody FavoriteAreaDto favoriteAreaDto, Model model, HttpSession session, HttpServletResponse response) {
		
		if(userService.addArea(favoriteAreaDto) != 0) {
	    	return new ResponseEntity<Boolean>(true, HttpStatus.OK);
	    }
	    return new ResponseEntity(HttpStatus.NO_CONTENT);
	}

	@RequestMapping(value = "/area/delete", method = RequestMethod.POST)
	public ResponseEntity<Boolean> deleteArea(@RequestBody FavoriteAreaDto favoriteAreaDto, Model model, HttpSession session, HttpServletResponse response) {
	    	    
	    if(userService.deleteArea(favoriteAreaDto) != 0) {
	    	return new ResponseEntity<Boolean>(true, HttpStatus.OK);
	    }
	    return new ResponseEntity(HttpStatus.NO_CONTENT);
	}

	
}
