[API Request] GET http://localhost:8080/api/v1/auth/kakao/login-url
Headers: ["Content-Type": "application/json"]
Body: 없음
[API Response] GET http://localhost:8080/api/v1/auth/kakao/login-url
Status Code: 200
Response Body: {"status":200,"data":{"loginUrl":"https://kauth.kakao.com/oauth/authorize?client_id=fcdef606075e13512243c022e5a852f8&redirect_uri=http://localhost:8080/auth/kakao/callback&response_type=code&prompt=login"},"success":true,"timeStamp":"2025-11-11T22:27:50.693243"}