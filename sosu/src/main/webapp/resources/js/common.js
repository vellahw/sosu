
/* ===================== 재욱효원) 회원쪽 ===================== */
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

/* ===================== 폼 제출 함수 ===================== */
/* a태그 클릭 시 form 제출로 바꿔서 이동시키는 함수.
  a 태그 세팅
  클래스 명: use_move
  href: form을 제출할 링크
  onclick: move(파라미터)
*/
function move(target, where, ...param){
  if(form == null) return console.log("제출할 폼이 없습니다");
  /*
  target: 무조건 this
  where: 전달시키려는 input이 a 태그 내부일 경우 in, 부모일 경우 out
  param: 전달시키려는 input의 name을 따옴표(" 또는 ')로 감싸 적어줄것!
  */
  let tag = "";
  let _to = target.href;
  if(isNull(_to)) _to = target.dataset.href;
  if(_to != "#"){ form.action = _to; }//폼의 제출처 바꾸기
  if(where == "out"){ target = target.parentElement; }
  
  //input 처리
  for(let i=0; i<param.length; i++){
    let _inputs = target.querySelectorAll("input[name='"+param[i]+"']");
    for(let j=0; j<_inputs.length; j++){
      tag += _inputs[j].outerHTML;
    };
  }
  form.innerHTML = form.innerHTML + tag;
  form.submit();
}