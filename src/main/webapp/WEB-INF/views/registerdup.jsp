<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register Check</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function registerCheckFunction() {
            let id = $('#id').val();

            $.ajax({
                type: 'POST',
                url: './registerCheck.jsp', // 중복 체크를 수행할 JSP 페이지 경로
                data: {id: id},
                success: function (response) {
                    if (response.trim() === '1') {
                        alert('ID를 입력하세요.');
                    } else if (response.trim() === '2') {
                        alert('이미 사용 중인 아이디입니다.');
                    } else if (response.trim() === '3') {
                        alert('사용 가능한 아이디입니다.');
                    } else {
                        alert('오류가 발생했습니다.');
                    }
                },
                error: function (xhr, status, error) {
                    alert('요청 실패: ' + status);
                }
            });
        }
    </script>
</head>
<body>
    <h1>Register Check</h1>
    <label for="id">ID: </label>
    <input type="text" id="id">
    <button onclick="registerCheckFunction()">중복 체크</button>
</body>
</html>