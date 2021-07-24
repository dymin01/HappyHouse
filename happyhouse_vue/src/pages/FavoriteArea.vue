<template>
  <div>
    <div class="col-md-6 ml-auto mr-auto">
      <h3 style v-if="favoriteAreas.length >= 1 && favoriteAreas[0].user_idx != ''">관심지역 정보</h3>
    </div>
    <tabs
      pills
      class="nav-align-center"
      tab-content-classes="gallery"
      tab-nav-classes="nav-pills-just-icons"
      type="info"
    >
      <tab-pane title="Profile" v-if="favoriteAreas.length >= 1 && favoriteAreas[0].user_idx != ''">
        <!-- tab 아이콘 -->
        <span slot="label">
          <i class="now-ui-icons location_bookmark"></i>
          <p class="description mt-3">{{ favoriteAreas[0].dongname }}</p>
        </span>
        <!-- 안에 들어갈 내용 -->
        <div class="col-md-12 ml-auto mr-auto">
          <!-- 여기에 차트 그릴예정 -->
          <!-- <div class="col-md-12" v-for="(item, idx) in categoryCount[0].list" :key="idx">{{ item.name }} {{ item.count }}</div> -->
          <drow-chart :dataset="testcategoryCount0"></drow-chart>
        </div>
      </tab-pane>

      <tab-pane title="Home" v-if="favoriteAreas.length >= 2 && favoriteAreas[1].user_idx != ''">
        <span slot="label">
          <i class="now-ui-icons location_pin"></i>
          <p class="description mt-3">{{ favoriteAreas[1].dongname }}</p>
        </span>
        <div class="col-md-10 ml-auto mr-auto">
          <!-- 여기에 차트 그릴예정 -->
          <drow-chart :dataset="testcategoryCount1"></drow-chart>
        </div>
      </tab-pane>

      <tab-pane
        title="Messages"
        v-if="favoriteAreas.length >= 3 && favoriteAreas[2].user_idx != ''"
      >
        <span slot="label">
          <i class="now-ui-icons objects_globe"></i>
          <p class="description mt-3">{{ favoriteAreas[2].dongname }}</p>
        </span>
        <div class="col-md-10 ml-auto mr-auto">
          <!-- 여기에 차트 그릴예정 -->
          <drow-chart :dataset="testcategoryCount2"></drow-chart>
        </div>
      </tab-pane>
    </tabs>
  </div>
</template>

