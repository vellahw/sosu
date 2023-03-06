package second.sosu.common.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Criteria {
   
      private int pageNum; //페이지 번호
      private int amount; //한 페이지 당 보여줄 데이터 수
      private String MO_REGION;
      private String type;
      private String keyword;
      
      // 한 페이지에서 보여줄 데이터 개수 : 12
      public Criteria() {
         this(1, 12);
      }
      
      // 변수에 저장
      public Criteria(int pageNum, int amount) {
         this.pageNum = pageNum;
         this.amount = amount;
      }
      
      // Uri 추가 메소드
      public String getListLink() {
         UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
            .queryParam("pageNum", this.pageNum)
            .queryParam("amount", this.getAmount())
            .queryParam("type", this.getType())
            .queryParam("keyword", this.getKeyword());
         return builder.toUriString();
      }
}