function gfn_isNull(str) {
  if (str == null) return true;
  if (str == "NaN") return true;
  if (new String(str).valueOf() == "undefined") return true;    
    var chkStr = new String(str);
    if( chkStr.valueOf() == "undefined" ) return true;
    if (chkStr == null) return true;    
    if (chkStr.toString().length == 0 ) return true;   
    return false; 
}

function ComSubmit(opt_formId) {
  this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
  this.url = "";
  
  if(this.formId == "commonForm"){
    $("#commonForm")[0].reset();
  }
  
  this.setUrl = function setUrl(url){
    this.url = url;
  };
  
  this.addParam = function addParam(key, value){
    $("#"+this.formId).append($("<input type='hidden' name='"+key+"' id='"+key+"' value='"+value+"' >"));
  };
  
  this.submit = function submit(){
    var frm = $("#"+this.formId)[0];
    frm.action = this.url;
    frm.method = "post";
    frm.submit(); 
  };
}

/* ===================== 페이징 이동 및 세팅 함수 ===================== */
function paging(pageNo){
   form.action = location.pathname;
   form.innerHTML = form.innerHTML + "<input type='hidden' name='currentPageNo' value='"+pageNo+"'>";
   form.submit();
}
function set_paging(){
   if(!isNull($(".paging"))){
      let pagin_count = document.querySelectorAll(".paging a").length;
      if($(".paging a:nth-child(1)").text() == "[처음]") $(".paging a:nth-child(1)").addClass("first");
      if($(".paging a:nth-child(2)").text() == "[이전]") $(".paging a:nth-child(2)").addClass("before");
      if($(".paging a:nth-child("+pagin_count+")").text() == "[다음]") $(".paging a:nth-child("+pagin_count+")").addClass("next");
      if($(".paging a:nth-child("+(pagin_count+1)+")").text() == "[마지막]") $(".paging a:nth-child("+(pagin_count+1)+")").addClass("end");
   }
}