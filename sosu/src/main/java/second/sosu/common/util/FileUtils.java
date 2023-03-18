package second.sosu.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


@Component("fileUtils") // @Component 어노테이션을 이용해, 이 객체의 관리를 스프링이 담당하도록 설정
public class FileUtils {

   private static final String filePath = "/resources/img/";
   
   public Map<String,Object> profileInsert(Map<String,Object> map, HttpServletRequest request) throws Exception{
      String realPath = "";
      String savePath = filePath;
      
      realPath = request.getRealPath(savePath);
      
      File baseFile;
      
//      if(map.get("GenderCheck").toString().equals("1") || map.get("GenderCheck").toString().equals("3")) {
//         file1 = new File(filePath+"profile\\base_m.png");
//      }else {
//         file1 = new File(filePath+"profile\\base_w.png");
//      }
      
      if(map.get("GenderCheck").toString().equals("1") || map.get("GenderCheck").toString().equals("3")) {
         baseFile = new File(realPath+"profile/base_m.png");
      }else {
         baseFile = new File(realPath+"profile/base_w.png");
      }
      
      
      String fileExtension = CommonUtils.getRandomString();
      File file2 = new File(realPath+"upload/"+fileExtension+".png");

      
      long fsize1 = baseFile.length(); // 원본 파일 크기 변환
        
      FileInputStream fis = new FileInputStream(baseFile);
      FileOutputStream fos = new FileOutputStream(file2);
        
      int input=0, count=0;
        
      byte[] data = new byte[1024];
        
      while((input=fis.read(data))!=-1){
         // 배열을 할 때는 0부터 끝까지 넣어야함
         fos.write(data, 0, input);
         count+=input; 
      }
      
      Map<String,Object> profile = new HashMap<>();
      
      profile.put("M_IDX", map.get("M_IDX"));
      profile.put("F_ARTICLE", map.get("F_ARTICLE"));
      profile.put("F_OGNAME",baseFile.getName());
      profile.put("F_SVNAME", fileExtension+".png");
      profile.put("F_SIZE", count/fsize1);
         
      return profile;
      
   } 
   
   
   
   
   
   public List<Map<String,Object>> profileUpdate(Map<String,Object> map, HttpServletRequest request) throws Exception{
      
      MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
      
      Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
      
      String realPath = "";
      String savePath = filePath;
      
      realPath = request.getRealPath(savePath);
      
      MultipartFile multipartFile = null;
      String originalFileName = null;
      String originalFileExtension = null;
      String storedFileName = null;
      
      //list : 클라이언트에서 전송된 파일 정보를 담아서 반환할 리스트
      List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
      Map<String,Object> listMap = null;
      
      //ServiceImpl에서 전달한 map에서 신규 생성되는 게시글의 번호를 받아오도록 함
      String M_IDX = (String)map.get("M_IDX");
      
      while(iterator.hasNext()) {
         multipartFile = multipartHttpServletRequest.getFile(iterator.next());
         if(multipartFile.isEmpty()==false) {
            
            //원본 파일의 이름을 받아옴
            originalFileName = multipartFile.getOriginalFilename();
            //파일의 원본 이름을 받아와서 해당 파일의 확장자를 구한 후
            originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            //CommonUtils의 getRandomString()을 통해 랜덤한 파일 이름 생성하고, 원본 파일 확장자 붙임
            storedFileName = CommonUtils.getRandomString()+originalFileExtension;
            
            File file = new File(realPath+"upload/"+storedFileName);
            multipartFile.transferTo(file); //업로드 처리
            
            listMap = new HashMap<String,Object>();
            listMap.put("M_IDX", M_IDX);
            listMap.put("F_OGNAME", originalFileName);
            listMap.put("F_SVNAME", storedFileName);
            listMap.put("F_SIZE", multipartFile.getSize());
            list.add(listMap);
            
         }
      }
      return list;
      
   }
   
//   public List<Map<String,Object>> fileInsert(Map<String,Object> map, HttpServletRequest request) throws Exception{
//      
//      MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
//      
//      Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
//      
//      MultipartFile multipartFile = null;
//      String originalFileName = null;
//      String originalFileExtension = null;
//      String storedFileName = null;
//      
//      List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
//      Map<String,Object> listMap = null;
//      
//      File file = new File(filePath);
//      
//      while(iterator.hasNext()) {
//         multipartFile = multipartHttpServletRequest.getFile(iterator.next());
//         if(multipartFile.isEmpty()==false) {
//            
//            originalFileName = multipartFile.getOriginalFilename();
//            originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
//            storedFileName = CommonUtils.getRandomString()+originalFileExtension;
//            
//            file = new File(filePath+storedFileName);
//            multipartFile.transferTo(file); //업로드 처리
//            
//            listMap = new HashMap<String,Object>();
//            if(map.get("MO_IDX")!=null) {
//               listMap.put("F_ARTICLE", map.get("MO_IDX"));
//               listMap.put("F_TABLE", map.get("M"));
//               
//            }else if(map.get("RV_IDX")!=null) {
//               listMap.put("F_ARTICLE", map.get("RV_IDX"));
//               listMap.put("F_TABLE", map.get("R"));
//               
//            }else if(map.get("FR_IDX")!=null) {
//               listMap.put("F_ARTICLE", map.get("FR_IDX"));
//               listMap.put("F_TABLE", map.get("F"));
//               
//            }else if(map.get("N_IDX")!=null) {
//               listMap.put("F_ARTICLE", map.get("N_IDX"));
//               listMap.put("F_TABLE", map.get("N"));
//            }
//            
//            //메인 이미지는 이름 mainImage로 ㄱㄱ
//            if(multipartFile.getName().equals("mainIamge")) {
//               listMap.put("F_MAIN_YN", "Y");
//            }else {
//               listMap.put("F_MAIN_YN", "N");
//            }
//              
//               listMap.put("F_OGNAME", originalFileName);
//               listMap.put("F_SVNAME", storedFileName);
//               listMap.put("F_SIZE", multipartFile.getSize());
//               list.add(listMap);
//            
//         }
//      }
//      return list;
//      
//   }
   
