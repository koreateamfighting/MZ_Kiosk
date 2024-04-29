module.exports = {
  VERSION: '1.0.0',
  EXPRESS_PORT: 50002,
  PSQL_PORT: 30002,
  URL_LOCALTUNNEL: 'https://mediazen-pdrf.loca.lt',
  WELCOME_CONTENT: `<html><head><title>MZLP</title><style>body {margin: 0;padding: 0;background-\color: #3F3F3F;display: flex;justify-content: center;align-items: center;height: 100vh;font-family: Arial, sans-serif;}\
                    .content {text-align: center;color: #fff;}\
                    .image {max-width: 300px;margin-bottom: 20px;}</style></head>\
                    <body><div class="content">\
                    <img class="image" src="/images/group_logo.png" alt="MZLP 로고">\
                    <h1>PDRF CAFEBACK Server Page</h1>\
                    <p>Welcome, This page is supportd by PDRF</p></div></body></html>`
};