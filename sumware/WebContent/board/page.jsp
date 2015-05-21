<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--Page --%>
<c:choose>
	<c:when test="${pageInfo.currentBlock eq 1}">&lt;&lt;</c:when>
	<c:otherwise>
		<a
			href="${pageUrl}&page=${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock }">&lt;&lt;</a>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${pageInfo.currentBlock ne pageInfo.totalBlocks}">
		<c:forEach begin="1" end="${pageInfo.pagesPerBlock}" varStatus="num">[
			<a href="${pageUrl}&page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>]
        </c:forEach>
	</c:when>
	<c:otherwise>
		<c:forEach begin="${(pageInfo.currentBlock-1)*pageInfo.pagesPerBlock + 1}"
			end="${pageInfo.totalPages}" varStatus="num">
                        [<a	href="${pageUrl}&page=${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }">${(pageInfo.currentBlock - 1) * pageInfo.pagesPerBlock + num.count }</a>]
        </c:forEach>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${pageInfo.currentBlock eq pageInfo.totalBlocks}">
                &gt;&gt;
    </c:when>
	<c:otherwise>
		<a href="${pageUrl}&page=${pageInfo.currentBlock * pageInfo.pagesPerBlock + 1 }">&gt;&gt;</a>
	</c:otherwise>
</c:choose>