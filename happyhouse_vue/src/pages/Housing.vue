<template>
    <div>
        <div class="page-header page-header-small">
            <parallax class="page-header-image" style="background-image: url('img/bg6.jpg')"></parallax>
            <div class="content-center">
                <div class="container">
                    <h1 class="title">매매 / 전세 / 월세 검색</h1>
                </div>
            </div>
        </div>
        <!-- 검색창은 나중에 구현 -->
        <!-- 지역 select -->
        <div v-if="!showDetail">
            <div class="container">
                <div class="row">
                    <!-- select박스 -->
                    <div class="col-lg-12">
                        <form class="checkdomain form-inline" id="searchform" action="$" method="post">
                            <div class="col-sm-12 text-center checkdomain-wrapper">
                                <!--
                            거래 년도 선택할 수 있도록.
                            <select class="custom-select m-3" >
                            </select> -->
                                <select class="custom-select m-3" v-model="type" @change="reset">
                                    <option selected value="0">조건 범위</option>
                                    <option value="1">시/구/군</option>
                                    <option value="2">동</option>
                                </select>
                                <select class="custom-select mr-3" v-model="selectsido" @change="getgugun($event)">
                                    <option selected value="0">도/광역시</option>
                                    <option v-for="(item, idx) in sido" :value="{ sido_code: item.sido_code, sido_name: item.sido_name }" :key="idx">
                                        {{ item.sido_name }}
                                    </option>
                                </select>
                                <select class="custom-select mr-3" v-model="selectgugun" @change="getdong($event)">
                                    <option selected value="0">시/구/군</option>
                                    <option
                                        v-for="(item, idx) in gugun"
                                        :value="{ gugun_code: item.gugun_code, gugun_name: item.gugun_name }"
                                        :key="idx"
                                    >
                                        {{ item.gugun_name }}
                                    </option>
                                </select>
                                <select class="custom-select" v-model="selectdong" @change="getAptInfo($event)" v-if="type != 1">
                                    <option selected value="0">동</option>
                                    <option v-for="(item, idx) in dong" :value="item.dong" :key="idx">
                                        {{ item.dong }}
                                    </option>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <kakao-map :aptinfo="aptinfo" :gugun_name="selectgugun.gugun_name" v-if="isOk"></kakao-map>
                <apt-list :aptinfo="aptinfo" :gugun_name="selectgugun.gugun_name" @showAptDetail="showAptDetail" v-if="isOk"></apt-list>
            </div>
        </div>
        <div v-if="showDetail">
            <apt-detail :aptdata="aptdata" :gugun_name="selectgugun.gugun_name" @back="back"></apt-detail>
        </div>
    </div>
</template>
<script>
    import { Button, FormGroupInput } from "@/components";
    import http from "@/http-common_map";
    import KakaoMap from "./Kakaomap.vue";
    import AptList from "./AptList.vue";
    import AptDetail from "./AptDetail";
    export default {
        name: "landing",
        bodyClass: "landing-page",
        components: {
            KakaoMap,
            AptList,
            AptDetail,
            [Button.name]: Button,
            [FormGroupInput.name]: FormGroupInput,
        },
        data() {
            return {
                type: 0,
                sido: [],
                selectsido: "",
                gugun: [],
                selectgugun: "",
                dong: [],
                selectdong: "",
                aptinfo: [],
                isOk: false,
                form: {
                    firstName: "",
                    email: "",
                    message: "",
                },
                showDetail: false,
                aptdata: "",
            };
        },
        created() {
            // baseURL: 'http://localhost:9999/happyhous/main',
            //baseURL: 'http://localhost:8088',
            http.get("/main/sido").then((response) => {
                console.log("get sido code");
                console.log(response);
                this.sido = response.data;
            });
        },
        methods: {
            back() {
                this.showDetail = false;
            },
            showAptDetail(aptdata) {
                console.log("디테일 받아왔다.");
                console.log(aptdata);
                this.aptdata = aptdata;
                this.showDetail = true;
            },
            reset: function () {
                this.selectsido = 0;
                this.selectgugun = 0;
                this.selectdong = 0;
                this.isOk = false;
            },
            getgugun: function (event) {
                this.selectgugun = 0;
                this.selectdong = 0;
                this.isOk = false;
                console.log("코드 확인");
                console.log(this.selectsido.sido_code);
                http.get("/main/gugun/" + this.selectsido.sido_code).then((response) => {
                    console.log("get gugun code");
                    console.log(response);
                    this.gugun = response.data;
                });
            },
            getdong: function (event) {
                this.selectdong = 0;
                this.isOk = false;

                //시구군 으로 검색범위 넓히기.
                if (this.type == 1 && this.selectgugun != 0 && this.selectsido != 0) {
                    console.log("검색번위 시/구/군 으로 검색");

                    http.get("/main/findAll", {
                        params: {
                            dongCode: this.selectgugun.gugun_code,
                        },
                    })
                        .then((response) => {
                            console.log("아파트 가져오기");
                            this.aptinfo = [];
                            this.aptinfo = response.data.response.body.items.item;
                            // 아파트가 하다도 없으면
                            if (this.aptinfo == null) {
                                console.log("비었습니다.");
                                this.aptinfo = [];
                                this.aptinfo.push({
                                    법정동: "",
                                    지번: "",
                                });
                            }
                            this.isOk = true;
                        })
                        .catch((ERROR) => {
                            console.log("에러남");
                            console.log(ERROR);
                        });
                } else {
                    http.get("/main/dong/" + this.selectgugun.gugun_code).then((response) => {
                        console.log("get dong code");
                        console.log(response);
                        this.dong = response.data;
                    });
                }
            },
            getAptInfo: function (event) {
                console.log("in fnc");
                console.log(event.target.value);

                if (this.selectdong != 0 && this.selectgugun != 0 && this.selectsido != 0) {
                    http.get("/main/findAll", {
                        params: {
                            dongCode: this.selectgugun.gugun_code,
                        },
                    }).then((response) => {
                        this.aptinfo = [];
                        console.log("get aptinfo");
                        console.log(response.data.response.body.items.item);
                        var apttemp = response.data.response.body.items.item;
                        console.log(apttemp);

                        for (var i = 0; i < apttemp.length; i++) {
                            //console.log(apttemp[i].법정동.trim());
                            //console.log(event.target.value);
                            if (apttemp[i].법정동.trim() == event.target.value) {
                                //console.log("같은 법정동 내 아파트 찾음");
                                apttemp[i].법정동 = apttemp[i].법정동.trim();
                                this.aptinfo.push(apttemp[i]);
                            }
                        }
                        console.log(this.aptinfo);
                        // 아파트가 하다도 없으면
                        if (this.aptinfo.length == 0) {
                            this.aptinfo.push({
                                법정동: this.selectdong,
                                지번: "",
                            });
                        }
                        //this.aptinfo = response.data.response.body.items.item;
                        this.isOk = true;
                    });
                }
            },
        },
    };
</script>
<style></style>
