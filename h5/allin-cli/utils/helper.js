let fs = require("fs");
let path = require("path");
// let walk = require("walk");
let chalk = require("chalk");


function __readDirSync(path) {
    var pa = fs.readdirSync(path);
    var files = [];
    pa.forEach(function (ele, index) {
        var info = fs.statSync(path + "/" + ele);
        if (info.isDirectory()) {
            files = files.concat(__readDirSync(path + "/" + ele));
        } else {
            // console.log("file: "+ele);
            files.push(path + "/" + ele);
        }
    })
    return files;
}

function __rename(src, replacement) {
    return function (files) {
        let arr = [];
        if (files && files.length > 0) {
            files.forEach(function (el, index) {
                let dirName = path.dirname(el);
                let fileName = path.basename(el);
                if (fileName.startsWith(src)) {
                    arr.push(path.resolve(dirName, fileName.replace(src, replacement)));
                    fs.rename(el, path.resolve(dirName, fileName.replace(src, replacement)), (err) => {
                        if(err) console.log(chalk.red.bold(`重命名错误：${err}`));
                        console.log(chalk.green(`重命名成功：${el} -> ${path.resolve(dirName, fileName.replace(src, replacement))}`))
                    });
                }
            });
        }
        return arr;
    }
}


function __readFileSync(path) {
    var data = fs.readFileSync(path,{encoding:"utf8"});
    return data;
}


module.exports = {
    rename: __rename,
    readDir: __readDirSync,
    readFile:__readFileSync
};
