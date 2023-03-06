if("#session" != null) {
 var sess = $("#session").val();
} else {
  var sess = 0;
}
function MoinsertHeart(mo){

  if(sess != null) {
    
     $.ajax({
            url : "/sosu/zzimInsert.do",
            type : "post",
            data : {M_IDX : sess, MO_IDX : mo},
            success : function(result){
            location.reload();}
        }); 
     }  
     if(sess == 0) {
     
    alert("로그인이 필요한 서비스입니다. \n로그인페이지로 이동합니다.");
    location.href = 'http://localhost:8080/members/loginform.sosu';
  }
}

function ModeleteHeart(mo){
  
  if(sess != null) {
    
     $.ajax({
            url : "/sosu/zzimDelete.do",
            type : "post",
            data : { M_IDX : sess, MO_IDX : mo},
            success : function(result){
            location.reload();}
        }); 
     }
}

function RvinsertHeart(rv){

  if(sess != null) {
    
     $.ajax({
            url : "/sosu/zzimInsert.do",
            type : "post",
            data : { M_IDX : sess, RV_IDX : rv},
            success : function(result){
            location.reload();}
        }); 
     }  
     if(sess == 0) {
     
    alert("로그인이 필요한 서비스입니다. \n로그인페이지로 이동합니다.");
    location.href = 'http://localhost:8080/members/loginform.sosu';
  }
}

function RvdeleteHeart(rv){
  
  if(sess != null) {
    
     $.ajax({
            url : "/sosu/zzimDelete.do",
            type : "post",
            data : { M_IDX : sess, RV_IDX : rv},
            success : function(result){
            location.reload();}
        }); 
     }
}

function FrinsertHeart(fr){

  if(sess != null) {
    
     $.ajax({
            url : "/sosu/zzimInsert.do",
            type : "post",
            data : { M_IDX : sess, FR_IDX : fr},
            success : function(result){
            location.reload();}
        }); 
     }  
     if(sess == 0) {
     
    alert("로그인이 필요한 서비스입니다. \n로그인페이지로 이동합니다.");
    location.href = 'http://localhost:8080/members/loginform.sosu';
  }
}

function FrdeleteHeart(fr){
  
  if(sess != null) {
    
     $.ajax({
            url : "/sosu/zzimDelete.do",
            type : "post",
            data : { M_IDX : sess, FR_IDX : fr},
            success : function(result){
            location.reload();}
        }); 
     }
}