<template>
  <div style="margin-bottom: 100px">
    <div class="container mt-3" style="height: 600px">
      <div class="map_wrap">
        <div id="map" class="map mb-3"></div>
        <ul id="category">
          <li id="BK9" data-order="0">
            <span class="category_bg bank"></span>
            은행
          </li>
          <li id="MT1" data-order="1">
            <span class="category_bg mart"></span>
            마트
          </li>
          <li id="PM9" data-order="2">
            <span class="category_bg pharmacy"></span>
            약국
          </li>
          <li id="OL7" data-order="3">
            <span class="category_bg oil"></span>
            주유소
          </li>
          <li id="CE7" data-order="4">
            <span class="category_bg cafe"></span>
            카페
          </li>
          <li id="CS2" data-order="5">
            <span class="category_bg store"></span>
            편의점
          </li>
        </ul>
      </div>
      <table class="table" style="margin-top: 60px">
        <thead>
          <tr>
            <th>아파트 이름</th>
            <th>높이</th>
            <th>전용면적</th>
            <th>거래금액</th>
            <th>건축년도</th>
            <!-- <th>로드뷰보기</th> -->
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>{{ aptdata.아파트 }}</td>
            <td>{{ aptdata.층 }}</td>
            <td>{{ aptdata.전용면적 }}</td>
            <td>{{ aptdata.거래금액 }}</td>
            <td>{{ aptdata.건축년도 }}</td>
            <!-- <td>로드뷰 연결하거나 다른버튼</td> -->
          </tr>
        </tbody>
      </table>
      <!-- <h3>2KM 내 상가/편의시설 정보</h3> -->
      <table class="table">
        <thead>
          <tr>
            <th>은행</th>
            <th>마트</th>
            <th>약국</th>
            <th>주유소</th>
            <th>카페</th>
            <th>편의점</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>{{ this.categorycount[0] }}</td>
            <td>{{ this.categorycount[1] }}</td>
            <td>{{ this.categorycount[2] }}</td>
            <td>{{ this.categorycount[3] }}</td>
            <td>{{ this.categorycount[4] }}</td>
            <td>{{ this.categorycount[5] }}</td>
          </tr>
        </tbody>
      </table>
      <b-button @click="back">뒤로가기</b-button>
    </div>
  </div>
