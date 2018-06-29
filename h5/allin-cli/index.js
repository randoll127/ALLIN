const cmd = require("commander");
const path = require("path");
const chalk = require("chalk");
const transform = require("./generators/util/transform");

const pkg = require("./package.json");
const command = require("./command");
const {rename,readDir,readFile}=require("./utils/helper");
const gitClone = require('gitclone');
// var process = require('child_process');

//-V --version
// cmd.version();




// version
cmd.command('version').action(function () {
    console.log("Version is " + chalk.red(pkg.version));
    // clone with HTTPS

});


cmd.command('init [projectName]')
    .usage('[projectName] \n' +
        '\t 项目文件夹名字\n'
    ).action(function (projectName) {
    command.init(projectName);
});

cmd.command('start')
    .option('-p, --production', 'development tag')
    .action(function (cmd) {
        command.start(!!cmd.production);
    });

cmd.command('rename <directory> <source> <replacement>')
    .usage('<directory> <source> <replacement> \n' +
        '\t 搜索某个文件夹下的文件名一部分replace成制定内容\n' +
        '\t directory:轮询的目录 \n' +
        '\t source:被替换的string \n' +
        '\t replacement:替换成string \n' +
        '\t allin rename ~/workspace/ AL ALBase\n'
    ).option('-r, --recursive', 'Remove recursively')
    .action(function (dir, source, replacement, cmd) {
        let __path = path.resolve(process.cwd(), "../", dir);
        console.log(`读取文件${chalk.green.bold(__path)}`);
        //read&replace
        Functor.of(__path)
            .map(readDir)
            .map(rename(source, replacement));
    });

var babel = require("@babel/core");
// var traverse = require("@babel/traverse").default;
// var generator = require("@babel/generator").default;

cmd.command('demo')
    .action(function (cmd, source, replacement) {
        console.log(123);
        transform();
    });

cmd.command('transform')
    .option('-t, --test', 'test router').action(function (cmd, source, replacement) {
        console.log(cmd.test);
    let configContent = require(path.resolve(__dirname,".yo-rc2.json"));
    let patch = cmd.test?require('./generators/util/transfer2'):require('./generators/util/transfer');
    const {code} = babel.transform("module.exports={}",{
        // presets:["flow"],
        plugins:[patch(configContent)]});
    //     this.callback(null,code);
    // }
    console.log(code);
    // traverse(ast, {
    //     enter(path) {
    //         if (path.isAssignmentExpression()) {
    //             // console.log(path.node.specifiers.forEach(function(el,index,elms){
    //             //     console.log(el);
    //             // }));
    //             // value
    //             path.traverse({
    //                 //默认import
    //                 ObjectExpression(path){
    //                     console.log(path.insert);
    //                     path.get('body').pushContainer('body', t.expressionStatement(t.stringLiteral('after')));
    //
    //                 }
    //             })
    //             //source
    //            // console.log(path.node.source.value);
    //
    //             // path.node.name = "x";
    //         }
    //     }
    // });
    //
    // console.log(generator(ast));
});

cmd.parse(process.argv);

