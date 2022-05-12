# DPU SIG

## 使命和愿景
DPU作为一种新型可编程处理器，国内外各厂商都在布局相关能力，一般来说DPU需要满足以下要素：

- 行业标准的、高性能及软件可编程的多核通用处理器
- 高性能网络接口，高速处理及数据传输
- 种类多样的，灵活可编程的加速引擎，可以对AI、机器学习、安全、存储等进行卸载加速

DPU在未来数据中心的不同应用场景中占据越来越重要的地位. OS或软件一直都是需要跟随硬件的趋势发展的，新的硬件演进需要新的OS抽象，多样化的DPU硬件也需要专用定制化的OS及上层统一接口来发挥硬件的极致性能，并为开发者提供统一的使用视图。

## SIG工作目标和范围

### 工作目标：

我们希望能够提供一个开放的平台，集结DPU客户、开发者和DPU厂商，共同探讨DPU发展趋势和应用场景，并整合不同场景和DPU硬件提供统一的DPU软件框架。客户和开发者提供DPU使用上的场景和诉求（北向），DPU厂商提供各自差异化的硬件能力（南向），通过中间的统一软件框架制定标准黏合南北两个方向生态，北向规范并简化客户和开发者的使用接口，南向整合DPU厂商的不同硬件能力并提供规范的使用接口，降低新DPU硬件产品的开发和使用门槛。

### 工作范围：

- DPU定制化OS
- 统一用户编程框架（统一北向接口）
- 通用业务DPU卸载及加速能力
- 加速方案的标准实现（统一南向接口）
- DPU新型使用方式探索

## 组织会议

公开的会议时间：双周例会，周四上午10:00-12:00(北京时间)

会议链接：通过微信群消息和邮件列表发出

会议纪要： https://etherpad.openeuler.org/p/sig-DPU-meetings

## 成员

#### Maintainer列表

邓广兴 (@minknov)[https://gitee.com/minknov] deng_guangxing@126.com

李成 (@lic121)[https://gitee.com/lic121] lic121@chinatelecom.cn

李春辉 (@lch-lichunhui)[https://gitee.com/lch-lichunhui] xiaomo.li@huawei.com

#### 联系方式

- 邮件列表：dev@openeuler.org; tc@openeuler.org 暂时使用openEuler公共邮件列表。
- Wechat讨论群，请联系Maintainer入群


## 本项目目录结构

```
documents/			// 项目相关指导文档及手册，内部通过子目录区分项目、设计、使用等类型
quicklystart/			// 新手入门指导
projects/			// 孵化项目仓库，维护方式由两种：1. 通过git submodules维护；2. 各项目仅作为子目录存在，dpu-core的git统一管理
tools/				// 非项目仓库的使用工具
weeklyreport/			// 双周工作总结归档  - 考虑放wiki
LICENSE				// 许可证书
README				// 项目整体readme，子项目需要在该readme中有entry，子项目目录中可以有更详细的readme解释
DPU_Intro.md			// DPU相关背景介绍
members                          // 项目参与者
ROADMAP
```

## 如何贡献

欢迎开发者、用户、厂商以各种开源方式参与SIG贡献，包括但不限于：

1. 提交Issue ：如果您在对DPU使用有任何问题，可以向SIG提交ISSUE，包括不限于使用疑问、软件包BUG、特性需求等等。

2. 参与技术讨论 通过邮件列表、微信群、在线例会等方式，与SIG成员实时讨论DPU相关使用场景及技术方案等。

3. 参与SIG的方案讨论、特性设计、开发及文档撰写工作

4. 技术预研、联合创新：DPU SIG欢迎各种形式的联合创新，邀请各位开发者以开源的方式、以SIG为平台，开发DPU相关软件技术。如果您有idea或开发意愿，欢迎加入SIG。

当然，贡献形式不仅包含这些，其他任何与DPU相关、与开源相关的事务都可以带到SIG中。DPU SIG欢迎您的参与。


## Maintainer的加入和退出

秉承开源开放的理念，DPU SIG在maintainer成员的加入和退出方面应遵循以下规范和要求，下列规范要求可能随着SIG运作不断更新。

#### 如何成为Maintainer

maintainer作为SIG的直接负责人，拥有代码合入、路标规划、提名maintainer等方面的权利，同时也有软件质量看护、版本开发的义务。

如果您想成为DPU SIG的一名maintainer，需要满足以下几点要求：

1. 持续参与DPU SIG讨论、方案设计及开发贡献

2. 持续参与DPU SIG代码检视，量化标准待后续确认

3. 定时参加DPU SIG例会（一般为双周一次），单次运作周期内（运作周期待确认）缺席次数不超过30%


加分项：

1. 积极参加DPU SIG组织的各种活动，比如线上分享、线下meetup或峰会等。

2. 帮助SIG扩展运营范围，进行联合技术创新，例如主动开源新项目，吸引新的开发者、厂商加入SIG等。

#### Maintainer的退出

当SIG maintainer因为自身原因（工作变动、业务调整等原因），无法再担任maintainer一职时，可主动申请退出。

SIG maintainer在运作周期结束后例行审视当前maintainer列表，如果发现有不再适合担任maintainer的贡献者（贡献不足、不再活跃等原因），经讨论达成一致后，会向openEuler TC提出相关申请。

`其他退出条件待补充`

## 项目清单

#### 统一入口

- <https://gitee.com/openeuler/dpu-core>

DPU可能包含很多第三方项目，为方便管理、设置了统一的入口项目，相关版本及文档为通过该项目对外呈现。用户及开发者对DPU SIG及DPU各子项目有任何问题都可以在该项目中提交issue。

#### 自研项目

待补充
