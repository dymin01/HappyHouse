package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ssafy.happyhouse.model.dto.NoticeDto;
import com.ssafy.happyhouse.service.NoticeService;

@CrossOrigin
@Controller
@RequestMapping(value = "/notice")
public class NoticeController {
	

	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ResponseEntity<List<NoticeDto>> noticeList(Model model) {
		List<NoticeDto> notices = null;
		try {
			notices = noticeService.listArticle();
			model.addAttribute("notices", notices);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ResponseEntity<List<NoticeDto>>(notices, HttpStatus.OK);
	}
	
	@GetMapping(value = "/mvwrite")
	public String noticeRegister() {
		return "redirect:/write";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String noticeRegister(@RequestBody NoticeDto noticeDto, Model model, HttpSession session) {
		try {
			System.out.println(noticeDto);
//			MemberDto member = (MemberDto) session.getAttribute("userinfo");
			int cnt = noticeService.registerArticle(noticeDto);
			List<NoticeDto> notices = noticeService.listArticle();
			model.addAttribute("notices", notices);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "noticelist";
	}
	
	@GetMapping(value = "{articleno}")
	public ResponseEntity<NoticeDto> userInfo(@PathVariable int articleno) {
		NoticeDto noticeDto = null;
		try {
			noticeDto = noticeService.getArticle(articleno);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ResponseEntity<NoticeDto>(noticeDto, HttpStatus.OK);
		
	}
	
	@GetMapping(value = "/mvmodify/{articleno}")
	public String noticeModify(@PathVariable int articleno, Model model) {
		try {
			model.addAttribute("article", noticeService.getArticle(articleno));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "update";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String noticeModify(@RequestBody NoticeDto noticeDto) {
		try {
			System.out.println(noticeDto);
			noticeService.modifyArticle(noticeDto);
			List<NoticeDto> list = noticeService.listArticle();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "noticelist";
	}
	
	@RequestMapping(value = "/delete/{articleno}", method = RequestMethod.GET)
	public String noticeDelete(@PathVariable int articleno, Model model) {
		try {
			noticeService.deleteArticle(articleno);
			List<NoticeDto> list = noticeService.listArticle();
			model.addAttribute("notices", list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "noticelist";
	}
}
