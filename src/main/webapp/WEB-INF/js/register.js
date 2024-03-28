// 아이디 중복 검사를 실행하는 함수
function registerCheckFunction() {
    let id = $('#id').val();
    // 입력된 아이디가 비어 있는지 확인
    if (id.trim() === '') {
        alert('ID를 입력하세요.');
	}
    else {
		
    }

    // AJAX 요청을 사용하여 서버에 중복 확인 요청
    $.ajax({
        type: 'POST',
        url: './registerCheck', // 중복 확인을 처리하는 서블릿 경로
        data: { id: id }, // 중복 확인을 위해 아이디 데이터 전송
        success: function(res) {
            // 서버에서 받은 응답에 따라 처리
            switch (res) {
                case '1':
                    alert('ID를 입력하고 중복 체크 버튼을 눌러주세요.');
                    break;
                case '2':
                    alert('이미 사용중인 ID입니다.');
                    break;
                case '3':
                    alert('사용 가능한 ID입니다.');
                    break;
                default:
                    alert('알 수 없는 오류가 발생했습니다.');
            }
        },
        error: function(e) {
            alert('오류가 발생했습니다. 다시 시도해주세요.');
        }
    });
}

// 비밀번호 일치 확인 함수
function passwordCheckFunction() {
    let pw = $('#pw').val();
    let pw2 = $('#pw2').val();
    
    if (pw !== pw2) {
        $('#passwordCheckMessage').html('비밀번호가 일치하지 않습니다.');
    } else {
        $('#passwordCheckMessage').html('비밀번호가 일치합니다.');
		let b = document.getElementById('registerb').value
		console.log(b)
    }
}

/*// 회원 가입 실행 함수
function userRegister() {
    let id = $('#id').val();
    let pw = $('#pw').val();
    let pw2 = $('#pw2').val();
    let name = $('#name').val();
    let nick = $('#nick').val();
    let email = $('#email').val();

    // 필요한 데이터를 받아와 처리

    // 실제 회원 가입 처리 로직을 구현
    alert('회원 가입이 완료되었습니다.');
}*/

