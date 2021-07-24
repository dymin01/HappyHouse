<template>
  <div>
    <div class="page-header clear-filter" filter-color>
      <parallax class="page-header-image" style="background-image: url('img/header.jpg')"></parallax>
      <div class="container">
        <div class="content-center brand">
          <img class="n-logo" src="img/now-logo.png" alt />
          <h1 class="h1-seo">HAPPY HOUSE</h1>
          <h3>나의 행복한 집 찾기</h3>
          <!-- 로그인 되어있을때만 나타내야함. -->
        </div>
      </div>
    </div>
    <div v-if="sessionUser == null" class="section">
      <div class="container text-center">
        <h4>
          <a href @click="$router.push('/login')">로그인</a> 후, 관심지역에 대한 정보를 얻어보세요
        </h4>
      </div>
    </div>
    <div v-else-if="favoriteAreas.length == 0" class="section">
      <div class="container text-center">
        <h4>
          <a href @click="$router.push('/profile')">마이페이지</a>에서 관심지역을 추가해보세요
        </h4>
      </div>
    </div>
    <div class="section">
      <div class="container">
        <div class="row"></div>
        <favorite-area
          :favoriteAreas="favoriteAreas"
          :covidCount="covidCount"
          v-if="areaOK && covidOK"
        ></favorite-area>
      </div>
    </div>
  </div>
</template>
<script>
    import { Parallax } from "@/components";
    import FavoriteArea from "./FavoriteArea.vue";
    import axios from "axios";
    import http from "@/http-common_map.js";
    export default {
        name: "index",
        bodyClass: "index-page",
        components: {
            Parallax,
            FavoriteArea,
        },
        data() {
            return {
                sessionUser: "",
                favoriteAreas: [
                    {
                        user_idx: "",
                        guguncode: "",
                        gugunname: "",
                        dongname: "",
                    },
                ],
                covid: [],
                covidOK: false,
                areaOK: false,
                covidCount: [0, 0, 0],
            };
        },
        created() {
            this.covidCount = [0, 0, 0];
            this.sessionUser = JSON.parse(sessionStorage.getItem("userinfo"));
            console.log(JSON.parse(sessionStorage.getItem("userinfo")));
            if (this.sessionUser != "" && this.sessionUser != null) {
                http.get(`/user/area/list/${this.sessionUser.user_idx}`)
                    .then(({ data }) => {
                        console.log("관심지역 정보를 가져왔습니다.");
                        this.favoriteAreas = data;
                        console.log(this.favoriteAreas);
                    })
                    .catch(() => {
                        //alert("에러가 발생했습니다.");
                    })
                    .finally(() => {
                        console.log("관심지역 파이널입니다.");
                        this.areaOK = true;
                    });
                // 코로나 진료소, 병원 전부를 가져온다.
                axios
                    .get(
                        "http://apis.data.go.kr/B551182/pubReliefHospService/getpubReliefHospList?ServiceKey=DK8KcTemKVSqu1vOCqowaxNH5hH8TxfvO4cvmO4HdSYixe6hiu6Q%2FO9OMVmCvL4oV52lUUZVVhH4caJqiZW6hQ%3D%3D&pageNo=1&numOfRows=1050"
                    )
                    .then((response) => {
                        console.log("코로나 진료가능 장소 얻어왔다.");
                        // console.log(response);
                        this.covid = response.data.response.body.items.item;
                        console.log(this.covid);
                        // 관심지역별 코로나 진료소 갯수 넣기.
                    })
                    .catch((ERROR) => {
                        console.log(ERROR);
                    })
                    .finally(() => {
                        console.log("코로나 파이널입니다.");
                        console.log("진료소 개수 카운트 합니다");
                        this.covid.forEach((data) => {
                            if (
                                this.favoriteAreas[0].user_idx != "" &&
                                this.favoriteAreas.length >= 1 &&
                                data.sgguNm == this.favoriteAreas[0].gugunname
                            ) {
                                this.covidCount[0]++;
                            }
                            if (this.favoriteAreas.length >= 2 && data.sgguNm == this.favoriteAreas[1].gugunname) {
                                this.covidCount[1]++;
                            }
                            if (this.favoriteAreas.length >= 3 && data.sgguNm == this.favoriteAreas[2].gugunname) {
                                this.covidCount[2]++;
                            }
                        });
                        console.log(this.covidCount);

                        this.covidOK = true;
                    });
                console.log("크리에이트가 끝났어요");
            }
        },
    };
</script>
<style></style>
