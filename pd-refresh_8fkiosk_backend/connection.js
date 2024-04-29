//개발 (로컬)

const {Client} = require('pg')

const client = new Client({
    host: "localhost",
    user: "postgres",
    port: 5432,
    password: "1234",
    database: "postgres"
})
module.exports = client

//상용 (서버)

// const {Client} = require('pg')

// const client = new Client({
//     host: "localhost",
//     user: "postgres",
//     port: 30002,
//     password: "1234",
//     database: "postgres"
// })
// module.exports = client

