let cmd = require("commander");
var inquirer = require('inquirer')
let pkg = require("./package.json");
let chalk = require("chalk");
let path = require("path");
let {rename, readDir} = require("./helper.js");
let {Functor} = require("./Functor.js");


//-V --version
// cmd.version();

// version
cmd.command('version')
    .action(function (__cmd) {
        console.log("当前版本" + chalk.red(pkg.version));
    });

cmd.command('rename <directory> <source> <replacement>')
    .usage('<directory> <source> <replacement> \n' +
        '\t 搜索某个文件夹下的文件名一部分replace成制定内容\n' +
        '\t directory:轮询的目录 \n'+
        '\t source:被替换的string \n'+
        '\t replacement:替换成string \n'+
        '\t allin rename ~/workspace/ AL ALBase\n'
    ).option('-r, --recursive', 'Remove recursively')
    .action(function (dir,source,replacement,cmd) {
        let __path = path.resolve(process.cwd(), "../", dir);
        console.log(`读取文件${chalk.green.bold(__path)}`);
        //read&replace
        Functor.of(__path)
            .map(readDir)
            .map(rename(source,replacement));
    });





cmd.parse(process.argv);


// var root = path.join(path.resolve(process.cwd(),"../iOS"))

// readDirSync(root)