</template>
<script>
    import { Button, FormGroupInput } from "@/components";
    import axios from "axios";
    export default {
        name: "landing",
        bodyClass: "landing-page",
        components: {
            [Button.name]: Button,
            [FormGroupInput.name]: FormGroupInput,
        },
        data() {
            return {
                categoryList: ["BK9", "MT1", "PM9", "OL7", "CE7", "CS2"],
                categorycount: [],
            };
        },
        props: {
            aptdata: Object,
            gugun_name: String,
        },
        mounted() {
            console.log("디테일 들어옴 + aptinfo");
            console.log(this.aptdata);
            window.kakao && window.kakao.maps ? this.initMap() : this.addKakaoMapScript();
        },
        created() {
            var address = this.gugun_name + " " + this.aptdata.법정동 + " " + this.aptdata.지번;
            console.log(address);
            var url = "https://dapi.kakao.com/v2/local/search/address.json?&query=" + address;
            axios
                .get(url, {
                    headers: {
                        Authorization: " KakaoAK 5d8e87ef95d095e377b5dfdcfadfac18",
                    },
                })
                .then((response) => {
                    console.log("rest API 테스트 then");
                    console.log(response.data.documents[0].y);
                    console.log(response.data.documents[0].x);
                    for (var i = 0; i < this.categoryList.length; i++) {
                        console.log(this.categoryList[i]);
                        var add2 =
                            "https://dapi.kakao.com/v2/local/search/category.json?category_group_code=" +
                            this.categoryList[i] +
                            "&sort=distance&y=" +
                            response.data.documents[0].y +
                            "&x=" +
                            response.data.documents[0].x +
                            "&radius=2000";
                        axios
                            .get(add2, {
                                headers: {
                                    Authorization: " KakaoAK 5d8e87ef95d095e377b5dfdcfadfac18",
                                },
                            })
                            .then((response) => {
                                console.log("카테고리 개수얻어오기");
                                //console.log(response.data.meta.total_count);
                                //console.log(response.data);
                                this.categorycount.push(response.data.meta.total_count);
                            })
                            .catch((Error) => {
                                console.log(Error);
                            });
                    }
                })
                .catch((Error) => {
                    console.log(Error);
                });
        },
        methods: {
            back() {
                this.$emit("back", "");
            },
            addKakaoMapScript() {
                const script = document.createElement("script");
                script.onload = () => kakao.maps.load(this.initMap);
                script.src = "http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=b7c5cb9042af5754b5af32fa54b1a96e&libraries=services";
                document.head.appendChild(script);
            },
            initMap() {
                let _this = this;
                // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
                var placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 }),
                    contentNode = document.createElement("div"), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
                    markers = [], // 마커를 담을 배열입니다
                    currCategory = ""; // 현재 선택된 카테고리를 가지고 있을 변수입니다

                var mapContainer = document.getElementById("map"), // 지도를 표시할 div
                    mapOption = {
                        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                        level: 3, // 지도의 확대 레벨
                    };

                // 지도를 생성합니다
                var map = new kakao.maps.Map(mapContainer, mapOption);

                // 주소-좌표 변환 객체를 생성합니다
                var geocoder = new kakao.maps.services.Geocoder();

                var address = this.gugun_name + " " + this.aptdata.법정동 + " " + this.aptdata.지번;
                var aptname = this.aptdata.아파트;
                console.log(address);
                // 주소로 좌표를 검색합니다
                geocoder.addressSearch(address, function (result, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === kakao.maps.services.Status.OK) {
                        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                        // 결과값으로 받은 위치를 마커로 표시합니다
                        var marker = new kakao.maps.Marker({
                            map: map,
                            position: coords,
                        });

                        // 인포윈도우로 장소에 대한 설명을 표시합니다
                        var infowindow = new kakao.maps.InfoWindow({
                            content: aptname,
                        });
                        infowindow.open(map, marker);

                        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                        map.setCenter(coords);
                    }
                });
                // 장소 검색 객체를 생성합니다
                var ps = new kakao.maps.services.Places(map);

                // 지도에 idle 이벤트를 등록합니다
                kakao.maps.event.addListener(map, "idle", searchPlaces);

                // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다
                contentNode.className = "placeinfo_wrap";

                // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
                // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다
                addEventHandle(contentNode, "mousedown", kakao.maps.event.preventMap);
                addEventHandle(contentNode, "touchstart", kakao.maps.event.preventMap);

                // 커스텀 오버레이 컨텐츠를 설정합니다
                placeOverlay.setContent(contentNode);

                // 각 카테고리에 클릭 이벤트를 등록합니다
                addCategoryClickEvent();

                // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
                function addEventHandle(target, type, callback) {
                    if (target.addEventListener) {
                        target.addEventListener(type, callback);
                    } else {
                        target.attachEvent("on" + type, callback);
                    }
                }

                // 카테고리 검색을 요청하는 함수입니다
                function searchPlaces() {
                    if (!currCategory) {
                        return;
                    }
                    console.log("카테고리 선택");
                    console.log(currCategory);
                    // 커스텀 오버레이를 숨깁니다
                    placeOverlay.setMap(null);

                    // 다른 카테고리를 클릭했을때 지도에 있는 모든 카테고리를 지운다.
                    // 지도에 표시되고 있는 마커를 제거합니다

                    ps.categorySearch(currCategory, placesSearchCB, { useMapBounds: true });
                }

                // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
                function placesSearchCB(data, status, pagination) {
                    if (status === kakao.maps.services.Status.OK) {
                        // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
                        displayPlaces(data);
                    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                        // 결과가 없는 경우 해야할 처리가 있다면 이곳에 작성해 주세요.
                    } else if (status === kakao.maps.services.Status.ERROR) {
                        // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
                    }
                }

                // 지도에 마커를 표출하는 함수입니다
                function displayPlaces(places) {
                    // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
                    // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
                    var order = document.getElementById(currCategory).getAttribute("data-order");
                    console.log("오더가 뭐냐");
                    console.log(_this.categorycount[0]);
                    for (var i = 0; i < places.length; i++) {
                        // 마커를 생성하고 지도에 표시합니다
                        var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

                        // 마커와 검색결과 항목을 클릭 했을 때
                        // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
                        (function (marker, place) {
                            kakao.maps.event.addListener(marker, "click", function () {
                                displayPlaceInfo(place);
                            });
                        })(marker, places[i]);
                    }
                }

                // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
                function addMarker(position, order) {
                    var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
                        imageSize = new kakao.maps.Size(27, 28), // 마커 이미지의 크기
                        imgOptions = {
                            spriteSize: new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
                            spriteOrigin: new kakao.maps.Point(46, order * 36), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                            offset: new kakao.maps.Point(11, 28), // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                        },
                        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                        marker = new kakao.maps.Marker({
                            position: position, // 마커의 위치
                            image: markerImage,
                        });

                    marker.setMap(map); // 지도 위에 마커를 표출합니다
                    markers.push({ id: currCategory, marker: marker }); // 배열에 생성된 마커를 추가합니다

                    return marker;
                }

                // 지도 위에 표시되고 있는 마커를 모두 제거합니다
                function removeMarker() {
                    console.log("삭제함수 인");
                    console.log(markers);
                    console.log(currCategory);
                    for (var i = markers.length - 1; i >= 0; i--) {
                        if (markers[i].id == currCategory) {
                            markers[i].marker.setMap(null);
                            markers.splice(i, 1);
                        }
                    }
                    console.log("남은 마커");
                    console.log(markers);
                }

                // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
                function displayPlaceInfo(place) {
                    var content =
                        '<div class="placeinfo">' +
                        '   <a class="title" href="' +
                        place.place_url +
                        '" target="_blank" title="' +
                        place.place_name +
                        '">' +
                        place.place_name +
                        "</a>";

                    if (place.road_address_name) {
                        content +=
                            '    <span title="' +
                            place.road_address_name +
                            '">' +
                            place.road_address_name +
                            "</span>" +
                            '  <span class="jibun" title="' +
                            place.address_name +
                            '">(지번 : ' +
                            place.address_name +
                            ")</span>";
                    } else {
                        content += '    <span title="' + place.address_name + '">' + place.address_name + "</span>";
                    }

                    content += '    <span class="tel">' + place.phone + "</span>" + "</div>" + '<div class="after"></div>';

                    contentNode.innerHTML = content;
                    placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
                    placeOverlay.setMap(map);
                }

                // 각 카테고리에 클릭 이벤트를 등록합니다
                function addCategoryClickEvent() {
                    var category = document.getElementById("category"),
                        children = category.children;

                    for (var i = 0; i < children.length; i++) {
                        children[i].onclick = onClickCategory;
                    }
                }

                // 카테고리를 클릭했을 때 호출되는 함수입니다
                function onClickCategory() {
                    var id = this.id,
                        className = this.className;

                    placeOverlay.setMap(null);
                    currCategory = id;
                    // 지금 카테고리가 켜저있으면
                    if (className === "on") {
                        changeCategoryClass(this);
                        // 같은 카테고리를 선택했을때 마커를 지워준다.
                        removeMarker();
                        currCategory = "";
                    }
                    // 지금 카테고리가 꺼져있으면.
                    else {
                        changeCategoryClass(this);
                        searchPlaces();
                    }
                }

                // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
                function changeCategoryClass(el) {
                    if (el.className == "on") {
                        el.className = "";
                    } else {
                        el.className = "on";
                    }
                }
            },
        },
    };