   public List<Map<String,Object>> fileInsert(Map<String,Object> map, HttpServletRequest request) throws Exception{
         
         String realPath = "";
         String savePath = filePath;
            
         realPath = request.getRealPath(savePath);
         
         MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
         
         Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
         
         MultipartFile multipartFile = null;
         String originalFileName = null;
         String originalFileExtension = null;
         String storedFileName = null;
         
         List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
         Map<String,Object> listMap = null;
         
         while(iterator.hasNext()) {
            multipartFile = multipartHttpServletRequest.getFile(iterator.next());
            if(multipartFile.isEmpty()==false) {
               
               originalFileName = multipartFile.getOriginalFilename();
               originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
               storedFileName = CommonUtils.getRandomString()+originalFileExtension;
               
               File file = new File(realPath+"upload/"+storedFileName);
               multipartFile.transferTo(file); //업로드 처리
               
               listMap = new HashMap<String,Object>();
               if(map.get("MO_IDX")!=null) {
                  listMap.put("F_ARTICLE", map.get("MO_IDX"));
                  listMap.put("F_TABLE", "M");
                  if(map.get("rMax")!=null) {
                     
                     listMap.put("F_ARTICLE", map.get("rMax"));
                     listMap.put("F_TABLE", "R");
                     listMap.put("F_MAIN_YN", "M");
                  }
                  
               }else if(map.get("FR_IDX")!=null) {
                  listMap.put("F_ARTICLE", map.get("FR_IDX"));
                  listMap.put("F_TABLE", "F");
                  
               }else if(map.get("N_IDX")!=null) {
                  listMap.put("F_ARTICLE", map.get("N_IDX"));
                  listMap.put("F_TABLE", "N");
               }

               //메인 이미지는 이름 mainIamge로 ㄱㄱ
               if(multipartFile.getName().equals("mainIamge")) {
                  listMap.put("F_MAIN_YN", "Y");
               }else {
                  listMap.put("F_MAIN_YN", "N");
               }
                 
                  listMap.put("F_OGNAME", originalFileName);
                  listMap.put("F_SVNAME", storedFileName);
                  listMap.put("F_SIZE", multipartFile.getSize());
                  list.add(listMap);
               
            }
         }
         return list;
      }

}