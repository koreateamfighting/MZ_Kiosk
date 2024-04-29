//2023 PD Refresh 8F Kiosk_backend_Project create by Jinwoo.choi
//Usage : node app.js , lt --port 50002 --subdomain [서브도메인명]

/**
 * 20230821 Honken.Park
 * LT -> Nginx 적용
 * nodejs 실행 시, 내부포트 5050으로 실행, Nginx 50002번 Reserver Proxy 적용. 외부포트 36402
 * https://pdrf.mediazenaicloud.com:36402
 */

const client = require("./connection.js");
const encryption = require("./common/utils.js"); //230814. utils에 단방향,양방향 존재. 이 중 단방향 사용하기로 협의. 단방향 'hash' 모듈 사용
const express = require("express");
const http = require("http");
const WebSocket = require("ws");
const bodyParser = require("body-parser");
const cors = require("cors");
const dayjs = require("dayjs");
//const d = dayjs(); 모듈안에서 실행해야 실시간의 결과가 나오니 여기서는 제외
const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

app.use(cors());
app.use(express.urlencoded());
app.use(bodyParser.json());

server.listen(5050, () => {
  console.log("Server is now listening at port 5050");
});

client.connect();

//////////////////////////////////////////////////////////// 매니저용 시안 API 시작////////////////////////////////////////////////////////////

app.post(
  "/Add_product/:food_name/:category/:price/:discount_available",
  (req, res) => {
    let insertQuery = `insert into "MZ_Kiosk".cafeteria_menu (food_name,category,price,discount_available) OVERRIDING SYSTEM VALUE values
    (
      '${req.params.food_name}',
      ${req.params.category},
      ${req.params.price},
      ${req.params.discount_available}
    )`;

    client.query(insertQuery, (err, result) => {
      if (!err) {
        res.send("상품 등록 성공!!!!");
      } else {
        console.log(err.message);
      }
    });
    client.end;
  }
); //Manager-01. 상품 등록 (사진 제외)

app.put("/Edit_product/:food_id/:food_name/:price/:category", (req, res) => {
  let updateQuery = `update "MZ_Kiosk".cafeteria_menu set     
    food_name = '${req.params.food_name}',
    price = ${req.params.price},
    category = ${req.params.category}
    where food_id = ${req.params.food_id}`;

  client.query(updateQuery, (err, result) => {
    if (!err) {
      res.send("상품 편집 성공");
    } else {
      console.log(err.message);
    }
  });
  client.end;
}); //Manager-02. 상품 편집 (사진 제외)

