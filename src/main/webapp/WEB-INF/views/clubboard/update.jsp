<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<c:import url="/WEB-INF/views/temp/head_css.jsp"></c:import>
	
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
   
	
</head>
<body id="page-top">
	<div id="wrapper">
		<c:import url="/WEB-INF/views/temp/sidebar.jsp"></c:import>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
				
				<!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-4 text-gray-800">Create Page</h1>
                    
                    <div>
	                    <form action="./update" method="post" enctype="multipart/form-data">
	                    	<input type="hidden" value="${dto.boardNum}" name="boardNum">
						  <div class="form-group">
						    <label for="title">제목</label>
						    <input type="text" name="boardTitle" value="${dto.boardTitle}" class="form-control" id="title" >
						  </div>
						  <div class="form-group">
						    <label for="writer">작성자</label>
						    <input type="text" name="boardWriter" readonly value="${dto.boardWriter}" class="form-control" id="writer" >
						  </div>						 
						  <div class="form-group">
						    <label for="contents">내용</label>
						    <textarea rows="12" cols="" name="boardContents" class="form-control" id="contents">${dto.boardContents}</textarea>
						    
						  </div>
						  
						  <div class="form-group">
						  	<label>첨부파일</label>
						  	<input type="file" name="attach" class="form-control">
						  	<input type="file" name="attach" class="form-control">
						  </div>
						  				  					  
						  <button type="submit" class="btn btn-primary">Submit</button>
						</form>
                    	
                    
                    </div>

                </div>
                <!-- End Page container-fluid -->
                
			</div>
			<!-- End page Content -->
			<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
		</div>
		<!-- End Content wrapper -->
	</div>
	<!-- End Wrapper -->
	
	<c:import url="/WEB-INF/views/temp/footer_script.jsp"></c:import>
	
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
	<script>
      $('#contents').summernote({
        placeholder: 'Hello Bootstrap 4',
        tabsize: 2,
        height: 100
      });
    </script>

</body>
</html>