const crypto = require('crypto');

// const secretKey = crypto.randomBytes(32); // 256 bits key
// const iv = crypto.randomBytes(16); // Initialization vector
const secretKey = "mediazenpdrndpdrefresh8fkioskkey";
const iv = "pdrefresh8faesiv";

//console.log(`secretKey: ${secretKey}`) -- 양방향 사용시 테스트
//console.log(`iv: ${iv}`) -- 양방향 사용시 테스트

// 단방향 암호화
const hash = (input) => {
  const hashedValue = crypto.createHash('sha256').update(input).digest('hex');
  return hashedValue;
}

// 양방향 암호화
const encrypt = (plainText) => {
  const cipher = crypto.createCipheriv('aes-256-cbc', secretKey, iv);
  let encrypted = cipher.update(plainText, 'utf-8', 'hex');
  encrypted += cipher.final('hex');
  return encrypted;
}

// 양방향 복호화
const decrypt = (encryptedText) => {
  const decipher = crypto.createDecipheriv('aes-256-cbc', secretKey, iv);
  let decrypted = decipher.update(encryptedText, 'hex', 'utf-8');
  decrypted += decipher.final('utf-8');
  return decrypted;
}

module.exports = {
  hash,
  encrypt,
  decrypt,
}



