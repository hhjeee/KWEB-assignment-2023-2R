//fs (File System): readdir, stat, stats.isDirectory
//path: extname, join

//fs.readdir(path, callback)
//fs.stat(path, callback)
//stat.isDirectory() : 디렉토리 여부 확인
//path.extname(경로) : 확장자 확인
//path.join(디렉토리, 디렉토리..) : 경로 붙이기

const fs = require("fs");
const path = require("path");
const util = require("util");

const PATH = "./test";

const getDirList = util.promisify(fs.readdir);
const getFileStat = util.promisify(fs.stat);

const findJSFile = async (directory) => {
  const files = await getDirList(directory);
  files.forEach(async (file) => {
    const filePath = path.join(directory, file); //이전 경로 join
    const stat = await getFileStat(filePath); //fs.stat은 경로받음
    if (stat.isDirectory()) await findJSFile(filePath); //디렉토리면
    else if (path.extname(filePath) === ".js") console.log(filePath); //파일이면 -> js확인
  });
};
(async () => {
  try {
    await findJSFile(PATH);
  } catch (err) {
    console.error(err);
  }
})();