<script>
    import { Tabs, TabPane } from "@/components";
    import axios from "axios";
    import DrowChart from "./DrowChart.vue";

    export default {
        components: {
            TabPane,
            Tabs,
            DrowChart,
        },
        props: {
            favoriteAreas: Array,
            covidCount: Array,
        },
        data() {
            return {
                sessionUser: "",
                categoryList: [
                    { code: "SC4", name: "학교" },
                    // { code: "PS3", name: "유치원" },
                    // { code: "AC5", name: "학원" },
                    // { code: "CE7", name: "카페" },
                    { code: "CS2", name: "편의점" },
                    { code: "SW8", name: "지하철역" },
                    // { code: "BK9", name: "은행" },
                    { code: "CT1", name: "문화시설" },
                    { code: "HP8", name: "병원" },
                ],
                categoryCount: [],

                testcategoryCount0: [],
                testcategoryCount1: [],
                testcategoryCount2: [],

                chartData: [],
                test: "",
            };
        },
        created() {
            console.log("생성되었습니다");
            console.log(this.favoriteAreas);
            console.log(this.covidCount);
            if (this.favoriteAreas.length >= 1 && this.favoriteAreas[0].user_idx != "") {
                this.testgetcode0();
            }
            if (this.favoriteAreas.length >= 2 && this.favoriteAreas[1].user_idx != "") {
                this.testgetcode1();
            }
            if (this.favoriteAreas.length >= 3 && this.favoriteAreas[2].user_idx != "") {
                this.testgetcode2();
            }
            console.log(this.categoryCount);
            // for (var i = 0; i < this.favoriteAreas.length; i++) {
            //     console.log("여기여@@@@@@@여기여!@@@@@@#!#!##!@$@#%#$^^#$");
            //     console.log(this.categoryCount[i].list);
            // }
        },
        mounted() {},
        methods: {
            // start1() {
            //     console.log("1번 버튼 클릭!!");
            //     this.ok1 = !this.ok1;
            // },
            // start2() {
            //     console.log("2번 버튼 클릭!!");
            //     this.ok2 = !this.ok2;
            // },
            // start3() {
            //     console.log("3번 버튼 클릭!!");
            //     this.ok3 = !this.ok3;
            // },
            testgetcode0() {
                var address = this.favoriteAreas[0].gugunname + " " + this.favoriteAreas[0].dongname;
                console.log("관심지역 주소에여");
                console.log(address);
                var url = "https://dapi.kakao.com/v2/local/search/address.json?&query=" + address;
                var latlng;
                axios
                    .get(url, {
                        headers: {
                            Authorization: " KakaoAK 5d8e87ef95d095e377b5dfdcfadfac18",
                        },
                    })
                    .then((response) => {
                        latlng = {
                            y: response.data.documents[0].y,
                            x: response.data.documents[0].x,
                        };
                    })
                    .catch((ERROR) => {
                        console.log(ERROR);
                    })
                    .finally(() => {
                        console.log("완료");
                        console.log(latlng);
                        var tempList = [];
                        this.categoryList.forEach(function (item) {
                            var aaaa = item.name;
                            var res;
                            var url2 =
                                "https://dapi.kakao.com/v2/local/search/category.json?category_group_code=" +
                                item.code +
                                "&y=" +
                                latlng.y +
                                "&x=" +
                                latlng.x +
                                "&radius=5000";
                            console.log(item.code);
                            axios
                                .get(url2, {
                                    headers: {
                                        Authorization: " KakaoAK 5d8e87ef95d095e377b5dfdcfadfac18",
                                    },
                                })
                                .then((response) => {
                                    console.log(aaaa + " 카테고리 결과 가져왔습니다.");
                                    console.log(response.data.meta.total_count);
                                    res = response.data.meta.total_count;
                                })
                                .catch((Error) => {
                                    console.log(Error);
                                })
                                .finally(() => {
                                    console.log("파이널리인데");
                                    console.log(aaaa);
                                    console.log(res + " 파이널에서 결과 보기");
                                    tempList.push({ name: aaaa, count: res });
                                    console.log(tempList);
                                });
                        });
                        // if (idx == 0) {
                        //     this.ok1 = true;
                        // } else if (idx == 1) {
                        //     this.ok2 = true;
                        // } else {
                        //     this.ok3 = true;
                        // }
                        //this.categoryCount = [];
                        // this.categoryCount.push({ list: tempList });
                        console.log("@@@@@@@@@@@@@@@             " + 0 + "        @@@@@@@@@@@@");
                        this.testcategoryCount0 = tempList;
                        this.testcategoryCount0.push({ name: "코로나 진료소", count: this.covidCount[0] });
                        console.log(this.testcategoryCount0);
                        // this.categoryCount[0].list.push({ name: "코로나 진료소", count: this.covidCount[0] });
                        // console.log(this.categoryCount[idx].list);
                        // if (idx < 2) {
                        //     this.testgetcode(idx + 1);
                        // }
                    });
            },
            testgetcode1() {
                var address = this.favoriteAreas[1].gugunname + " " + this.favoriteAreas[1].dongname;
                console.log("관심지역 주소에여");
                console.log(address);
                var url = "https://dapi.kakao.com/v2/local/search/address.json?&query=" + address;
                var latlng;
                axios
                    .get(url, {
                        headers: {
                            Authorization: " KakaoAK 5d8e87ef95d095e377b5dfdcfadfac18",
                        },
                    })
                    .then((response) => {
                        latlng = {
                            y: response.data.documents[0].y,
                            x: response.data.documents[0].x,
                        };
                    })
                    .catch((ERROR) => {
                        console.log(ERROR);
                    })
                    .finally(() => {
                        console.log("완료");
                        console.log(latlng);
                        var tempList = [];
                        this.categoryList.forEach(function (item) {
                            var aaaa = item.name;
                            var res;
                            var url2 =
                                "https://dapi.kakao.com/v2/local/search/category.json?category_group_code=" +
                                item.code +
                                "&y=" +
                                latlng.y +
                                "&x=" +
                                latlng.x +
                                "&radius=5000";
                            console.log(item.code);
                            axios
                                .get(url2, {
                                    headers: {
                                        Authorization: " KakaoAK 5d8e87ef95d095e377b5dfdcfadfac18",
                                    },
                                })
                                .then((response) => {
                                    console.log(aaaa + " 카테고리 결과 가져왔습니다.");
                                    console.log(response.data.meta.total_count);
                                    res = response.data.meta.total_count;
                                })
                                .catch((Error) => {
                                    console.log(Error);
                                })
                                .finally(() => {
                                    console.log("파이널리인데");
                                    console.log(aaaa);
                                    console.log(res + " 파이널에서 결과 보기");
                                    tempList.push({ name: aaaa, count: res });
                                    console.log(tempList);
                                });
                        });
                        // if (idx == 0) {
                        //     this.ok1 = true;
                        // } else if (idx == 1) {
                        //     this.ok2 = true;
                        // } else {
                        //     this.ok3 = true;
                        // }
                        //this.categoryCount = [];
                        // this.categoryCount.push({ list: tempList });
                        console.log("@@@@@@@@@@@@@@@             " + 1 + "        @@@@@@@@@@@@");
                        this.testcategoryCount1 = tempList;
                        this.testcategoryCount1.push({ name: "코로나 진료소", count: this.covidCount[1] });
                        console.log(this.testcategoryCount0);
                        // this.categoryCount[1].list.push({ name: "코로나 진료소", count: this.covidCount[1] });
                        // console.log(this.categoryCount[idx].list);
                        // if (idx < 2) {
                        //     this.testgetcode(idx + 1);
                        // }
                    });
            },
            testgetcode2() {
                var address = this.favoriteAreas[2].gugunname + " " + this.favoriteAreas[2].dongname;
                console.log("관심지역 주소에여");
                console.log(address);
                var url = "https://dapi.kakao.com/v2/local/search/address.json?&query=" + address;
                var latlng;
                axios
                    .get(url, {
                        headers: {
                            Authorization: " KakaoAK 5d8e87ef95d095e377b5dfdcfadfac18",
                        },
                    })
                    .then((response) => {
                        latlng = {
                            y: response.data.documents[0].y,
                            x: response.data.documents[0].x,
                        };
                    })
                    .catch((ERROR) => {
                        console.log(ERROR);
                    })
                    .finally(() => {
                        console.log("완료");
                        console.log(latlng);
                        var tempList = [];
                        this.categoryList.forEach(function (item) {
                            var aaaa = item.name;
                            var res;
                            var url2 =
                                "https://dapi.kakao.com/v2/local/search/category.json?category_group_code=" +
                                item.code +
                                "&y=" +
                                latlng.y +
                                "&x=" +
                                latlng.x +
                                "&radius=5000";
                            console.log(item.code);
                            axios
                                .get(url2, {
                                    headers: {
                                        Authorization: " KakaoAK 5d8e87ef95d095e377b5dfdcfadfac18",
                                    },
                                })
                                .then((response) => {
                                    console.log(aaaa + " 카테고리 결과 가져왔습니다.");
                                    console.log(response.data.meta.total_count);
                                    res = response.data.meta.total_count;
                                })
                                .catch((Error) => {
                                    console.log(Error);
                                })
                                .finally(() => {
                                    console.log("파이널리인데");
                                    console.log(aaaa);
                                    console.log(res + " 파이널에서 결과 보기");
                                    tempList.push({ name: aaaa, count: res });
                                    console.log(tempList);
                                });
                        });
                        // if (idx == 0) {
                        //     this.ok1 = true;
                        // } else if (idx == 1) {
                        //     this.ok2 = true;
                        // } else {
                        //     this.ok3 = true;
                        // }
                        //this.categoryCount = [];
                        // this.categoryCount.push({ list: tempList });
                        console.log("@@@@@@@@@@@@@@@             " + 2 + "        @@@@@@@@@@@@");
                        this.testcategoryCount2 = tempList;
                        this.testcategoryCount2.push({ name: "코로나 진료소", count: this.covidCount[2] });
                        console.log(this.testcategoryCount0);
                        // this.categoryCount[2].list.push({ name: "코로나 진료소", count: this.covidCount[2] });
                        // console.log(this.categoryCount[idx].list);
                        // if (idx < 2) {
                        //     this.testgetcode(idx + 1);
                        // }
                    });
            },
        },
    };
</script>

<style>
.tab-content.tab-content-padding {
  padding: 20px;
}
</style>
