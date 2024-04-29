const api_query = {
  CATEGORY_LIST: {
    api: '/Category_list',
    query: `select distinct category from "MZ_Kiosk".cafeteria_menu order by category asc;`,
  }, //단순 카테고리 번호 출력 (오름차순)
  MENU_ALL: {
    api: '/Menulist_all',
    query: `Select food_id,food_api,category,price,sale_status,discount_available,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,regexp_replace(encode(image_path, 'base64'), '[\n\r]+', ' ', 'g' ) as image_path,description from "MZ_Kiosk".cafeteria_menu order by category,food_id`
  }, // 모든 메뉴 조회
  MENU_ALL_OPT: {
    api: '/Menulist_all_options',
    query: `Select * from "MZ_Kiosk".cafeteria_menu`,
  }, // 모든 메뉴의 모든 옵션들까지 조회
  MENU_COF: {
    api: '/Menulist_coffee',
    query: ''
  },// 커피 카테고리 메뉴 조회
  MENU_MLK: {
    api: '/Menulist_milk',
    query: ''
  },// 우유 카테고리 메뉴 조회
  MENU_ADE: {
    api: '/Menulist_ade',
    query: ''
  },// 에이드 카테고리 메뉴 조회
  MENU_SAJ: {
    api: '/Menulist_sparkling_and_juice',
    query: ''
  },// 탄산/쥬스 카테고리 출력
  MENU_TEA: {
    api: '/Menulist_tea',
    query: ''
  },// 차 카테고리 출력
  MENU_RMN: {
    api: '/Menulist_ramen',
    query: ''
  },// 라면 카테고리 출력

  MENU_RCE: {
    api: '/Menulist_rice',
    query: ''
  },// 밥 카테고리 출력
  MENU_SLD: {
    api: '/Menulist_salad',
    query: ''
  },// 샐러드 카테고리 출력
  MENU_BRD: {
    api: '/Menulist_bread',
    query: ''
  },// 빵 카테고리 출력
  MENU_DRT: {
    api: '/Menulist_dessert',
    query: ''
  },//주전부리(디저트) 카테고리 출력
  MEMBER_ADD: {
    api: '/CreateUser/:user_id/:empno/:id_type/:ename/:grade/:team',
    query: ''
  },//사원 등록 
  PROD_ADD: {
    api: '/Add_product/:food_name/:category/:price/:discount_available',
    query: ''
  },//상품 등록
  ORDER_ADD: {
    api: '/AddOrder/:empno/:order_list1_id/:order_list1_each/:order_list1_options/:order_list2_id/:order_list2_each/:order_list2_options/:order_list3_id/:order_list3_each/:order_list3_options/:order_list4_id/:order_list4_each/:order_list4_options/:order_list5_id/:order_list5_each/:order_list5_options/:order_list6_id/:order_list6_each/:order_list6_options/:order_list7_id/:order_list7_each/:order_list7_options/:order_list8_id/:order_list8_each/:order_list8_options/:order_list9_id/:order_list9_each/:order_list9_options/:order_list10_id/:order_list10_each/:order_list10_options',
    query: ''
  },//주문 등록(주문 리스트 생성)  
  USER_VERIFY: {
    api: '/User_verify/:user_id',
    query: ''
  },//사용자 인증
  SPEND_UPDATE: {
    api: '/Spend_update/:empno',
    query: ''
  },//사용자 인증
  USAGE_RESET: {
    api: '/Usage_reset',
    query: ''
  },//매달 1일 전 사원 지출 내역 초기화
  TEAMS: {
    api: '/Teams',
    query: ''
  },//
}

module.exports = { api_query }