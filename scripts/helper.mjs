//node --experimental-modules all.mjs
//(exports, require, module, __filename, __dirname)
import fs from "fs";
import path from "path";
import walk form "walk";

function readDirSync(path){
    var pa = fs.readdirSync(path);
    pa.forEach(function(ele,index){
        var info = fs.statSync(path+"/"+ele)
        if(info.isDirectory()){
            readDirSync(path+"/"+ele);
        }else{
            console.log("file: "+ele)
        }
    })
}

console.log(`Starting directory: ${process.cwd()}`);
console.log(fs.readdirSync());

var root = path.join(path.resolve(process.cwd(),"../iOS"))

readDirSync(root)
