const yeoman = require('yeoman-environment');
const chalk = require("chalk");
const fs = require("fs");
const path = require("path");
const initGenerator = require('../generators/init-generator');
const transform = require('../generators/util/transform');
const rimraf = require('rimraf');
const gitClone = require('gitclone');
const spawn = require('cross-spawn');
const ora = require('ora');
const shell = require('shelljs');

let cloneProject = function(name){
    const gitBoilerplateUrl = 'https://github.com/randoll127/allin-webpack-boilerplate.git';
    return new Promise(function(resolve,reject){
        gitClone(gitBoilerplateUrl,{"dest": name },(err) => {
            if (err) reject(false);
            else resolve(true);
        });
    });
}



module.exports = function (projectName) {
    if(!projectName) projectName="demo";
    let __init = async function(name){
        let loading = ora(`git clone  ${name}`).start();
        let ret = await cloneProject(name);
        if(ret){
            loading.succeed(`git clone  ${name} success!`);
            shell.cd(name);
            rimraf.sync(path.resolve(process.cwd(),".yo-rc.json"));
            //创建yeoman env
            var env = yeoman.createEnv();
            env.registerStub(initGenerator, 'webpack:init');
            //执行init并且转换
            env.run('webpack:init').on("end", transform);

            //安装依赖包
            spawn.sync("npm",["install"],{stdio: 'inherit'});
        }else{
            loading.fail("git clone failed");
        }
    };

    __init(projectName);



}