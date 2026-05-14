package com.club.app.pager;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProductPager {

	// 검색어
	private String search = "";

	// 검색 컬럼 v1: title v2: contents, v3: writer
	private String kind;

	// 페이지번호
	private Long page;

	// 페이지 글의 갯수: perPage
	private Long perPage;

	// OFFSET 번호
	private Long startNum;

	private Long start;
	private Long end;

	// 첫 블럭과 끝 블럭의 앞,뒤 블럭유무
	private boolean pre = true; // true 블럭이 존재
	private boolean next = true; //

	public Long getPerPage() {
		if (perPage == null || perPage < 1) {
			this.perPage = 9L;
		}
		return perPage;
	}

	public Long getPage() {
		if (page == null || page < 1) {
			page = 1L;
		}
		return page;
	}

	public void makePageNum(Long totalCount) {
		// 1. 총 페이지 수
		// 페이지 수가 null 일 수도 있어서 get으로 꺼내온 페이지 값 넣기
		Long totalPage = (long) (Math.ceil((double) totalCount / this.getPerPage()));

		// 2. 총 블럭 수 구하기
		Long perBlock = 5L;
		Long totalBlock = totalPage / perBlock;
		if (totalPage % perBlock != 0) {
			totalBlock++;
		}

		// 3. 페이지 번호로 현재 블럭 번호 구하기
		Long curBlock = this.getPage() / perBlock;
		if (this.page % perBlock != 0) {
			curBlock++;
		}

		// 4. 현재 블럭 번호로 시작 번호와 끝 번호를 구하기
		start = (curBlock - 1) * perBlock + 1;
		end = curBlock * perBlock;

		// 5. 현재 블럭 번호가 총 블럭과 같다면
		if (curBlock == totalBlock) {
			end = totalPage;
			next = false;
		}

		// 6. 이전 유무
		if (curBlock < 2) {
			pre = false;
		}

	}

	public void makeStartNum() {
		this.startNum = (this.getPage() - 1) * this.getPerPage();
	}

}