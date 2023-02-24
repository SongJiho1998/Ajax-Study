<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax개요</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
	<h1>AJAX 개요</h1>
	
	<p>
		Asynchronous JavaScript And XML의 약자로<br>
		서버로부터 데이터를 가져와 전체 페이지를 새로 고치지 않고 일부만 로드할 수 있게 하는 기법<br>
		우리가 기존에 a 태그로 요청 및 form을통해 요청했던 방식은 동기식 요청방식<br>
		=> 응답페이지가 돌아와야 볼 수 있음(페이지화면 깜빡거림)<br>
		비동기식 요청을 보내기 위해서는 AJAX라는 기술이 필요함<br><br>
		
		* 동기식 / 비동기식<br>
		- 동기식 : 요청 처리 후 그에 해당하는 응답 페이지가 돌아와야만 그 다음 작업 가능<br>
		만약 서버에서 호출된 결과까지의 시간이 지연되면 무작정 계속 기다려야함(흰화면으로 보이게됨)<br>
		전체 페이지가 리로드됨(새로고침 즉, 페이지가 기본적으로 깜박거림) <br><br>
		
		- 비동기식 : 현재 페이지를 그대로 유지하면서 중간중간마다 추가적인 요청을 보내줄 수 있음<br>
		요청을 한다고 해서 다른 페이지로 넘어가지 않음(현재페이지 그대로)<br>
		요청을 보내놓고 그에 해당하는 응답이 돌아올때 까지 현재페이지에서 다른 작업을 할 수 있음(페이지 깜박거리지 않음)<br>
		예) 네이버 홈페이지 실시간 검색기능 or 검색어 자동완성기능 or 아이디 중복체크기능.
		
		* 비동기식의 단점 <br>
		- 현재 페이지에 지속적으로 리소스가 쌓임 -> 페이지가 느려질수 있음.<br>
		- 페이지내 복잡도가 기하급수적으로 증가 => 에러발생시 대처가 어려워짐<br>
		- 요청 후 들어온 응답데이터를 가지고 현재페이지에서 새로운 요소를만들어서 뿌려줘야됨.
		  => DOM요소를 새로이 만들어내는 구문을 잘 숙지하고있어야함<br><br>
	</p>
	
	<h1>javascript 방식을 이용한 AJAX 테스트</h1>
	
	<h3>1. 버튼 클릭시 get방식으로 서버에 데이터 전송 및 응답</h3>
	
	<h3>자바스크립트를 이용한 ajax통신</h3>
	
	<button onclick="ajaxTest1();">javascript ajax 테스트 1</button>
	
	<h3>2. 버튼 클릭시 post방식으로 서버에 데이터 전송 및 응답</h3>
	
	<button onclick="ajaxTest2();">javascript ajax 테스트 2(POST방식)</button>
	
	<div id="target"></div>
	
	<script>
		const ajaxTest1 = () => {
			// ajax로 서버와 통신하기.
			// 1. XMLHttpRequest  객체 생성하기.
			const xhr = new XMLHttpRequest();
			
			// 2. XMLHttpRequest 객체를 설정하기.
			// open()함수를 이용해서 통신값을 설정하기.
			// 1 : 방식(get , post) / 2 : 요청을 보내는 주소 / [3 : 동기식 , 비동기식 설정] 
			// * 클라이언트가 보내는 값을 파라미터로 전송.
			xhr.open("get" , "<%=request.getContextPath()%>/ajaxTest.do?id=admin");
			// 3. 요청에 대한 서버응답을 처리할 함수를 지정.
			// xhr 객체의 onreadystatechange속성에 함수를 대입
			// xhr 객체 내부의 상태를 관리하는 속성
			// 1) readyState : 전송상태를 관리.
			// 2) status : 응답결과 관리.
			xhr.onreadystatechange = () => {
				if(xhr.readyState == 4){ // 정상적으로 응답을 받았을때(기본값은 0 , 4일경우 정상적인 응답을 받음)
					if(xhr.status == 200){
						// 응답메세지를 정상적으로 수신.
						// 서버가 응답한 내용은 xhr객체의 responseText 속성에 자동으로 들어감.
						console.log(xhr.responseText);
						document.getElementById("target").innerHTML += "<h3>"+xhr.responseText+"/<h3>";
					}
					else if(xhr.status == 404){
						alert("찾는 페이지가 존재하지 않습니다.");
					}else {
						alert("에러가 발생했습니다.")
					}
				}		
			}
			
			// 모든값에 대한 설정을 완료한 후 요청을 전송.
			xhr.send();
		};
		
		const ajaxTest2 = () => {
			const xhr = new XMLHttpRequest();
			
			xhr.open("post" , "<%=request.getContextPath()%>/ajaxTest.do");
			
			xhr.onreadystatechange = () => {
				
				if(xhr.readyState == 4){
					if(xhr.status == 200){
						document.getElementById("target").innerHTML += "<h4>"+xhr.responseText+"</h4>";
					}
				}	
			}
			
			// post방식으로 데이터 전송시 파라미터 설정 방법
			// url에 데이터 내용을 작성하지 않고 , send함수의 매개변수로 작성.
			// 전송방식도 수정해야됨.
			
			xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			xhr.send("id=user01");
		}
	</script>
	
	<pre>
		* jQuery 방식에서의 AJAX 통신
		
		$.ajax({
			속성명:속성값,
			속성명:속성값,
			속성명:속성값
			...
		});
		
		* 주요속성
		- url : 요청할 url(필수)
		- type|method : 요청전송방식(get/post, 생락시 기본값 get)
		- date : 요청시 전달할 값
		- success : ajax통신 성공시 실행할 함수를 정의.
		- error : ajax 통신 실패시 실행할 함수 정의
		- complete : ajax통신 실패했든 , 성공했든 무조건 실행할 함수 정의
		
		* 부수적인 속성
		- async : 서버와의 비동기 처리방식 설정 여부(기본값 true)
		- contentType : request의 데이터 인코딩 방식 정의(보내는 측의 데이터 인코딩)
		- dataType : 서버에서 response로 오는데이터의 데이터 형설정, 값이 없다면 알아서 판단함.
					 xml : 트리형태의 구조
					 json : 맵 형태의 구조(일반적인 데이터구조)
					 script : javascript 및 일반 String형태의 데이터
					 html : html태그 자체를 return하는 방식
					 text : String데이터
		- accept : 파라미터의 타입 설정(사용자 특화된 파라미터 타입 설정 가능)
		- beforeSend : ajax요청을 하기전 실행되는 이벤트 callback함수(데이터 가공 및 header관련 설정)
		- cache : 요청 및 결과값을 scope에서 갖고있지 않도록 하는것(기본값은 true)
		- contents : jQuery에서 response의 데이터를 파싱하는 방식 정의
		- crossDomain : 타 도메인 호출 가능 여부 설정(기본값은 false)
		- dataFilter : response데이터를 받았을때 정상적인 값을 return할 수 있도록 데이터와 데이터 타입 설정
		- global : 기본 이벤트 사용여부(ajaxStart, ajaxStop) => 버퍼링 같이 시작과 끝을 나타날때 , 선처리 작업시 사용
		- password : 서버에 접속권한이 필요한경우 설정.
		- processData : 서버로 보내는 값에 대한 형태 설정 여부(기본데이터를 원하는 경우 false 설정)
		- timeout : 서버 요청시 응답 대기시간 (ms로 설정)
	</pre>
	
	<h1>jQuery 방식을 이용한 AJAX 테스트</h1>
	
	<h3>1. 버튼 클릭시 get방식으로 서버에 데이터 전송 및 응답</h3>
	
	입력 : <input type="text" id="input1">
	<button id="btn1">전송</button>
	<br>
	
	응답 : <label id="output1">현재 응답 없음</label>
	
	<script>
		$(function(){
			
			$("#btn1").click(function(){
				
				// 기존의 동기식 방식
				// location.href = '/ajax/url.do?input='+$("#input1").val();
				// 404에러 발생할것
				
// 				let param = {{input : $("#input1").val()},
// 						{input2 : $("#input1").val()},
// 						{input3 : $("#input1").val()}}
				
				// 비동기식 통신(페이지가 전환되지 않기때문에 에러발생하지 않음)
				$.ajax({
					url : "jqAjax1.do",
					data : {input : $("#input1").val()}, // param;
					type : "get", 
					success : function(result){ // 익명함수, 매개변수로 서블릿으로부터 전달받은 값
						console.log(result);
						$("#output1").text(result);
					},
					error : function(){
						console.log("ajax통신 실패!");
					},
					complete : function(){
						console.log("ajax 통신 여부와 상관없이 항상 실행될것.");
					}
				})
			});
		})
	</script>
	
	<hr>
	<br>
	
	<h3>2. 버튼클릭시 post방식으로 서버에 데이터 전송 및 응답</h3>
	
	이름 : <input type="text" id = "input2_1"> <br>
	나이 : <input type="number" id = "input2_2"> <br>
	<button onclick="test2();">전송</button>
	<br>
	
	응답 : <label id="output2">현재 응답 없음</label>
	
	<script>
