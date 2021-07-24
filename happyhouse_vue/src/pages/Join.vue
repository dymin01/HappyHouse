<template>
  <div class="page-header clear-filter">
    <div
      class="page-header-image"
      style="background-image: url('img/join.jpg'); filter: brightness(50%)"
    ></div>
    <div class="content">
      <div class="container">
        <div class="col-md-5 ml-auto mr-auto">
          <card type="login" plain>
            <form action method="post" @submit.prevent="registryMyself">
              <fg-input
                class="no-border input-lg"
                addon-left-icon="now-ui-icons users_circle-08"
                style="height: 50px"
                placeholder="ID"
                name="userid"
                id="userid"
                v-model="customer.userid"
                @blur="checkuserid"
              ></fg-input>

              <fg-input
                class="no-border input-lg"
                addon-left-icon="now-ui-icons ui-1_lock-circle-open"
                placeholder="비밀번호"
                style="height: 50px"
                name="userpwd"
                id="userpwd"
                v-model="customer.userpwd"
                type="password"
              ></fg-input>

              <fg-input
                class="no-border input-lg"
                addon-left-icon="now-ui-icons text_caps-small"
                placeholder="이름"
                style="height: 50px"
                name="username"
                id="username"
                v-model="customer.username"
              ></fg-input>

              <fg-input
                class="no-border input-lg"
                addon-left-icon="now-ui-icons ui-1_calendar-60"
                placeholder="나이"
                type="number"
                style="height: 50px"
                name="age"
                id="age"
                v-model="customer.age"
              ></fg-input>

              <fg-input
                class="no-border input-lg"
                addon-left-icon="now-ui-icons location_compass-05"
                placeholder="주소"
                type="address"
                style="height: 50px"
                name="address"
                id="address"
                v-model="customer.address"
              ></fg-input>

              <fg-input
                class="no-border input-lg"
                addon-left-icon="now-ui-icons ui-1_email-85"
                placeholder="이메일"
                type="email"
                style="height: 50px"
                name="email"
                id="email"
                v-model="customer.email"
              ></fg-input>

              <div class="card-footer text-center">
                <button type="submit" class="btn btn-info btn-round btn-lg btn-block">회원 가입</button>
              </div>
            </form>
          </card>
        </div>
      </div>
    </div>
    <main-footer></main-footer>
  </div>
</template>
<script>
    import { Card, Button, FormGroupInput } from "@/components";
    import MainFooter from "@/layout/MainFooter";
    import http from "../http-common_map.js";

    export default {
        name: "join-page",
        bodyClass: "login-page",
        components: {
            Card,
            MainFooter,
            [Button.name]: Button,
            [FormGroupInput.name]: FormGroupInput,
        },
        data() {
            return {
                customer: {
                    userid: "",
                    username: "",
                    userpwd: "",
                    adderss: "",
                    email: "",
                    age: "",
                },
                submitted: false,
            };
        },
        methods: {
            checkuserid() {
                if (this.customer.userid == '') {
                    alert('아이디용이름 입력하세요.')
                    return
                }
                http
                    .get('user/check/' + this.customer.userid)
                    .then((response) => {
                        if (!response.data) {
                            alert('이미 존재하는 아이디입니다.')
                            this.customer.userid = '';
                        } else {
                            alert('사용할 수 있는 아이디입니다.')
                        }
                    })
                    .catch(() => {
                        alert('사용할 수 있는 아이디입니다.')
                    })
            },
            registryMyself() {
                if (this.customer.userid == "") {
                    alert("아이디용이름 입력하세요.");
                    return;
                }
                if (this.customer.username == "") {
                    alert("이름을 입력하세요.");
                    return;
                }
                if (this.customer.email == "") {
                    alert("이메일을 입력하세요.");
                    return;
                }
                if (this.customer.userpwd == "") {
                    alert("패스워드를 입력하세요.");
                    return;
                }

                http.post("/user/join", {
                    userid: this.customer.userid,
                    username: this.customer.username,
                    email: this.customer.email,
                    address: this.customer.address,
                    age: this.customer.age,
                    userpwd: this.customer.userpwd,
                })
                    .then((response) => {
                        alert("성공적으로 가입 하였습니다. 로그인 하십시오.");
                        this.$router.push("/login");
                    })
                    .catch(() => {
                        alert("가입을 하지 못했습니다.");
                        this.visablelogin = false;
                        this.submitted = false;
                        this.newCustomer();
                    });
            },
            newCustomer() {
                this.customer = {
                    username: "",
                    cname: "",
                    email: "",
                    password: "",
                };
            },
        },
    };
</script>
<style></style>
