<template>
  <div>
    <div class="page-header clear-filter">
      <parallax class="page-header-image" style="background-image: url('img/bg2.jpg')"></parallax>
      <div class="container">
        <h1 class="title">{{ user.userid }}</h1>
        <p class="category">{{ user.role }}</p>
      </div>
    </div>
    <div class="section">
      <div class="container">
        <div v-if="isEdit" class="button-container">
          <a class="btn btn-info btn-round btn-lg" @click="updateUser">수정완료</a>
          <a class="btn btn-default btn-round btn-lg" @click="$router.go()">취소</a>
        </div>
        <div v-else class="button-container">
          <a class="btn btn-info btn-round btn-lg" @click="isEdit = true">정보수정</a>
        </div>
        <h3 class="title">회원정보</h3>
        <div class="col-md-6 ml-auto mr-auto">
          <table class="table">
            <tbody>
              <tr>
                <th scope="row">이름</th>
                <fg-input v-if="isEdit" :value="user.username" v-model="user.username"></fg-input>
                <td v-else>{{ user.username }}</td>
              </tr>
              <tr>
                <th scope="row">이메일</th>
                <fg-input v-if="isEdit" :value="user.email" v-model="user.email"></fg-input>
                <td v-else>{{ user.email }}</td>
              </tr>
              <tr v-if="user.age !== null">
                <th scope="row">나이</th>
                <fg-input v-if="isEdit" :value="user.age" v-model="user.age"></fg-input>
                <td v-else>{{ user.age }}</td>
              </tr>
              <tr v-if="user.address !== null">
                <th scope="row">주소</th>
                <fg-input v-if="isEdit" :value="user.address" v-model="user.address"></fg-input>
                <td v-else>{{ user.address}}</td>
              </tr>
              <tr v-if="isEdit">
                <th scope="row">비밀번호</th>
                <fg-input
                  v-if="isEdit"
                  :value="user.userpwd"
                  v-model="user.userpwd"
                  type="password"
                ></fg-input>
              </tr>
            </tbody>
          </table>
          <div class="text-center">
            <n-button v-if="isEdit" class="btn-primary btn-round" @click="deleteUser">회원탈퇴</n-button>
          </div>
        </div>
        <div class="row">
          <div class="col-md-6 ml-auto mr-auto">
            <h3 class="title text-center" style="padding-top: 0px">관심 지역</h3>
            <!-- <div class="text-center"> -->
            <div class="text-center">
              <!-- <div class="section section-team text-center"> -->
              <!-- 유저의 관심지역 보이는 테이블 -->
              <b-table
                v-if="favoriteAreas != ''"
                id="my-table"
                hover
                head-variant="dark"
                :items="favoriteAreas"
                small
                :fields="fields"
              >
                <template #cell(index)="data">{{ data.index + 1 }}</template>
                <template #cell(삭제)="data">
                  <b-button size="sm" @click="deleteArea(data.index)">삭제</b-button>
                </template>
              </b-table>

              <!-- <div v-for="area in favoriteAreas" :key="area.no">
                                <n-button>{{ favoriteAreas.name }}</n-button>
              </div>-->

              <div class="container">
                <div class="row">
                  <!-- select박스 -->
                  <div class="col-lg-11">
                    <form class="checkdomain form-inline" id="searchform" action="$" method="post">
                      <div class="col-lg-12 text-center checkdomain-wrapper">
                        <select
                          class="custom-select mr-3"
                          v-model="selectsido"
                          @change="getgugun($event)"
                          style="margin: 10px 1px"
                        >
                          <option selected value="0">도/광역시</option>
                          <option
                            v-for="(item, idx) in sido"
                            :value="{ sido_code: item.sido_code, sido_name: item.sido_name }"
                            :key="idx"
                          >{{ item.sido_name }}</option>
                        </select>
                        <select
                          class="custom-select mr-3"
                          v-model="selectgugun"
                          @change="getdong($event)"
                        >
                          <option selected value="0">시/구/군</option>
                          <option
                            v-for="(item, idx) in gugun"
                            :value="{ gugun_code: item.gugun_code, gugun_name: item.gugun_name }"
                            :key="idx"
                          >{{ item.gugun_name }}</option>
                        </select>
                        <select class="custom-select" v-model="selectdong">
                          <option selected value="0">동</option>
                          <option
                            v-for="(item, idx) in dong"
                            :value="item.dong"
                            :key="idx"
                          >{{ item.dong }}</option>
                        </select>
                      </div>
                    </form>
                  </div>
                  <div class="col-lg-1">
                    <!-- + 버튼 -->
                    <n-button
                      v-if="3 > favoriteAreas.length"
                      type="info"
                      class="pull-"
                      icon
                      round
                      @click="addArea"
                    >
                      <i class="now-ui-icons ui-1_simple-add"></i>
                    </n-button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
    import http from "@/http-common_map.js";
    import { Button, FormGroupInput } from "@/components";

    export default {
        name: "profile",
        bodyClass: "profile-page",
        components: {
            [Button.name]: Button,
            [FormGroupInput.name]: FormGroupInput,
        },
        data() {
            return {
                user: "",
                sessionUser: "",
                favoriteAreas: [
                    {
                        user_idx: "",
                        guguncode: "",
                        gugunname: "",
                        dongname: "",
                    },
                ],
                sido: [],
                selectsido: 0,
                gugun: [],
                selectgugun: 0,
                dong: [],
                selectdong: 0,

                fields: [
                    { key: "index", label: "번호", class: "text-center" },
                    { key: "gugunname", label: "구/군" },
                    { key: "dongname", label: "동" },
                    { key: "삭제", class: "text-center" },
                ],
                isEdit: false,
            };
        },
        created() {
            if (sessionStorage.getItem('userinfo') == null) {
                this.$router.push("/login")
            }
            this.sessionUser = JSON.parse(sessionStorage.getItem("userinfo"));
            console.log("프로필 들어왔습니다");
            console.log(JSON.parse(sessionStorage.getItem("userinfo")));
            http.get("/main/sido").then((response) => {
                console.log("get sido code");
                console.log(response);
                this.sido = response.data;
            });

            http.get(`/user/` + this.sessionUser.user_idx)
                .then(({ data }) => {
                    console.log("유저정보를 가져옵니다.");
                    this.user = data;
                })
                .catch(() => {
                    alert("에러가 발생했습니다.");
                });

            http.get(`/user/area/list/${this.sessionUser.user_idx}`)
                .then(({ data }) => {
                    this.favoriteAreas = data;
                    console.log(this.favoriteAreas);
                })
                .catch(() => {
                    alert("에러가 발생했습니다.");
                });
        },
        methods: {
            getgugun: function (event) {
                this.selectgugun = 0;
                this.selectdong = 0;
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
                http.get("/main/dong/" + this.selectgugun.gugun_code).then((response) => {
                    console.log("get dong code");
                    console.log(response);
                    this.dong = response.data;
                });
            },
            addArea: function () {
                console.log("관심지역 더하기");
                console.log(this.user);
                // console.log(this.selectgugun);
                // console.log(this.selectdong);
                // this.favoriteAreas.push({
                //     gugunname: this.selectgugun.gugun_name,
                //     dong: this.selectdong,
                // });

                http.post("/user/area/add", {
                    user_idx: this.user.user_idx,
                    guguncode: this.selectgugun.gugun_code,
                    gugunname: this.selectgugun.gugun_name,
                    dongname: this.selectdong,
                })
                    .then((response) => {
                        if (response) {
                            console.log("지역 더하기 완료");
                            this.favoriteAreas.push({
                                user_idx: this.user_idx,
                                guguncode: this.selectgugun.gugun_code,
                                gugunname: this.selectgugun.gugun_name,
                                dongname: this.selectdong,
                            });
                        }
                    })
                    .catch((ERROR) => {
                        console.log(ERROR);
                    })
                    .finally(() => {
                        this.selectsido = 0;
                        this.selectgugun = 0;
                        this.selectdong = 0;
                    });
            },

            deleteArea(index) {
                console.log(index + "번째 아이템을 삭제하러 들어왔습니다.");
                console.log(this.user);
                console.log(this.favoriteAreas[index].guguncode);
                console.log(this.favoriteAreas[index].dongname);
                http.post("/user/area/delete", {
                    user_idx: this.user.user_idx,
                    guguncode: this.favoriteAreas[index].guguncode,
                    gugunname: this.favoriteAreas[index].gugunname,
                    dongname: this.favoriteAreas[index].dongname,
                })
                    .then((response) => {
                        console.log("아이탬이 삭제되었습니다");
                    })
                    .catch((ERROR) => {
                        console.log(ERROR);
                    });
                this.favoriteAreas.splice(index, 1);
            },
            updateUser() {
                if (this.user.userpwd == null) {
                    alert("수정할 비밀번호를 입력하세요")
                    return
                }
                http
                .post(`/user/modify`, this.user)
                .then(({ data }) => {
                    this.isEdit = false;
                    this.user.userpwd = null;
                })
                .catch(() => {
                    alert("에러가 발생했습니다.");
                });
            },
            deleteUser() {
                http
                .get(`/user/delete/` + this.user.userid)
                .then(({ data }) => {
                    sessionStorage.clear()
                    this.$router.go()
                })
                .catch(() => {
                    alert("에러가 발생했습니다.");
                });
            }
        },
    };
</script>
<style></style>
