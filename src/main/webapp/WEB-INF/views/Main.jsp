<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소설 투고 사이트 메인</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- bootstrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- bootstrap icon -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script type="text/javascript" src="./js/mainjs.js" defer="defer"></script>
<link rel="stylesheet" href="./css/main.css"/>

</head>
<body>

<div class="container">
	
	<nav class="navbar navbar-light bg-light static-top justify-content-center">
		<div class="row">
			<div class="col-lg-2 d-flex align-items-center justify-content-center">
				<input class="btn btn-warning" type="button" value="Main으로" onclick="location.href='list'"
					style="width: 100%; height: 100%; max-height: 5em;"/>
			</div>
	
			<div class="col-lg-8 justify-content-center" class="text-center">
				<span>
					<img alt="소설 투고 사이트" src="./images/logo.jpg" class="img-fluid" width="100%">
				</span>
			</div>
	
			<div class="col-lg-2 d-flex align-items-center justify-content-center">
				<!-- 로그인하지 않은 상태 -->
				<c:if test="${loginCheck != 1}">
					<input class="btn btn-primary" type="button" value="Login"
						style="width: 100%; height: 100%; max-height: 3em;" onclick="location.href='./login?backPage=1&currentPage=${currentPage}'" />
					<input class="btn btn-dark" type="button" value="Register"
						style="width: 100%; height: 100%; max-height: 3em;" onclick="location.href='./register'"/>
				</c:if>
				<!-- 로그인한 상태 -->
				<c:if test="${loginCheck == 1}">
					<div class="overflow-auto d-flex align-items-center justify-content-center" style="width: 100%; height: 100%; max-height: 5em;">
						<div class="loginInfo"><strong>${loginInfoID}</strong></div>님<br/></div>
					<input class="btn btn-primary" type="button" value="Logout"
						style="width: 100%; height: 100%; max-height: 3em;" onclick="location.href='./logout?backPage=1&currentPage=${currentPage}'" />
				</c:if>
			</div>
		</div>
	</nav>


	<main class="container-fluid bg-light flex-fill">
		<div class="row">
			<!-- 세부 카테고리 -->
			<div id="div2" class="col-lg-2 left">
				<h4 align="center">메뉴 목록</h4><hr/>
				
				<div id="div2_1">제목/ID 검색
					<form id="search" action="search" method="post">
						<select name="searchTag" class="form-control form-control-sm">
							<option value="subject">subject</option>
							<option value="id">id</option>
						</select>
						<input class="form-control form-control-sm" size="12" name="searchVal" type="text" placeholder="검색어 입력"> 
						<input type="submit" class="btn btn-outline-primary btm-sm" value="검색" maxlength="10"
							style="width: 100%;">
					</form>
				</div><hr/>
				
				<div id="div2_2">카테고리 검색
						<select id="category" 
	                  class="form-control form-control-sm" 
	                  style="width: 100%; text-align: center;"
	                  onchange="categorySearch()"> 
							<option>장르</option>
							<option value="공포">공포</option>
							<option value="스릴러">스릴러</option>
							<option value="미스터리">미스터리</option>
							<option value="순정">순정</option>
							<option value="코미디">코미디</option>
							<option value="역사">역사</option>
							<option value="판타지">판타지</option>
							<option value="무협">무협</option>
						</select>
				</div><hr/>
				
				
				<div id="div2_3">
					<input
						class="btn btn-outline-primary btm-sm"
						type="button" 
						value="글쓰기" 
						style="width: 100%; height: 80%;  font-size: 20px;"
						onclick="location.href='write?currentPage=${currentPage}'"/>
				</div><hr/>
			</div>
		
		
		<!-- 중간 창 소설 목록 리스트 -->
		<div id="div3" class="col-lg-8">
			<table id="table1" class="table table-light table-hover" style="table-layout: fixed;">
			<!-- 헤드 -->
			<thead>
				<tr class="div3_tr1">
					<td class="col-lg-2">소설 번호</td>
					<td class="col-lg-4">소설 제목</td>
					<td class="col-lg-2">카테고리</td>
					<td class="col-lg-2">작가</td>
					<td class="col-lg-2">조회수</td>
				</tr>
			</thead>	
			
			<!-- 소설 목록을 보여줄 개시판 -->
			<!-- 글을 출력함 -->
			<!-- list에서 mainList에 저장된 1페이지 분량의 글을 꺼내옴 -->
			<c:set var="list" value="${mainList.list}"/>
			<tbody>
			<!-- 글이 없으면 글이 없다고 출력한다. -->
				<c:if test="${list.size() == 0}">
					<tr class="table-danger">
						<td colspan="5" class="align-middle">
							<marquee>게시글이 없습니다</marquee>
						</td>
					</tr>
				</c:if>
				
				<!-- 글이 있으면 글의 개수만큼 반복하며 글의 목록을 출력함 -->
				<c:if test="${list.size() != 0}">
				
				<c:set var="new_idx" value="${mainList.totalCount - (mainList.currentPage - 1) * mainList.pageSize}"/>
				<!-- 반복하여 출력함 -->
				<c:forEach var="vo" items="${list}">
					<tr>
						<!-- 번호 -->
						<td class="align-middle text-center">${new_idx}</td>
						
							<!-- 삭제된 글일 경우 -->
							<c:if test="${vo.deleted == 'yes'}">
								<td class="align-middle text-center">
									삭제된 글입니다
								</td>
							</c:if>
							<!-- 삭제되지 않은 글일 경우 -->
							<c:if test="${vo.deleted != 'yes'}">
								<!-- 제목에 태그를 적용하지 못하게 한다. -->
								<c:set var="subject" value="${fn:replace(vo.subject, '<', '&lt;')}"/>
								<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
								<td class="align-middle text-center boardHyper">
									<a style="width: 100%;"
										class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
										href="read?idx=${vo.idx}&currentPage=${currentPage}">
										${subject}
									</a>
								</td>
							</c:if>
						
						
						<!-- 카테고리 -->
						<td class="align-middle text-center">
							${vo.category}
						</td>
						
						<!-- 작가 id -->
						<td class="align-middle text-center">
							${vo.id}
						</td>
						<!-- 조회수-->
						<td class="align-middle text-center">
						<!-- 삭제된 글일 경우 -->
							<c:if test="${vo.deleted == 'yes'}">
								-
							</c:if>
							<!-- 삭제되지 않은 글일 경우 -->
							<c:if test="${vo.deleted != 'yes'}">
								${vo.hit}
							</c:if>
						</td>
					</tr>
					
					<c:set var="new_idx" value="${new_idx - 1}"/>
				
				</c:forEach>
				</c:if>
				
			</tbody>
			</table>
		</div>
		
		<!-- 오른 쪽 새글, 추천 글 -->
		<div id="div4" class="col-lg-2 right">
			<h4 align="center">
				추천 소설 목록
			</h4><hr/>
			<div class="dropdown">
				<a class="btn btn-outline-success dropdown-toggle" href="" role="button" 
					  id="dropdownMenuLinkHit"
					  data-bs-toggle="dropdown"
					  aria-expanded="false"
					  style="width: 100%; height: 80%;">
						조회수 TOP 5<br/>
				</a>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenuLinkHit">
					<c:set var="list" value="${selectHit.list}" />
					<c:forEach var="vo" items="${list}">
						<c:if test="${vo.deleted != 'yes'}">
							<li>
								<div class="rankHyper">
									<a class="link-success link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
										href="read?idx=${vo.idx}&currentPage=${currentPage}">
									${vo.getSubject()}(${vo.getHit()})</a>
								</div>
							</li>
						</c:if>
						<c:if test="${vo.deleted == 'yes'}">
							<li>
								<div class="rankHyper">
									<a href="">삭제된 글입니다</a>
								</div>
							</li>
						</c:if>
					</c:forEach>
					</ul><hr/>
				</div>
				<div class="dropdown">
						<a class="btn btn-outline-danger dropdown-toggle form-control" href="" role="button" 
						   id="dropdownMenuLinkGood"
						   data-bs-toggle="dropdown"
						   aria-expanded="false"
						   style="width: 100%; height: 80%;">
						   추천수 TOP 5<br/>
						</a>
					<ul class="dropdown-menu" aria-labelledby="dropdownMenuLinkGood">
						<c:set var="list" value="${selectGood.list}" />
						<c:forEach var="vo" items="${list}">
							<c:if test="${vo.deleted == 'no'}">
								<li>
									<div class="rankHyper">
										<a class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
											href="read?idx=${vo.idx}&currentPage=${currentPage}">
										${vo.getSubject()}(${vo.getGood()})</a>
									</div>
								</li>
								</c:if>
								<c:if test="${vo.deleted == 'yes'}">
								<li>
									<div class="rankHyper">
										삭제된 글입니다
									</div>
								</li>
							</c:if>
					</c:forEach>
					</ul><hr/>
				</div>
				<div class="dropdown">
					<a class="btn btn-outline-dark dropdown-toggle" href="" role="button" 
					   id="dropdownMenuLinkNew"
					   data-bs-toggle="dropdown"
					   aria-expanded="false"
					   style="width: 100%; height: 80%;">
						Today NEW<br/>
					</a>
					<ul class="dropdown-menu" aria-labelledby="dropdownMenuLinkNew">
						<c:set var="list" value="${selectNew.list}" />
						<c:forEach var="vo" items="${list}">
							<c:if test="${vo.deleted == 'no'}">
								<li>
									<div class="rankHyper">
										<a class="link-dark link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
											href="read?idx=${vo.idx}&currentPage=${currentPage}">
										${vo.getSubject()}</a>
									</div>
								</li>
							</c:if>
							<c:if test="${vo.deleted == 'yes'}">
								<li>
									<div class="rankHyper">
										삭제된 글입니다
									</div>
								</li>
								</c:if>
						</c:forEach>
					</ul><hr/>
				</div>
			</div>
			
		</div>
	</main>
	
	
		
	<!-- 페이징 작업 -->
	<div class="bg-light">
	
	<div id="div5">
	
		<!-- 처음으로 -->
		<c:if test="${mainList.currentPage > 1}"> 
			<button 
				class="btn btn-outline-secondary"
				type="button"
				title="첫 페이지로 이동합니다."
				onclick="location.href='?currentPage=1'"
			>처음</button>
		</c:if>
		
		<c:if test="${mainList.currentPage <= 1}">
			<button 
				class="btn btn-outline-secondary"
				type="button"
				title="이미 첫 페이지 입니다."
				disabled="disabled"
			>처음</button>
		</c:if>
		
		<!-- 10페이지 앞으로 -->
		<c:if test="${mainList.startPage > 1}">
			<button 
				class="btn btn-outline-secondary" 
				type="button" 
				title="이전 10 페이지로 이동합니다." 
				onclick="location.href='?currentPage=${mainList.startPage - 1}'"
			>이전</button>
		</c:if>
		
		<c:if test="${mainList.startPage <= 1}">
			<button 
				class="btn btn-outline-secondary" 
				type="button" 
				disabled="disabled" 
				title="이미 첫 10 페이지 입니다."
			>이전</button>
		</c:if>
		
		<!-- 페이지 이동 버튼 -->
		<c:forEach var="i" begin="${mainList.startPage}" end="${mainList.endPage}" step="1">

			<c:if test="${mainList.currentPage == i}">
				<button 
					class="btn btn-light"
					type="button" 
					disabled="disabled"
				>${i}</button>
			</c:if>
			
			<c:if test="${mainList.currentPage != i}">
				<button 
					class="btn btn-outline-secondary" 
					type="button" 
					onclick="location.href='?currentPage=${i}'"
				>${i}</button>
			</c:if>
		</c:forEach>
		
		<!-- 10페이지 뒤로 -->
		<c:if test="${mainList.endPage < mainList.totalPage}">
			<button 
				class="btn btn-outline-secondary" 
				type="button" 
				title="다음 10 페이지로 이동합니다." 
				onclick="location.href='?currentPage=${mainList.endPage + 1}'"
			>다음</button>
		</c:if>
		
		<c:if test="${mainList.endPage >= mainList.totalPage}">
			<button 
				class="btn btn-outline-secondary" 
				type="button" 
				disabled="disabled" 
				title="이미 마지막 10 페이지 입니다."
			>다음</button>
		</c:if>
		
		<!-- 마지막으로 -->
		<c:if test="${mainList.currentPage < mainList.totalPage}">
			<button 
				class="btn btn-outline-secondary" 
				type="button" 
				title="마지막 페이지로 이동합니다." 
				onclick="location.href='?currentPage=${mainList.totalPage}'"
			>마지막</button>
		</c:if>

		<c:if test="${mainList.currentPage >= mainList.totalPage}">
			<button 
				class="btn btn-outline-secondary" 
				type="button" 
				disabled="disabled" 
				title="이미 마지막 페이지 입니다."
			>마지막</button>
		</c:if>
			
	</div>
		
	</div>

</div>

</body>
</html>