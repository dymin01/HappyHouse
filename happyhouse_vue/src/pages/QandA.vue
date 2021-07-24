<template>
  <div>
    <div class="page-header page-header-small">
      <parallax class="page-header-image" style="background-image: url('img/bg1.jpg')"></parallax>
      <div class="content-center">
        <div class="container">
          <h1 class="title">Q & A</h1>
          <div class="text-center">
            <a
              v-if="sessionUser.user_idx != 0"
              class="btn btn-info btn-round"
              @click="$router.push(`/qna/form`)"
            >질문하기</a>
          </div>
        </div>
      </div>
    </div>
    <div class="section text-center">
      <div class="container">
        <table v-if="items.length" class="table table-hover">
          <col width="10%" />
          <col width="55%" />
          <col width="10%" />
          <col width="25%" />
          <thead>
            <tr class="table-primary">
              <th>Q&A 번호</th>
              <th>질문</th>
              <th>답변상태</th>
              <th>작성일</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in items" class="nicecolor" :key="item.articleno">
              <td v-html="index + 1"></td>
              <td>
                <collapse>
                  <collapse-item :title="item.subject">
                    <p>{{ item.content }}</p>
                    <hr />
                    <div
                      v-if="sessionUser.role == 'admin' || sessionUser.user_idx == item.user_idx"
                      class="pull-left"
                    >
                      <n-button
                        size="sm"
                        type="default"
                        @click="$router.push(`/qna/form/${item.articleno}`)"
                        round
                      >수정</n-button>
                      <n-button
                        size="sm"
                        type="primary"
                        @click="deleteArticle"
                        :name="item.articleno"
                        round
                      >삭제</n-button>
                    </div>
                  </collapse-item>
                </collapse>
              </td>
              <!-- <td v-html="item.answer"></!-->
              <td v-if="item.answer === null">
                <n-button
                  type="default"
                  size="sm"
                  @click="addAnswer"
                  :name="item.articleno"
                  round
                >답변대기</n-button>
              </td>
              <td v-else>
                <n-button size="sm" type="info" @click.native="modals.classic = true" round>답변확인</n-button>
                <modal :show.sync="modals.classic" headerClasses="justify-content-center">
                  <h4 slot="header" class="title title-up">[답변] {{ item.subject }}</h4>
                  <p>{{ item.answer }}</p>
                  <template slot="footer"></template>
                </modal>
              </td>
              <td v-html="getFormatDate(item.regtime)"></td>
            </tr>
          </tbody>
        </table>
        <h3 v-else>작성된 질문이 없습니다</h3>
      </div>
    </div>
  </div>
</template>
<script>
import http from '@/http-common_map.js';
import moment from 'moment';
import { Button, FormGroupInput, Card, Collapse, CollapseItem, Badge, Modal } from '@/components';
export default {
  name: 'notice',
  bodyClass: 'notice-page',
  components: {
    [Button.name]: Button,
    [FormGroupInput.name]: FormGroupInput,
    [Collapse.name]: Collapse,
    [CollapseItem.name]: CollapseItem,
    [Badge.name]: Badge,
    [Modal.name]: Modal
  },
  data() {
    return {
      sessionUser: {
        role: "",
        user_idx: 0
      },
      form: {
        firstName: '',
        email: '',
        message: ''
      },
      items: [],
      modals: {
        classic: false,
        answer: false,
      },
    };
  },
  created() {
    if (JSON.parse(sessionStorage.getItem('userinfo')) != null) {
      this.sessionUser = JSON.parse(sessionStorage.getItem('userinfo'))
    }
    http
      .get("/qna/list")
      .then(({ data }) => {
        this.items = data;
      })
      .catch(() => {
        alert("에러가 발생했습니다.");
      });
  },
  methods: {
    getFormatDate(regtime) {
      return moment(new Date(regtime)).format("YYYY.MM.DD");
    },
    deleteArticle(event) {
      http
      .post("/qna/deleteBoard/" + event.target.name)
      .then(() => {
        this.$router.go()
      })
      .catch(() => {
        alert("에러가 발생했습니다.");
      });
    },
    addAnswer(event) {
      if (this.sessionUser.role == 'admin') {
        this.$router.push(`/qna/form/${event.target.name}?type=ans`)
      }
    }
  }
};
</script>
<style></style>
