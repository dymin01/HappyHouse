package com.ssafy.happyhouse.controller;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.dto.QnADto;
import com.ssafy.happyhouse.model.dto.SearchCondition;
import com.ssafy.happyhouse.service.QnAService;
import com.ssafy.happyhouse.util.BoolResult;
import com.ssafy.happyhouse.util.NumberResult;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@CrossOrigin(origins = {"*"}, maxAge = 6000)
@RestController
@RequestMapping("/qna")
@Api(value="SSAFY", description="SSAFY Resouces Management 2019")
public class QnAController {
	
	public static final Logger logger = LoggerFactory.getLogger(QnAController.class);
	
	@Autowired
	private QnAService qnAService;
	
	@ApiOperation(value = "모든 게시글을 반환한다. search컨디션 사용해서 검색한다.", response = List.class)
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ResponseEntity<List<QnADto>> boardList(@ModelAttribute SearchCondition condition) throws Exception{
		
		logger.info(condition.getKey());
		logger.info(condition.getWord());
		logger.info(condition.getOrderBy());
		
		List<QnADto> boards = qnAService.searchBoard(condition);
		logger.info("1-------------findAllBoard-----------------------------"+new Date());
		
		if (boards.isEmpty()) {
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<QnADto>>(boards, HttpStatus.OK);
	}
	
	
	@ApiOperation(value = "모든 게시글을 반환한다.", response = List.class)
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public ResponseEntity<List<QnADto>> board() throws Exception{
		logger.info("1-------------findAllBoard-----------------------------"+new Date());
		List<QnADto> boards = qnAService.findAllBoard();
		if (boards.isEmpty()) {
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<QnADto>>(boards, HttpStatus.OK);
	}
    @ApiOperation(value = "모든 게시글을 반환한다.", response = List.class)
	@RequestMapping(value = "/findAllBoard", method = RequestMethod.GET)
	public ResponseEntity<List<QnADto>> findAllBoard() throws Exception{
		logger.info("1-------------findAllBoard-----------------------------"+new Date());
		List<QnADto> boards = qnAService.findAllBoard();
		if (boards.isEmpty()) {
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<QnADto>>(boards, HttpStatus.OK);
	}
    
    
    @ApiOperation(value = " 새로운 게시글을 입력한다. 그리고 그 게시글의 번호를 반환한다.", response = NumberResult.class)
   	@RequestMapping(value = "/write", method = RequestMethod.POST)
    public ResponseEntity<NumberResult> addEmployee(@RequestBody QnADto dto) {
   		logger.info("5-------------addBoard-----------------------------"+new Date());
   		logger.info("5-------------addBoard-----------------------------"+dto);
   		NumberResult nr=new NumberResult();
   		try {
   			qnAService.addBoard(dto);
   	   		// 이건 잘 모르겠음... 망할
   			nr.setCount(1);
   	   		nr.setName("addBoard");
   	   		nr.setState("success");
   	   		logger.info("5-------------addBoard-------id------------------"+1);
		} catch (Exception e) {
			nr.setCount(-1);
   	   		nr.setName("addBoard");
   	   		nr.setState("fail");
   			//return new ResponseEntity(HttpStatus.NO_CONTENT);
   			return new ResponseEntity<NumberResult>(nr, HttpStatus.OK);
		}

   		return new ResponseEntity<NumberResult>(nr, HttpStatus.OK);
   	}
    
    
    @ApiOperation(value = "게시글 번호로 게시글의 정보를 찾는다.", response = QnADto.class)
	@RequestMapping(value = "/findBoardByNo/{No}", method = RequestMethod.GET)
	public ResponseEntity<QnADto> findBoardByNo(@PathVariable int No) throws Exception {
		logger.info("1-------------findEmployeeByNo-----------------------------"+new Date());
		QnADto board = qnAService.findBoardById(No);
		if (board==null || board.getArticleno() ==0) {
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<QnADto>(board, HttpStatus.OK);
	}
    @ApiOperation(value = "게시글 번호로 게시글의 정보를 찾는다.", response = QnADto.class)
	@RequestMapping(value = "/board/{No}", method = RequestMethod.GET)
	public ResponseEntity<QnADto> board(@PathVariable int No) throws Exception {
		logger.info("1-------------findEmployeeByNo-----------------------------"+new Date());
		QnADto board = qnAService.findBoardById(No);
		if (board==null || board.getArticleno() ==0) {
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<QnADto>(board, HttpStatus.OK);
	}
	
	
    @ApiOperation(value = " 게시글 정보를 수정한다 만약 사원의 부서와 업무가 변경되면 잡히스토리에  자동(trigger)으로 추가된다. 원래 put이다.", response = BoolResult.class)
   	@RequestMapping(value = "/updateBoard", method = RequestMethod.PUT)
   	public ResponseEntity<BoolResult> updateEmployee2(@RequestBody QnADto dto) throws Exception {
   		logger.info("1-------------updateBoard-----------------------------"+new Date());
   		logger.info("1-------------updateBoard-----------------------------"+dto);
   		boolean total = qnAService.updateBoard(dto);
   		BoolResult nr=new BoolResult();
   		nr.setCount(total);
   		nr.setName("updateBoard");
   		nr.setState("success");
   		if (!total) {
   			return new ResponseEntity(HttpStatus.NO_CONTENT);
   		}
   		return new ResponseEntity<BoolResult>(nr, HttpStatus.OK);
   	}
    
    @ApiOperation(value = " 해당게시글 정보를 삭제한다. 게시글 정보를 삭제하기전, 정산하고 , 잡히스토리 수정등 여러 작업을 해야한다. 여기서는 히스토리를 모두 지우고(수정한 적이 없다면 바로 삭제가능) 삭제할 수 있다 . 원래 delete다", response = BoolResult.class)
	@RequestMapping(value = "/deleteBoard/{no}", method = RequestMethod.POST)
	public ResponseEntity<BoolResult> deleteEmployee(@PathVariable int no) throws Exception {
		logger.info("1-------------deleteBoard-----------------------------"+new Date());
		logger.info("1-------------deleteBoard-----------------------------"+no);
		
		boolean total = qnAService.deleteBoard(no);
		BoolResult nr=new BoolResult();
		nr.setCount(total);
		nr.setName("deleteBoard");
		nr.setState("success");
		if (!total) {
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<BoolResult>(nr, HttpStatus.OK);
	}
    
    
}
