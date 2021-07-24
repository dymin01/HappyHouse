import axios from 'axios';

// axios 객체 생성
export default axios.create({
    // baseURL: 'http://localhost:9999/happyhous/main',
    baseURL: 'http://localhost:8088',
    headers: {
        'Content-type': 'application/json',
    },
});