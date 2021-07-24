package com.ssafy.happyhouse.model.dto;

public class SearchCondition {
	// 한 페이지에 몇개나 보여줄 것인지 결정한다.
	public final int countPerPage = 3;

	// 검색 컬럼으로 기본인 none은 검색하지 않는다. ex) isbn
	private String key = "none";
	// 검색어: ex: 111-222-3333
	private String word;
	// 검색 결과를 정렬할 컬럼 이름으로 기본인 none은 정렬하지 않는다., ex)author
	private String orderBy = "none";
	// 정렬 방향으로 기본은 asc
	private String orderByDir = "asc";
	// limit 를 적용할 것인지 설정한다.
	private boolean limit = true;

	public SearchCondition() {
	}

	public SearchCondition(String key, String word) {
		this(key, word, "none");
	}

	public SearchCondition(String key, String word, String orderBy) {
		this(key, word, orderBy, "asc");
	}


	public SearchCondition(String key, String word, String orderBy, String orderByDir) {
		this.key = key;
		this.word = word;
		this.orderBy = orderBy;
		this.orderByDir = orderByDir;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public String getOrderByDir() {
		return orderByDir;
	}

	public void setOrderByDir(String orderByDir) {
		this.orderByDir = orderByDir;
	}

	public int getCountPerPage() {
		return countPerPage;
	}

	public boolean isLimit() {
		return limit;
	}

	public void setLimit(boolean limit) {
		this.limit = limit;
	}

	@Override
	public String toString() {
		return "SearchCondition [key=" + key + ", word=" + word + ", orderBy=" + orderBy + ", orderByDir=" + orderByDir + "]";
	}

}
