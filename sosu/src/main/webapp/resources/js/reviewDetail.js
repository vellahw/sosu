function check() {
   
   let category = $("#category").val();
   let idx = $("#RV_IDX").val();

    let result = confirm("게시글을 삭제 하시겠습니까?");
   
    if (result)
    {
        alert("삭제 되었습니다.");

        return true;

    } else 
    {
       return false;
   }
}