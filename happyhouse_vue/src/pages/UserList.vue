<template>
    <div>
        <div class="page-header page-header-small">
            <parallax class="page-header-image" style="background-image: url('img/bg6.jpg')"></parallax>
            <div class="content-center">
                <div class="container">
                    <h1 class="title">회원관리</h1>
                </div>
            </div>
        </div>

        <!-- 회원관리 리스트 -->
        <div class="container" style="margin-top: 30px">
            <div class="overflow-auto">
                <b-pagination v-model="currentPage" :total-rows="rows" :per-page="perPage" aria-controls="my-table"></b-pagination>
                <b-table
                    id="my-table"
                    hover
                    head-variant="dark"
                    :items="userlist"
                    :per-page="perPage"
                    :current-page="currentPage"
                    small
                    :fields="fields"
                >
                    <template #cell(index)="data">
                        {{ data.index + 1 + perPage * (currentPage - 1) }}
                    </template>
                    <template #cell(삭제)="data">
                        <b-button size="sm" @click="userDelete(data.item.userid)">삭제</b-button>
                    </template>
                </b-table>
            </div>
        </div>
    </div>
</template>
<script>
    import { Button, FormGroupInput } from "@/components";
    import http from "@/http-common_map";
    export default {
        name: "landing",
        bodyClass: "landing-page",
        components: {
            [Button.name]: Button,
            [FormGroupInput.name]: FormGroupInput,
        },
        data() {
            return {
                perPage: 10,
                currentPage: 1,
                userlist: [],
                fields: [
                    { key: "index", label: "번호", class: "text-center" },
                    { key: "userid", label: "아이디" },
                    { key: "username", label: "이름" },
                    { key: "email", label: "이메일" },
                    { key: "age", label: "나이" },
                    { key: "address", label: "주소", class: "text-center" },
                    { key: "joindate", label: "가입일" },
                    { key: "삭제", class: "text-center" },
                ],
            };
        },
        created() {
            this.getUserList();
        },
        methods: {
            getUserList() {
                http.get("/user/list")
                    .then((response) => {
                        console.log(response.data);
                        this.userlist = response.data;
                    })
                    .catch((ERROR) => {
                        console.log(ERROR);
                    });
            },
            userDelete(userid) {
                if (userid == "admin") {
                    alert(userid + "님은 삭제할 수 없습니다.");
                    return;
                }
                console.log("삭제하기 클릭");
                if (confirm(userid + "님을 정말 삭제하시겠습니까?")) {
                    http.post("/user/delete", userid)
                        .then((response) => {
                            if (response) {
                                alert(userid + "님을 삭제하였습니다.");
                                this.userlist;
                                this.getUserList();
                            }
                        })
                        .catch((ERROR) => {
                            console.log(ERROR);
                        });
                }
            },
        },
        computed: {
            rows() {
                return this.userlist.length;
            },
        },
    };
</script>
<style></style>
