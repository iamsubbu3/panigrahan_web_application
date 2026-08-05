import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {

  vus: 25,
  duration: '30s',

  thresholds: {
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<500'],
  },
};

const TOKEN = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwicm9sZSI6OTksIm9yZ2lkIjoxLCJpYXQiOjE3ODE2NzMzMDIsImV4cCI6MTc4MjI3ODEwMn0.PbvwRlO9OmyPPnfLLSWQto_Mu-jugEafBDZgHGl9G18';

export default function () {

  const params = {
    headers: {
      Authorization: `Bearer ${TOKEN}`,
      'Content-Type': 'application/json',
    },
  };

  const res = http.get(
    'https://panigrahanam.in/profiles',
    params
  );

  check(res, {
    'status is 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });

  console.log(`STATUS: ${res.status}`);

  if (res.status !== 200) {
    console.log(res.body);
  }

  sleep(1);
}