</script>
<style>
.map {
  width: 100%;
  height: 400px;
}
.map_wrap,
.map_wrap * {
  margin: 20;
  padding: 0;
  font-family: "Malgun Gothic", dotum, "돋움", sans-serif;
  font-size: 12px;
}
.map_wrap {
  position: relative;
  width: 100%;
  height: 350px;
}
#category {
  position: absolute;
  top: 10px;
  left: 10px;
  border-radius: 5px;
  border: 1px solid #909090;
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
  background: #fff;
  overflow: hidden;
  z-index: 2;
}
#category li {
  float: left;
  list-style: none;
  width: 50px;
  border-right: 1px solid #acacac;
  padding: 6px 0;
  text-align: center;
  cursor: pointer;
}
#category li.on {
  background: #eee;
}
#category li:hover {
  background: #ffe6e6;
  border-left: 1px solid #acacac;
  margin-left: -1px;
}
#category li:last-child {
  margin-right: 0;
  border-right: 0;
}
#category li span {
  display: block;
  margin: 0 auto 3px;
  width: 27px;
  height: 28px;
}
#category li .category_bg {
  background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png)
    no-repeat;
}
#category li .bank {
  background-position: -10px 0;
}
#category li .mart {
  background-position: -10px -36px;
}
#category li .pharmacy {
  background-position: -10px -72px;
}
#category li .oil {
  background-position: -10px -108px;
}
#category li .cafe {
  background-position: -10px -144px;
}
#category li .store {
  background-position: -10px -180px;
}
#category li.on .category_bg {
  background-position-x: -46px;
}
.placeinfo_wrap {
  position: absolute;
  bottom: 28px;
  left: -150px;
  width: 300px;
}
.placeinfo {
  position: relative;
  width: 100%;
  border-radius: 6px;
  border: 1px solid #ccc;
  border-bottom: 2px solid #ddd;
  padding-bottom: 10px;
  background: #fff;
}
.placeinfo:nth-of-type(n) {
  border: 0;
  box-shadow: 0px 1px 2px #888;
}
.placeinfo_wrap .after {
  content: "";
  position: relative;
  margin-left: -12px;
  left: 50%;
  width: 22px;
  height: 12px;
  background: url("https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png");
}
.placeinfo a,
.placeinfo a:hover,
.placeinfo a:active {
  color: #fff;
  text-decoration: none;
}
.placeinfo a,
.placeinfo span {
  display: block;
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
}
.placeinfo span {
  margin: 5px 5px 0 5px;
  cursor: default;
  font-size: 13px;
}
.placeinfo .title {
  font-weight: bold;
  font-size: 14px;
  border-radius: 6px 6px 0 0;
  margin: -1px -1px 0 -1px;
  padding: 10px;
  color: #fff;
  background: #d95050;
  background: #d95050
    url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
    no-repeat right 14px center;
}
.placeinfo .tel {
  color: #0f7833;
}
.placeinfo .jibun {
  color: #999;
  font-size: 11px;
  margin-top: 0;
}
</style>
