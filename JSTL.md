# JSTL(JSP Standard Tag Libarary) 
- JSP 표준라이브러리(JSP Standard Tag Library)의 약어이다. 자주 사용될 수 있는 커스텀 태그들을 모아서 표준으로 모아놓은 태그 라이브러리

## JSTL 의 종류]

| 라이브러리명 | 접두어| 주요기능 | URI| 
|:---|:---|:---|:---|  
| 코어| c | 변수 지원, 제어문, 페이지 관련 처리| http://java.sun.com/jsp|/jstl/core| 
| 함수| fncollection | 처리, String 처리| http://java.sun.com/jsp/jstl/fuctions | 
| 포매팅| fmt | 포맷 처리, 국제화 지원 | http://java.sun.com/jsp/jstl/fmt | 
| 데이터베이스| sql | DB 관련 CRUD 처리 | http://java.sun.com/jsp/jstl/sql|
| XML | x| XML 관련 처리| http://java.sun.com/jsp/jstl/xml |  

## 사용법
JSP 상단에 <%@ taglib prefix="접두어" uri="URI 경로" %> 를 적음