// 		function test2(){
// 			$.ajax({
// 				url : "jqAjax2.do",
// 				data : {
// 					name : $("#input2_1").val() ,
// 					age : $("#input2_2").val() ,
// 				},
// 				type : "post",
// 				success : function(result){
// 					$("#output2").text(result);
					
// 					// 입력값을 초기화 
// 					$("input2_1").val("");
// 					$("input2_2").val("");
// 				},
// 				error : function(){
// 					console.log("통신 실패");
// 				}
// 			});
// 		}

	function test2(){
		$.ajax({
			url : "jqAjax2.do",
			data : {
				name : $("#input2_1").val() ,
				age : $("#input2_2").val() ,
			},
			type : "post",
			success : function(result){
				// $("#output2").text(result);
				console.log(result);
				// JSONArray로 응답받을 경우
				// []
				// $("#output2").text("이름 : "+ result[0] + ", 나이 : " + result[1]);
				
				// JSONObject로 응답받을 경우
				$("#output2").text("이름 : " + result.name + ", 나이 : " + result["age"]);
				
				// 입력값을 초기화 
				$("input2_1").val("");
				$("input2_2").val("");
			},
			error : function(){
				console.log("통신 실패");
			}
		});
	}

	</script>
	
	<h3>3. 서버로 데이터 전송 후, 조회된 객체를 응답데이터로 받기</h3>
	
	회원번호 입력 : <input type="number" id = "input3">
	<button onclick="test3();">조회</button>
	
	<div id="output3"></div>
	
	<script>
		function test3(){
			$.ajax({
				url : "jqAjax3.do" ,
				data : {no : $("#input3").val()} ,
				success : function(result){
					console.log(result);
					let resultStr =  "회원번호 : " + result.memberNo + "<br>"
									+ "이름 : " + result.memberName + "<br>"
									+ "나이 : " + result.age + "<br>"
									+ "성별 : " + result.gender + "<br>";
					$("#output3").html(resultStr);
				},
				error : function(request , status , error){
					console.log(request , status , error);
				}
			})
		}
	</script>
	
	<h3>4. 응답데이터로 여러개의 객체들이 담겨있는 ArrayList 받기</h3>
	
	<button onclick="test4();">회원전체조회</button>
	
	<table id="output4" border="1" style="text-align:center">
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>나이</th>
				<th>성별</th>
			</tr>
		</thead>
		<tbody>
		
		</tbody>
	</table>
	
	<script>
		function test4(){
			$.ajax({
				url : "jqAjax4.do",
				success : function(result){
					let str = "";
					
					for(let i = 0; i < result.length; i++){
						str += "<tr>"
									+ "<td>" + result[i].memberNo + "</td>"
									+ "<td>" + result[i].memberName + "</td>"
									+ "<td>" + result[i].age + "</td>"
									+ "<td>" + result[i].gender + "</td>"
						str + "</tr>"; 
					}
					// 화면에 띄우기
					$("#output4 tbody").html(str);
					
				},
				error : function(req , status , err){
					console.log(req , status , err);
				}
			});
		}
	</script>
	
	<h2>5. ajax를 이용한 자동완성 구현하기</h2>
	
	<input id="keyword" list="list" type="text" placeholder="찾을 게시글을 작성하세요.">
	<datalist id="list">
	</datalist>
	
	<script>
		$(function(){
			$("#keyword").keyup(function(e){
				$.ajax({
					url : "jqAutoSearch.do",
					data : {keyword : $(e.target).val()}, // or $("#keyword").val()
					success : function(data){
						
						$("#list").html(""); // 리스트 비워주기
						
						let str = "";
						for(let i = 0; i < data.length; i++){
							str += "<option>"
								+ data[i].boardTitle
								+ "</option>"
						}
						$("#list").html(str);
					}
				});
			});
		})	
	</script>
	
	<h2>6. Ajax로 html파일 받아오기</h2>
	
	<button id="htmlAjax">html문서 받기</button>
	<div></div>
	
	<script>
		$(function(){
			$("#htmlAjax").click(function(){
				$.ajax({
					url : "<%= request.getContextPath()%>/jqHtmlTest.do",
					type : "get",
					dataType : "html",
					success : function(data){
						console.log(data); // <!DOCTYPE ~HTML
						$("#htmlAjax+div").html(data);
					}
				})
			})
		});
	</script>
	
	<h2>7. xml 데이터 가져오기</h2>
	<button id="xmlTest">xml 데이터 가져오기</button>
	
	<div id="fiction">
		<h2>소설</h2>
		<table id="fiction-info">
		
		</table>
	</div>
	
	<div id="it">
		<h2>프로그래밍</h2>
		<table id="it-info">
		
		</table>
	</div>
	
	<script>
		$(function(){
			$("#xmlTest").click( () => {
				$.ajax({
					url : "books.xml",
					success : data => {
						let ficheader = "<tr><th>제목</th><th>저자</th></tr>";
						let itheader = ficheader;
						
						console.log(data);
						let entity = $(data).find(":root"); // 데이터를 유동적으로 가져오는 방법 => :root
						console.log(entity);
						let books = $(entity).find("book"); // find() : 내가 찾고자 하는 속성 제시
						console.log(books);
						
						books.each(function(index , value){ // index : <book></book> 안의 내용. // value : 안의 값들.
							let info = "<tr><td>"+$(value).find("title").text()+"</td>"
								     + "<td>"+$(value).find("author").text()+"</td>"
							let subject = $(value).find("subject").text();
							if(subject == "소설"){
								ficheader += info;
							}else if(subject == "프로그래밍"){
								itheader += info;
							}
						});
						
						$("#fiction-info").html(ficheader);
						$("#it-info").html(itheader);
					}
				});
			})
		})
	</script>
	
	<h2>8. Ajax를 이용한 파일업로드 처리하기</h2>
	<input type="file" id="upfile" multiple>
	<button onclick="sendFile();">파일전송</button>
	
	<script>
		function sendFile(){
			// 파일 전송시 FormData객체를 생성해서 전달하기.
			let form = new FormData();
			
			// form.append("upfile" , $("#upfile").files[0]); 
			// console.log($("#upfile")[0] , $("#upfile")[0].files[1]);
			$.each($("#upfile")[0].files , function(index , file){
				console.log(index , file);
				form.append("upfile"+index , file);
			});
			form.append("name","송지호");
			
			$.ajax({
				url : "fileUpload.do",
				data : form,
				type : "post",
				processData : false,
				contentType : false,
				success : function(data){
					alert("업로드 성공"); 
					$("#upfile").val("");
				}
			})
		}
	</script>
	
	
</body>
</html>