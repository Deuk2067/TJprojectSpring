<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소설 내용 수정 PAGE</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script type="text/javascript" src="./js/mainjs.js" defer="defer"></script>
<link rel="stylesheet" href="./css/read.css"/>

</head>
<body>

<c:set var="mainvo" value="${Mainboard}" />
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
					<input class="btn btn-primary" type="button" value="logout"
						style="width: 100%; height: 100%; max-height: 3em;" onclick="location.href='./logout?backPage=1&currentPage=${currentPage}'" />
				</c:if>
			</div>
		</div>
	</nav>
		
	<main class="container-fluid bg-light flex-fill">
		<form action="updateOK" method="post">
			<div class="row">
			
			<div id="div2" class="col-lg-2">
				<div style="display: none;">
					<input name="idx" value="${mainvo.idx}"/>
					<input name="currentPage" value="${currentPage}"/>
					<input name="job" value="updateOK"/>
				</div>
				<h4>소설 정보</h4><hr/>
				<div id="div2_1">
					<label for="title">
						소설 제목<br/>
						<input class="form-control" id="title" maxlength="100" name="subject" value="${mainvo.subject}" style="width: 100%;"/>
					</label>
				</div><hr/>
		
				<div id="div2_3" align="center">
					<input class="btn btn-primary btn-sm" type="submit" value="수정 완료"
						style="width: 100%; height: 80%;"/>
					<input class="btn btn-secondary btn-sm" type="button" value="수정 취소" style="width: 100%; height: 80%;"
						onclick="location.href='read?idx=${mainvo.idx}&currentPage=${currentPage}'"/>
				</div><hr/>
			</div>
			
			<div id="div3" class="col-lg-8">
				<div class="center">
					<h4>소설 내용 수정</h4><hr/>
					<table id="table1" class="table table-light" style="width: 100%;">
						<tr style="height: 2em;">
							<th>작성자 ID</th>
							<td>${mainvo.id}</td>
						</tr>
						<tr style="height: 2em;">
							<th>카테고리</th>
							<td>
								<select id="category" name="category" class="form-control" >
										<option selected="selected">${mainvo.category}</option>
										<option>공포</option>
										<option>스릴러</option>
										<option>미스테리</option>
										<option>순정</option>
										<option>코미디</option>
										<option>역사</option>
								</select>
							</td>
						</tr>
						<tr style="height: 2em;">
							<th>조회수</th>
							<td>${mainvo.hit}</td>
						</tr>
						<tr style="height: 2em;">
							<th>추천수</th>
							<td>${mainvo.good}</td>
						</tr>
						<tr style="height: 2em;">
							<th>작성 날짜</th>
							<fmt:formatDate var="Date" value="${mainvo.writeDate}" pattern="yyyy/MM/dd a h:mm:ss"/>
							<td>${Date}</td>
						</tr>
						<tr>
							<th><label for="contents">내용</label></th>
							<td>
								<textarea class="form-control" id="contents" name="content" maxlength="2000"
									style="height: 6.5em; resize: none;">${mainvo.content}</textarea>
							</td>
						</tr>
					</table>
						
				</div>
			</div>
			
			
			<div id="div4" class="col-lg-2">
			<h4 align="center">추천 소설 목록</h4><hr/>
				<div class="rankHyper2">
				조회수 높은 소설 목록<br/>
				</div>
				<ol>
					<c:set var="list" value="${selectHit.list}" />
					<c:forEach var="vo" items="${list}">
						<c:if test="${vo.deleted != 'yes'}">
							<li>
								<div class="rankHyper">
									<a class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
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
				</ol><hr/>
				<div class="rankHyper2">
				추천 높은 소설 목록<br/>
				</div>
				<ol>
					<c:set var="list" value="${selectGood.list}" />
					<c:forEach var="vo" items="${list}">
						<c:if test="${vo.deleted == 'no'}">
						<li>
							<div class="rankHyper">
								<a class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
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
				</ol><hr/>
				<div class="rankHyper2">
				새로운 소설 목록<br/>
				</div>
				<ol>
					<c:set var="list" value="${selectNew.list}" />
					<c:forEach var="vo" items="${list}">
						<fmt:formatDate var="writeDate" value="${vo.getWriteDate()}" pattern="MM/dd HH:mm:ss"/>
						<c:if test="${vo.deleted == 'no'}">
							<li>
								<div class="rankHyper">
									<a class="link-secondary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
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
				</ol><hr/>
			</div>
			
			</div>
		</form>
	</main>
</div>
</body>
</html>