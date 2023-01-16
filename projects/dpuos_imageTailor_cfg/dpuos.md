# 基于OpenEuler裁剪DPUOS

本手册主要介绍如何使用`imageTailor`并结合本仓库的`dpuos`配置文件如何裁剪得到`dpuos`的安装镜像，具体步骤如下：

## 准备imageTailor和所需的rpm包
参照`https://docs.openeuler.org/zh/docs/22.03_LTS/docs/TailorCustom/imageTailor-%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97.html`安装好`imageTailor`工具并将裁剪所要用到的rpm包准备好。
镜像`openEuler-22.03-LTS-everything-debug-aarch64-dvd.iso`中的rpm比较全但是此镜像很大，可以用镜像`openEuler-22.03-LTS-aarch64-dvd.iso`中的rpm包外加一个`install-scripts.noarch`（从everything镜像中获取）就可以了。

## 拷贝dpuos相关的配置文件
`imageTailor`工具默认安装在`/opt/imageTailor`路径下，执行那个下面的命令将`dpuos`的配置拷贝到对应的路径下
```bash
cp -rf custom/cfg_dpuos /opt/imageTailor/custom
cp -rf kiwi/minios/cfg_dpuos /opt/imageTailor/kiwi/minios/cfg_dpuos
```

## 修改其他配置文件
1. 修改`kiwi/eulerkiwi/product.conf`增加名称为`dpuos`的相关配置
2. 修改`kiwi/eulerkiwi/minios.conf`增加名称为`dpuos`的相关配置
3. 修改`repos/RepositoryRule.conf`增加名称为`dpuos`的相关配置

## 设置密码
进入到`conf/aarch64`子目录下，修改下面3个文件的密码，详见openEuler手册
1. `custom/cfg_dpuos/usr_file/etc/default/grub`
2. `custom/cfg_dpuos/rpm.conf`
3. `kiwi/minios/cfg_minios/rpm.conf`

## 执行裁剪命令
执行下面的命令进行裁剪，最后裁剪出来的iso在路径`/opt/imageTailor/result`路径下
```bash
cd /opt/imageTailor
./mkdliso -p dpuos -c custom/cfg_dpuos --sec --minios force
```
