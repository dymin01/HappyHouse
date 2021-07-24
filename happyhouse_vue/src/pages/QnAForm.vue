<template>
  <div>
    <div class="section section-about-us">
      <div class="container">
        <div class="row">
          <div class="col-md-8 ml-auto mr-auto text-center">
            <h2 v-if="$route.query.type === 'ans'" class="title">답변 등록</h2>
            <h2 v-else-if="$route.params.articleno !== undefined" class="title">질문 수정</h2>
            <h2 v-else class="title">질문 등록</h2>
          </div>
        </div>
        <div class="separator separator-primary"></div>
        <div class="section-story-overview">
          <div class="row">
            <div class="col-lg-6 ml-auto mr-auto col-md-8">
              <div>
                <p>질문 내용</p>
                <div v-if="$route.query.type === 'ans'">{{ notice.content }}</div>
                <fg-input v-else class="input-lg" placeholder="Title" v-model="notice.subject"></fg-input>
              </div>
              <hr />
              <div v-if="$route.query.type === 'ans'">
                <p>상세사항</p>
                <div class="textarea-container">
                  <textarea
                    class="form-control"
                    name="content"
                    rows="4"
                    cols="80"
                    placeholder="답변을 작성하세요"
                    v-model="notice.answer"
                  ></textarea>
                </div>
              </div>
              <div v-else>
                <p>상세사항</p>
                <div class="textarea-container">
                  <textarea
                    class="form-control"
                    name="content"
                    rows="4"
                    cols="80"
                    placeholder="Content"
                    v-model="notice.content"
                  ></textarea>
                </div>
              </div>
              <div class="text-right mt-5">
                <router-link :to="`/qna`">
                  <n-button type="default" round>목록</n-button>
                </router-link>
                <n-button
                  v-if="$route.query.type === 'ans'"
                  type="info"
                  @click="modifyNotice"
                  round
                >등록</n-button>
                <n-button
                  v-else-if="$route.params.articleno !== undefined"
                  type="info"
                  @click="modifyNotice"
                  round
                >수정</n-button>
                <n-button v-else type="info" @click="postNotice" round>등록</n-button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import http from '@/http-common_map.js';
import { Button, FormGroupInput } from '@/components';
export default {
  name: 'notice-form',
  bodyClass: 'notice-form-page',
  components: {
    [Button.name]: Button,
    [FormGroupInput.name]: FormGroupInput
  },
  data() {
    return {
      form: {
        firstName: '',
        email: '',
        message: ''
      },
      notice: {},
    };
  },
  created() {
    if (this.$route.params.articleno != undefined) {
      http
        .get(`/qna/findBoardByNo/${this.$route.params.articleno}`)
        .then(({ data }) => {
          this.notice = data;
        })
        .catch(() => {
          alert("에러가 발생했습니다.");
        });
    }
  },
  methods: {
    postNotice() {
      this.notice.user_idx = JSON.parse(sessionStorage.getItem('userinfo')).user_idx;
      http
        .post(`/qna/write`, this.notice)
        .then(({ data }) => {
          this.notice = data;
          this.$router.push('/qna')
        })
        .catch(() => {
          alert("에러가 발생했습니다.");
        });

    },
    modifyNotice() {
      http
        .put(`/qna/updateBoard`, this.notice)
        .then(({ data }) => {
          this.notice = data;
          this.$router.push('/qna')
        })
        .catch(() => {
          alert("에러가 발생했습니다.");
        });
    }
  }
};
</script>
<style></style>
