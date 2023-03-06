/* 입력된 바이트(글자수) 값 제어 */
function fn_checkByte(obj) {
   const maxByte = 2000; //최대 100바이트
   const text_val = obj.value; //입력한 문자
    const text_len = text_val.length; //입력한 문자수
 
    let totalByte = 0;
    for (let i = 0; i < text_len; i++) {
       const each_char = text_val.charAt(i);
       const uni_char = escape(each_char); //유니코드 형식으로 변환
       if (uni_char.length > 4) {
          // 한글 : 2Byte
          totalByte += 3;
       } else {
          // 영문,숫자,특수문자 : 1Byte
          totalByte += 1;
       }
    }
 
    if (totalByte > maxByte) {
       alert('최대 2000Byte까지만 입력가능합니다.');
       document.getElementById("nowByte").innerText = totalByte;
       document.getElementById("nowByte").style.color = "red";
    } else {
       document.getElementById("nowByte").innerText = totalByte;
       document.getElementById("nowByte").style.color = "green";
    }
}   

/* 파일 추가, 수정 버튼 */
var gfv_count = 1;

   $(document).ready(function() {
      $("#update").on("click", function(e) { //수정하기 버튼
         if (document.updateForm.FR_TITLE.value=="") {
              alert("제목을 입력해주세요.");
              document.updateForm.FR_TITLE.focus();
              return false;
           }
      
         if(document.updateForm.FR_CONTENT.value=="") {
              alert("내용을 입력해주세요.");
              document.updateForm.FR_CONTENT.focus();
              return false;
           }
         
         e.preventDefault();
         fn_updatefree();
      });

      $("#addFile").on("click", function(e) { //파일추가 버튼
         e.preventDefault();
         fn_addFile();
      });

      $("a[name='delete']").on("click", function(e) { //삭제 버튼
         e.preventDefault();
         fn_deleteFile($(this));
      });

   });

   function fn_updatefree() {
      var comSubmit = new ComSubmit("frm");
      comSubmit.setUrl('/freeboard/updatefree.sosu');
      comSubmit.submit();
   }

   function fn_addFile() {
      var str = "<p>" + "<input type='file' id='file_"+(gfv_count)+"' name='file_"+(gfv_count)+"'>"+
         "<a href='#this' class='btn' id='delete_"+(gfv_count)+"' name='delete_"+(gfv_count)+"'>삭제</a>" + "</p>";
      $("#fileDiv").append(str);
      $("#delete_"+(gfv_count++)).on("click", function(e){ //삭제 버튼
         e.preventDefault();
         fn_deleteFile($(this));
      });
   }

   function fn_deleteFile(obj) {
      obj.parent().remove(); //this의 바로 위의 요소(<p>태그)를 삭제
   }