<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- Ajax 로 callback 받을 CKEDITOR 형식의 함수. --%>
<script type="text/javascript">
window.parent.CKEDITOR.tools.callFunction('${callback}',
		'${fileUrl}','이미지를 업로드하였습니다.');
</script>