app.get("/Sale_status_list_coffee", (req, res) => {
  client.query(
    'select food_name, price , sale_status from "MZ_Kiosk".cafeteria_menu where category = 0',
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-03_1.품절상태 변경을 위한 조회 리스트(커피)

app.get("/Sale_status_list_milk", (req, res) => {
  client.query(
    'select food_name, price , sale_status from "MZ_Kiosk".cafeteria_menu where category = 1',
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-03_2.품절상태 변경을 위한 조회 리스트(우유)

app.get("/Sale_status_list_ade", (req, res) => {
  client.query(
    'select food_name, price , sale_status from "MZ_Kiosk".cafeteria_menu where category = 2',
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-03_3.품절상태 변경을 위한 조회 리스트(에이드)

app.get("/Sale_status_list_sparkling_and_juice", (req, res) => {
  client.query(
    'select food_name, price , sale_status from "MZ_Kiosk".cafeteria_menu where category = 3',
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-03_4.품절상태 변경을 위한 조회 리스트(탄산/쥬스)

app.get("/Sale_status_list_tea", (req, res) => {
  client.query(
    'select food_name, price , sale_status from "MZ_Kiosk".cafeteria_menu where category = 4',
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-03_5.품절상태 변경을 위한 조회 리스트(차)

app.get("/Sale_status_list_ramen", (req, res) => {
  client.query(
    'select food_name, price , sale_status from "MZ_Kiosk".cafeteria_menu where category = 5',
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-03_6.품절상태 변경을 위한 조회 리스트(라면)

app.get("/Sale_status_list_rice", (req, res) => {
  client.query(
    'select food_name, price , sale_status from "MZ_Kiosk".cafeteria_menu where category = 6',
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-03_7.품절상태 변경을 위한 조회 리스트(밥)

app.get("/Sale_status_list_salad", (req, res) => {
  client.query(
    'select food_name, price , sale_status from "MZ_Kiosk".cafeteria_menu where category = 7',
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-03_8.품절상태 변경을 위한 조회 리스트(샐러드)

app.get("/Sale_status_list_bread", (req, res) => {
  client.query(
    'select food_name, price , sale_status from "MZ_Kiosk".cafeteria_menu where category = 8',
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-03_9.품절상태 변경을 위한 조회 리스트(빵)

app.get("/Sale_status_list_dessert", (req, res) => {
  client.query(
    'select food_name, price , sale_status from "MZ_Kiosk".cafeteria_menu where category = 9',
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-03_10.품절상태 변경을 위한 조회 리스트(디저트)

app.put("/Sale_status_change/:food_id/:sale_status", (req, res) => {
  let updateQuery = `update "MZ_Kiosk".cafeteria_menu set sale_status = ${req.params.sale_status} where food_id = ${req.params.food_id}`;

  client.query(updateQuery, (err, result) => {
    if (!err) {
      res.send("판매 상태 변경 성공");
    } else {
      console.log(err.message);
    }
  });
  client.end;
}); //Manager-04.특정 메뉴 품절여부 변경(true/false)

app.get("/Orderlist", (req, res) => {
  client.query(
    'select order_number, order_time, empno,ename , team , grade , order_status , total_order_list , total_price from "MZ_Kiosk".order_history  order by order_number desc',
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-05.카페매니저 실시간 주문 조회 or 일반 조회 (qr 정보는 노출되지 않음)

/* app.put('/Order_cancel/:order_number', (req, res)=> {
    
    let updateQuery =`update "MZ_Kiosk".user_info
    set total_usage = total_usage - (select total_price from "MZ_Kiosk".order_history where order_number = ${req.params.order_number}),
    this_month_usage = this_month_usage - (select total_price from "MZ_Kiosk".order_history where order_number =${req.params.order_number})
    where empno = (select empno from "MZ_Kiosk".order_history  where order_number = ${req.params.order_number})`

    client.query(updateQuery,(err, result)=>{
        if(!err){
            res.send('환불 및 주문 상태 (취소) 성공')
        }
        else{ console.log(err.message) }
    })
    client.end;

    
  
})//Manager-06.주문 취소 (환불) 처리  */

app.put("/Order_status/:order_number/:order_status", (req, res) => {
  let updateQuery = `update "MZ_Kiosk".order_history set order_status = ${req.params.order_status} where order_number = ${req.params.order_number}`;

  client.query(updateQuery, (err, result) => {
    if (!err) {
      if (req.params.order_status == 3) {
        client.query(
          `update "MZ_Kiosk".user_info
                set total_usage = total_usage - (select total_price from "MZ_Kiosk".order_history where order_number = ${req.params.order_number}),
                this_month_usage = this_month_usage - (select total_price from "MZ_Kiosk".order_history where order_number =${req.params.order_number})
                where empno = (select empno from "MZ_Kiosk".order_history  where order_number = ${req.params.order_number})`,
          (err, result) => {
            if (!err) {
              res.send("주문 상태 변경 성공");
            } else {
              console.log(err.message);
            }
          }
        );
      } else {
        res.send("주문 상태 변경 성공");
      }
    } else {
      console.log(err.message);
    }
  });

  client.end;
}); //Manager-06.주문 상태 변경 (order_status에  취소, 환불을 의미하는 3번 인자 입력시 주문자의 지출내역도 undo 처리 )

app.get("/Search_name/:ename", (req, res) => {
  console.log(req.params.ename);
  client.query(
    `select ename, empno, team, grade from "MZ_Kiosk".user_info  where ename like '${req.params.ename}'  order by empno asc`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-08_1.사원(이름) 검색

app.get("/Search_number/:empno", (req, res) => {
  client.query(
    `select ename, empno, team, grade from "MZ_Kiosk".user_info  where empno = ${req.params.empno}`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-08_2.사번 검색

app.get("/Search_period/:empno/:first_day/:last_day", (req, res) => {
  client.query(
    `select order_time ,
    total_price ,
    concat(order_list1_name,
    (case when order_list10_name = '_' then 
        case when order_list9_name = '_' then 
            case when order_list8_name = '_' then
                case when order_list7_name = '_' then 
                    case when order_list6_name = '_' then 
                        case when order_list5_name = '_' then 
                            case when order_list4_name = '_' then
                                case when order_list3_name = '_' then 
                                    case when order_list2_name = '_' then ''
                                    else E' 외 1' end
                                else E'외 2' end
                            else E' 외 3' end
                        else E' 외 4' end
                    else E' 외 5' end
                else E' 외 6' end
              else  E' 외 7' end
            else E' 외 8' end	
        else E' 외 9' end)) as test, 
    order_status,
    order_number,
    total_order_list 
    from "MZ_Kiosk".order_history 
    where empno = ${req.params.empno} and to_date(order_time, 'YYYY-MM-DD') between to_date('${req.params.first_day}','YYYY-MM-DD') and to_date('${req.params.last_day}','YYYY-MM-DD') order by order_number desc`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-09.기간별 사용 내역

app.get("/Search_daily/:select_day", (req, res) => {
  client.query(
    `select  order_list1_name as 상품명, sum(order_list1_each) as 판매수
    from
    (select order_list1_name , order_list1_each 
    from "MZ_Kiosk".order_history as A
    where to_date(order_time, 'YYYY-MM-DD') = '${req.params.select_day}'
    UNION
    select order_list2_name , order_list2_each 
    from "MZ_Kiosk".order_history as B
    where to_date(order_time, 'YYYY-MM-DD') = '${req.params.select_day}'
    union
    select order_list3_name , order_list3_each 
    from "MZ_Kiosk".order_history as C
    where to_date(order_time, 'YYYY-MM-DD') = '${req.params.select_day}'
    union
    select order_list4_name , order_list4_each 
    from "MZ_Kiosk".order_history as D
    where to_date(order_time, 'YYYY-MM-DD') = '${req.params.select_day}'
    union
    select order_list5_name , order_list5_each 
    from "MZ_Kiosk".order_history as E
    where to_date(order_time, 'YYYY-MM-DD') = '${req.params.select_day}'
    union
    select order_list6_name , order_list6_each 
    from "MZ_Kiosk".order_history as F
    where to_date(order_time, 'YYYY-MM-DD') = '${req.params.select_day}'
    union
    select order_list7_name , order_list7_each 
    from "MZ_Kiosk".order_history as G
    where to_date(order_time, 'YYYY-MM-DD') = '${req.params.select_day}'
    union
    select order_list8_name , order_list8_each 
    from "MZ_Kiosk".order_history as H
    where to_date(order_time, 'YYYY-MM-DD') = '${req.params.select_day}'
    union
    select order_list9_name , order_list9_each 
    from "MZ_Kiosk".order_history as I
    where to_date(order_time, 'YYYY-MM-DD') = '${req.params.select_day}'
    union 
    select order_list10_name , order_list10_each 
    from "MZ_Kiosk".order_history as J
    where to_date(order_time, 'YYYY-MM-DD') = '${req.params.select_day}') as daily_sales_list
    group by 상품명
    order by 판매수 desc`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Manager-10.일자별 판매 내역

/*/////////////////////////////////////////////////////////// 매니저용 시안 API 끝 ///////////////////////////////////////////////////////////*/

/*////////////////////////////////////////////////////////// 고객용 시안 API 시작///////////////////////////////////////////////////////////*/

app.get("/Category_list", (req, res) => {
  client.query(
    `select distinct category from "MZ_Kiosk".cafeteria_menu order by category asc`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-00.카테고리 번호 리스트 출력

app.get("/Menulist_coffee", (req, res) => {
  client.query(
    `Select food_id,food_name,category,price,sale_status,discount_available,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,description from "MZ_Kiosk".cafeteria_menu where category = 0\
    order by food_id`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-01_1.메뉴리스트 커피 카테고리 출력 및 //Manager01_1.관리자 상품/재고관리 화면에서도 사용

app.get("/Menulist_milk", (req, res) => {
  client.query(
    `Select food_id,food_name,category,price,sale_status,discount_available,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,description from "MZ_Kiosk".cafeteria_menu where category = 1\
    order by food_id`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-01_2.메뉴리스트 우유 카테고리 출력 및 //Manager01_2.관리자 상품/재고관리 화면에서도 사용

app.get("/Menulist_ade", (req, res) => {
  client.query(
    `Select food_id,food_name,category,price,sale_status,discount_available,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,description from "MZ_Kiosk".cafeteria_menu where category = 2\
    order by food_id`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-01_3.메뉴리스트 에이드 카테고리 출력 및 //Manager01_3.관리자 상품/재고관리 화면에서도 사용

app.get("/Menulist_sparkling_and_juice", (req, res) => {
  client.query(
    `Select food_id,food_name,category,price,sale_status,discount_available,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,description from "MZ_Kiosk".cafeteria_menu where category = 3\
    order by food_id`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-01_4.메뉴리스트 탄산/쥬스 카테고리 출력 및 //Manager01_4.관리자 상품/재고관리 화면에서도 사용

app.get("/Menulist_tea", (req, res) => {
  client.query(
    `Select food_id,food_name,category,price,sale_status,discount_available,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,description from "MZ_Kiosk".cafeteria_menu where category = 4\
    order by food_id`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-01_5.메뉴리스트 차 카테고리 출력 및 //Manager01_5.관리자 상품/재고관리 화면에서도 사용

app.get("/Menulist_ramen", (req, res) => {
  client.query(
    `Select food_id,food_name,category,price,sale_status,discount_available,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,description from "MZ_Kiosk".cafeteria_menu where category = 5\
    order by food_id`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-01_6.메뉴리스트 라면 카테고리 출력 및 //Manager01_6.관리자 상품/재고관리 화면에서도 사용

app.get("/Menulist_rice", (req, res) => {
  client.query(
    `Select food_id,food_name,category,price,sale_status,discount_available,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,description from "MZ_Kiosk".cafeteria_menu where category = 6\
    order by food_id`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-01_7.메뉴리스트 밥 카테고리 출력 및 //Manager01_7.관리자 상품/재고관리 화면에서도 사용

app.get("/Menulist_salad", (req, res) => {
  client.query(
    `Select food_id,food_name,category,price,sale_status,discount_available,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,description from "MZ_Kiosk".cafeteria_menu where category = 7\
    order by food_id`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-01_8.메뉴리스트 샐러드 카테고리 출력 및 //Manager01_8.관리자 상품/재고관리 화면에서도 사용

app.get("/Menulist_bread", (req, res) => {
  client.query(
    `Select food_id,food_name,category,price,sale_status,discount_available,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,description from "MZ_Kiosk".cafeteria_menu where category = 8\
    order by food_id`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-01_9.메뉴리스트 빵 카테고리 출력 및 //Manager01_9.관리자 상품/재고관리 화면에서도 사용
app.get("/Menulist_dessert", (req, res) => {
  client.query(
    `Select food_id,food_name,category,price,sale_status,discount_available,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,description from "MZ_Kiosk".cafeteria_menu where category = 9\
    order by food_id`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-01_10.메뉴리스트 디저트 카테고리 출력 및 //Manager01_10.관리자 상품/재고관리 화면에서도 사용

app.get("/Valid_user/:user_id", (req, res) => {
  let orderNumber = "";
  client.query(
    'select max(order_number) from "MZ_Kiosk".order_history',
    (err, result) => {
      if (!err) {
        orderNumber = result.rows[0].max;
      } else {
        console.log(err.message);
      }
    }
  );

  client.query(
    `select empno,user_id ,ename,team, grade , this_month_usage   from "MZ_Kiosk".user_info where  user_id = '${req.params.user_id}'`,
    (err, result) => {
      if (!err) {
        if (result.rows.length > 0) {
          let user_info = result.rows;
          user_info[0].order_number = orderNumber;
          res.send(user_info);
        } else {
          res.send(result.rows);
        }
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-02.현재 이용중인 사용자 최소 정보 조회(사번,유저id(현재는 qrvalue),사원이름,팀,직책,이달의 지출내역) + 현재 최신 주문번호도 함께 전달

/* app.get('/User_verify/:user_id', (req,res)=>{
    client.query(`select exists (select * from "MZ_Kiosk".user_info where user_id  = '${req.params.user_id}')`, (err,result)=>{
        if(!err){
            res.send(result.rows);
        }else{console.log(err.message)}
    });
    client.end;
})//Customer-02.사용자 인증 ( return true(인증성공)또는 false(인증실패)) */

app.post(
  "/Addorder/:empno/:order_list1_id/:order_list1_each/:order_list1_options/:order_list2_id/:order_list2_each/:order_list2_options/:order_list3_id/:order_list3_each/:order_list3_options/:order_list4_id/:order_list4_each/:order_list4_options/:order_list5_id/:order_list5_each/:order_list5_options/:order_list6_id/:order_list6_each/:order_list6_options/:order_list7_id/:order_list7_each/:order_list7_options/:order_list8_id/:order_list8_each/:order_list8_options/:order_list9_id/:order_list9_each/:order_list9_options/:order_list10_id/:order_list10_each/:order_list10_options",
  (req, res) => {
    const d = dayjs();
    let insertQuery = `insert into "MZ_Kiosk".order_history (order_number,order_time,empno,ename,team,grade,order_status,total_price,order_List1_name,order_List1_each,order_List1_options,order_List2_name,order_List2_each,order_List2_options,order_List3_name,order_List3_each,order_List3_options,order_List4_name,order_List4_each,order_List4_options,order_List5_name,order_List5_each,order_List5_options,order_List6_name,order_List6_each,order_List6_options,order_List7_name,order_List7_each,order_List7_options,order_List8_name,order_List8_each,order_List8_options,order_List9_name,order_List9_each,order_List9_options,order_List10_name,order_List10_each,order_List10_options,total_order_list)\
    values(default,'${d.format("YYYY-MM-DD HH:mm:ss")}', ${
      req.params.empno
    },(select ename from "MZ_Kiosk".user_info where empno = ${
      req.params.empno
    }),\
    (select  team  from "MZ_Kiosk".user_info where empno = ${
      req.params.empno
    }),(select  grade  from "MZ_Kiosk".user_info where empno = ${
      req.params.empno
    }),0,
    (select (select price from "MZ_Kiosk".cafeteria_menu where food_id = ${
      req.params.order_list1_id
    }) * ${req.params.order_list1_each} \
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${
      req.params.order_list2_id
    }) * ${req.params.order_list2_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${
      req.params.order_list3_id
    }) * ${req.params.order_list3_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${
      req.params.order_list4_id
    }) * ${req.params.order_list4_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${
      req.params.order_list5_id
    }) * ${req.params.order_list5_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${
      req.params.order_list6_id
    }) * ${req.params.order_list6_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${
      req.params.order_list7_id
    }) * ${req.params.order_list7_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${
      req.params.order_list8_id
    }) * ${req.params.order_list8_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${
      req.params.order_list9_id
    }) * ${req.params.order_list9_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${
      req.params.order_list10_id
    }) * ${req.params.order_list10_each}), 
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
      req.params.order_list1_id
    }),
    ${req.params.order_list1_each},
    '${req.params.order_list1_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
      req.params.order_list2_id
    }),
    ${req.params.order_list2_each},
    '${req.params.order_list2_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
      req.params.order_list3_id
    }),
    ${req.params.order_list3_each},
    '${req.params.order_list3_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
      req.params.order_list4_id
    }),
    ${req.params.order_list4_each},
    '${req.params.order_list4_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
      req.params.order_list5_id
    }),
    ${req.params.order_list5_each},
    '${req.params.order_list5_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
      req.params.order_list6_id
    }),
    ${req.params.order_list6_each},
    '${req.params.order_list6_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
      req.params.order_list7_id
    }),
    ${req.params.order_list7_each},
    '${req.params.order_list7_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
      req.params.order_list8_id
    }),
    ${req.params.order_list8_each},
    '${req.params.order_list8_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
      req.params.order_list9_id
    }),
    ${req.params.order_list9_each},
    '${req.params.order_list9_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
      req.params.order_list10_id
    }),
    ${req.params.order_list10_each},
    '${req.params.order_list10_options}',
    (select concat(   
        (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
          req.params.order_list1_id
        }) ,E'\t','${req.params.order_list1_options}' ,E'\t', ${
      req.params.order_list1_each
    } ,E'\t',
        (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
          req.params.order_list2_id
        }) ,E'\t','${req.params.order_list2_options}' ,E'\t',  ${
      req.params.order_list2_each
    } ,E'\t',
        (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
          req.params.order_list3_id
        }) ,E'\t','${req.params.order_list3_options}' ,E'\t', ${
      req.params.order_list3_each
    } ,E'\t',
        (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
          req.params.order_list4_id
        }) ,E'\t','${req.params.order_list4_options}' ,E'\t', ${
      req.params.order_list4_each
    } ,E'\t',
        (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
          req.params.order_list5_id
        }) ,E'\t','${req.params.order_list5_options}' ,E'\t', ${
      req.params.order_list5_each
    } ,E'\t',
        (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
          req.params.order_list6_id
        }) ,E'\t','${req.params.order_list6_options}' ,E'\t', ${
      req.params.order_list6_each
    } ,E'\t',
        (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
          req.params.order_list7_id
        }) ,E'\t','${req.params.order_list7_options}' ,E'\t', ${
      req.params.order_list7_each
    } ,E'\t',
        (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
          req.params.order_list8_id
        }) ,E'\t','${req.params.order_list8_options}' ,E'\t', ${
      req.params.order_list8_each
    } ,E'\t',
        (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
          req.params.order_list9_id
        }) ,E'\t','${req.params.order_list9_options}' ,E'\t', ${
      req.params.order_list9_each
    } ,E'\t',
        (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${
          req.params.order_list10_id
        }),E'\t','${req.params.order_list10_options}',E'\t', ${
      req.params.order_list10_each
    } ,E'\t'))
    )`;

    client.query(insertQuery, (err, result) => {
      if (!err) {
        // Spend Update
        let updateQuery = `update "MZ_Kiosk".user_info
                set total_usage =  total_usage + (select total_price from "MZ_Kiosk".order_history where order_number = (select max(order_number) from "MZ_Kiosk".order_history where empno =${req.params.empno} )),
                this_month_usage =  this_month_usage + (select total_price from "MZ_Kiosk".order_history where order_number = (select max(order_number) from "MZ_Kiosk".order_history where empno =${req.params.empno} )),
                number_of_orders = number_of_orders + 1
                where empno = ${req.params.empno}`;

        client.query(updateQuery, (err, result) => {
          if (!err) {
            // Notify to Manager
            const message = {
              type: "kiosk",
              content: "GetNewOrder",
            };
            wss.clients.forEach((client) => {
              if (client.readyState === WebSocket.OPEN) {
                client.send(JSON.stringify(message));
                res.send("Addorder 및 WS 성공");
              }
            });
          } else {
            console.log(err.message);
          }
        });
      } else {
        console.log(err.message);
      }
    });
    client.end;
  }
); //Customer-03.주문리스트 생성

/* 230827 Hongkeun.Park 하기 API는 사용하지 않고 Addorder 에서 한번에 처리하도록 수정 */
app.put("/Spend_update/:empno", (req, res) => {
  let updateQuery = `update "MZ_Kiosk".user_info
    set total_usage =  total_usage + (select total_price from "MZ_Kiosk".order_history where order_number = (select max(order_number) from "MZ_Kiosk".order_history where empno =${req.params.empno} )),
  this_month_usage =  this_month_usage + (select total_price from "MZ_Kiosk".order_history where order_number = (select max(order_number) from "MZ_Kiosk".order_history where empno =${req.params.empno} )),
  number_of_orders = number_of_orders + 1
  where empno = ${req.params.empno}`;

  client.query(updateQuery, (err, result) => {
    if (!err) {
      res.send("수정 성공");
    } else {
      console.log(err.message);
    }
  });
  client.end;
}); //Customer-04.유저정보데이터에 지출내역 업데이트 (주문리스트 생성 직후 곧장 수행되어야 함)

app.get("/User_month_usage/:empno", (req, res) => {
  client.query(
    `select this_month_usage from "MZ_Kiosk".user_info where empno = ${req.params.empno}`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-05.주문 완료된 고객에게 월 누적 사용 내역 노출 조회.

/* 230826 Hongkeun.Park 하기 API는 사용하지 않고 Valid_user 에서 한번에 처리하도록 수정 */
app.get("/Last_ordernumber", (req, res) => {
  client.query(
    'select max(order_number) from "MZ_Kiosk".order_history',
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Customer-06.주문 완료 됐을 때의 해당 주문 번호 출력. (주문리스트의 가장 최근 번호 max값으로 호출)

//////////////////////////////////////////////////////////// 고객용 시안 API 끝////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////// 그 외 필수 API 시작////////////////////////////////////////////////////////////

app.put("/Usage_reset", (req, res) => {
  let updateQuery = `update 
	"MZ_Kiosk".user_info 
	set
	swap_usage = last_month_usage,
	last_month_usage = this_month_usage,
	this_month_usage  = 0,
	number_of_orders = 0
	where
	(select to_date(now()::varchar, 'YYYY-MM-DD') as today) = (select date_trunc('month', current_date)::date "첫날")`;
  //당일 날짜로 테스트 해보고 싶으면 우변을 (select to_date(now()::varchar, 'YYYY-MM-DD') as today)로 바꿔서 해보기!
  client.query(updateQuery, (err, result) => {
    if (!err) {
      res.send("성공!");
    } else {
      console.log(err.message);
    }
  });
  client.end;
}); //Backend-01.매달 1일이 되면 전 사원 지출 내역을 초기화 처리.

app.post(
  "/Createuser/:user_id/:empno/:id_type/:ename/:grade/:team",
  (req, res) => {
    const body = req.body;
    const inputEmpno = req.params.empno;

    const result = encryption.hash(inputEmpno);
    console.log(result);

    let insertQuery = `insert into "MZ_Kiosk".User_Info(user_id,empno,id_type,ename,grade,team) \
    values('${result}',${req.params.empno},'${req.params.id_type}','${req.params.ename}','${req.params.grade}','${req.params.team}') `;

    client.query(insertQuery, (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    });
    client.end;
  }
); //Backend-02.사원 등록

app.get("/Menulist_all", (req, res) => {
  client.query(
    `Select food_id,food_name,category,price,sale_status,discount_available,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,description from "MZ_Kiosk".cafeteria_menu order by category,food_id`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Backend-03.메뉴리스트 모든 카테고리의 내용 출력

app.get("/Employee_list", (req, res) => {
  client.query(`Select * from "MZ_Kiosk".User_Info`, (err, result) => {
    if (!err) {
      res.send(result.rows);
    } else {
      console.log(err.message);
    }
  });
  client.end;
}); //Backend-04.직원 전체 리스트

app.get("/Find_id/:food_name", (req, res) => {
  client.query(
    `Select food_id from "MZ_Kiosk".cafeteria_menu where food_name = '${req.params.food_name}'`,
    (err, result) => {
      if (!err) {
        res.send(result.rows);
      } else {
        console.log(err.message);
      }
    }
  );
  client.end;
}); //Backend-04.상품의 id값 출력

/*app.post('/Addorder/:empno/:order_list1_id/:order_list1_each/:order_list1_options/:order_list2_id/:order_list2_each/:order_list2_options/:order_list3_id/:order_list3_each/:order_list3_options/:order_list4_id/:order_list4_each/:order_list4_options/:order_list5_id/:order_list5_each/:order_list5_options/:order_list6_id/:order_list6_each/:order_list6_options/:order_list7_id/:order_list7_each/:order_list7_options/:order_list8_id/:order_list8_each/:order_list8_options/:order_list9_id/:order_list9_each/:order_list9_options/:order_list10_id/:order_list10_each/:order_list10_options',
 (req,res)=>{
    const d = dayjs();
    let insertQuery = `insert into "MZ_Kiosk".order_history (order_number,order_time,empno,ename,team,grade,order_status,total_price,order_List1_name,order_List1_each,order_List1_options,order_List2_name,order_List2_each,order_List2_options,order_List3_name,order_List3_each,order_List3_options,order_List4_name,order_List4_each,order_List4_options,order_List5_name,order_List5_each,order_List5_options,order_List6_name,order_List6_each,order_List6_options,order_List7_name,order_List7_each,order_List7_options,order_List8_name,order_List8_each,order_List8_options,order_List9_name,order_List9_each,order_List9_options,order_List10_name,order_List10_each,order_List10_options,total_order_list)\
    values(default,'${d.format('YYYY-MM-DD HH:mm:ss')}', ${req.params.empno},(select ename from "MZ_Kiosk".user_info where empno = ${req.params.empno}),\
    (select  team  from "MZ_Kiosk".user_info where empno = ${req.params.empno}),(select  grade  from "MZ_Kiosk".user_info where empno = ${req.params.empno}),0,
    (select (select price from "MZ_Kiosk".cafeteria_menu where food_id = ${req.params.order_list1_id}) * ${req.params.order_list1_each} \
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${req.params.order_list2_id}) * ${req.params.order_list2_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${req.params.order_list3_id}) * ${req.params.order_list3_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${req.params.order_list4_id}) * ${req.params.order_list4_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${req.params.order_list5_id}) * ${req.params.order_list5_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${req.params.order_list6_id}) * ${req.params.order_list6_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${req.params.order_list7_id}) * ${req.params.order_list7_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${req.params.order_list8_id}) * ${req.params.order_list8_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${req.params.order_list9_id}) * ${req.params.order_list9_each}\
    +(select price from "MZ_Kiosk".cafeteria_menu where food_id = ${req.params.order_list10_id}) * ${req.params.order_list10_each}),
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list1_id}),
    ${req.params.order_list1_each},
    '${req.params.order_list1_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list2_id}),
    ${req.params.order_list2_each},
    '${req.params.order_list2_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list3_id}),
    ${req.params.order_list3_each},
    '${req.params.order_list3_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list4_id}),
    ${req.params.order_list4_each},
    '${req.params.order_list4_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list5_id}),
    ${req.params.order_list5_each},
    '${req.params.order_list5_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list6_id}),
    ${req.params.order_list6_each},
    '${req.params.order_list6_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list7_id}),
    ${req.params.order_list7_each},
    '${req.params.order_list7_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list8_id}),
    ${req.params.order_list8_each},
    '${req.params.order_list8_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list9_id}),
    ${req.params.order_list9_each},
    '${req.params.order_list9_options}',
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list10_id}),
    ${req.params.order_list10_each},
    '${req.params.order_list10_options}',
    (select concat(
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list1_id}) , '(' , '${req.params.order_list1_options}' ,')', E'\t\t\t\t' , ${req.params.order_list1_each} ,E'\t\t', E'\n' ,
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list2_id}) , '(' , '${req.params.order_list2_options}' ,')', E'\t\t\t\t' , ${req.params.order_list2_each} ,E'\t\t', E'\n' ,
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list3_id}) , '(' , '${req.params.order_list3_options}' ,')', E'\t\t\t\t' , ${req.params.order_list3_each} ,E'\t\t', E'\n' ,
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list4_id}) , '(' , '${req.params.order_list4_options}' ,')', E'\t\t\t\t' , ${req.params.order_list4_each} ,E'\t\t', E'\n' ,
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list5_id}) , '(' , '${req.params.order_list5_options}' ,')', E'\t\t\t\t' , ${req.params.order_list5_each} ,E'\t\t', E'\n' ,
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list6_id}) , '(' , '${req.params.order_list6_options}' ,')', E'\t\t\t\t' , ${req.params.order_list6_each} ,E'\t\t', E'\n' ,
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list7_id}) , '(' , '${req.params.order_list7_options}' ,')', E'\t\t\t\t' , ${req.params.order_list7_each} ,E'\t\t', E'\n' ,
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list8_id}) , '(' , '${req.params.order_list8_options}' ,')', E'\t\t\t\t' , ${req.params.order_list8_each} ,E'\t\t', E'\n' ,
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list9_id}) , '(' , '${req.params.order_list9_options}' ,')', E'\t\t\t\t' , ${req.params.order_list9_each} ,E'\t\t', E'\n' ,
    (select food_name from "MZ_Kiosk".cafeteria_menu where food_id =${req.params.order_list10_id}) , '(' , '${req.params.order_list10_options}' ,')', E'\t\t\t\t' , ${req.params.order_list10_each} ,E'\t\t', E'\n'))
    )`


    client.query(insertQuery,(err,result)=>{
        if(!err){
            res.send('성공!!!!')
        }
        else{console.log(err.message)}
    })
    client.end;
})//주문리스트 생성 (temp)*/

/* client.query("select encode(digest('abcd', 'sha256'), 'hex');", (err, res) => {
    console.log(err, res);
    client.end();
  }); */

//////////////////////////////////////////////////////////// 그 외 필수 API 끝////////////////////////////////////////////////////////////
