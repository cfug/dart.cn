---
# title: "Life as a Dart intern"
title: "Dart 实习生生活"
# description: "In this companion post to “Dart declaration-site variance”, hear about an intern‘s experience with Google’s Dart team."
description: "作为“Dart 声明处型变”的姊妹篇，听听一位实习生在 Google Dart 团队的经历。"
ai-translated: true
publishDate: 2019-12-19
author: kallentu
image: images/06Ct-NyRGmYp_bmgp.webp
category: other
layout: blog
---


*I don’t know.*

*我不知道。*

Those three words run through the minds of software engineers every day. Engineering work consists of puzzles and problems, so not knowing something is just another indicator that an engineer has the capacity to grow. Yet, the lack of knowledge can also generate self-doubt.

这三个字每天都会闪过软件工程师的脑海。工程工作由谜题和问题组成，所以不知道某件事恰恰说明工程师还有成长空间。然而，知识的欠缺也会带来自我怀疑。

Before I started my internship this fall, I didn’t know much about programming languages, type systems, or even variance (which was my entire project). As far as I knew, variance was just a value I needed to calculate the square root of, so I could obtain a standard deviation. Programming languages and compilers seemed like some black magic sorcery that mystified most developers.

今年秋天开始实习之前，我对编程语言、类型系统、甚至型变（variance，我的整个项目）都知之甚少。在我的认知里，variance 只是一个需要开平方根来求标准差的值（方差）。编程语言和编译器就像某种黑魔法，让大多数开发者望而生畏。

Thankfully my manager, being the mind reader that he was, understood how I felt and remedied my nervousness.

幸运的是，我的经理像个读心者一样理解了我的感受，缓解了我的紧张。

*“So, I’m going to be completely honest, this project will throw you completely into the deep end. You don’t know anything yet, but that’s okay because I want you to ask questions, lots of them,”* he explained.

*“这么说吧，我完全坦白地讲，这个项目会把你直接扔进深水区。你现在什么都不懂，但没关系，因为我希望你提问，大量地提问，”*他解释道。

It was scary going head-first into a new project where I had little-to-no background knowledge of the work, but I knew I had support from my manager. He gave me the freedom to *try*, the freedom to *make mistakes*. It meant a lot to me.

一头扎进一个几乎没有背景知识的新项目确实吓人，但我知道有经理的支持。他给了我*尝试*的自由、*犯错*的自由。这对我意义重大。

That quick chat with my manager jump-started the first month of my time here: I met my team in Fremont Seattle and was ready to throw myself into this deep unknown called *variance,* which you can read about in the article [Dart declaration-site variance](/blog/dart-declaration-site-variance).

与经理的简短谈话启动了我在这里的第一个月：我在西雅图弗里蒙特见到了团队，准备投身这个叫*型变*的未知深水区，你可以在 [Dart declaration-site variance](/blog/dart-declaration-site-variance) 一文中读到相关内容。

I had weekly variance boot camps with my manager, providing me with the theory that I had to translate into code. I remember reading the proposal of the [variance feature](https://github.com/dart-lang/language/issues/524) that I would be implementing and feeling overwhelmed at the seven milestones required to complete the project: (1) scan then parse the new keywords, (2) modify the kernel AST, (3) support variance in the subtyping algorithm, (4) add errors and warnings, (5) change the upper and lower bound calculation, (6) alter the type inference rules, and (7) work on the runtime behaviour changes.

我每周和经理进行型变“集训”，他提供理论，我负责转化为代码。我记得读我将要实现的[型变特性](https://github.com/dart-lang/language/issues/524)提案时，被完成项目所需的七个里程碑压得喘不过气：(1) 扫描并解析新关键字，(2) 修改 kernel AST，(3) 在子类型算法中支持型变，(4) 添加错误和警告，(5) 修改上下界计算，(6) 调整类型推断规则，(7) 处理运行时行为变更。

Between changing the kernel (the compiler’s intermediate representation) and the subtyping logic, I needed to serialize and deserialize variance annotations. Runtime behaviour was considered a stretch goal, but I could barely understand the six tasks before it. I wasn’t sure where or how to begin.

在修改 kernel（编译器的中间表示）和子类型逻辑之间，我还需要对型变注解做序列化和反序列化。运行时行为被视为挑战目标，但前面六个任务我都几乎还没理解。我不确定从哪里、如何开始。

But it got better.

但情况慢慢好转了。

I started each workday at 9 am. Scrambled eggs, sausages, kale, and orange juice were all I needed. I was ready to squint at code, wondering how in the world people made the first compiler.

我每天早上 9 点开始工作。炒蛋、香肠、羽衣甘蓝和橙汁就是我所需的一切。我准备好眯着眼盯代码，琢磨人们到底是怎么造出第一个编译器的。

I often worked on different components in parallel with one another. It kept me busy and I enjoyed organizing goals. Every morning I would create a new document that would list out what I wanted to accomplish, breaking down the goals into manageable tasks.

我经常并行推进不同组件的工作。这让我很充实，我也喜欢组织目标。每天早上我都会新建一个文档，列出想完成的事情，把目标拆解成可管理的任务。

<DashImage src="images/06Ct-NyRGmYp_bmgp.webp" alt="October 31 to-do list for variance work with many tasks crossed out and links to landed changes." caption="A typical to-do list" />


At night, the Google office in Aarhus, Denmark, was active. Knowing that I had to work with a couple of engineers from Denmark, I often wrote up my questions, finalized them and sent them off late at night in Seattle. Code review times shifted forward 9 hours, but fortunately the time offset also let me proofread my own work more often before it was critiqued.

到了晚上，丹麦奥胡斯的 Google 办公室正值活跃时段。知道要和几位丹麦工程师协作，我常常在西雅图的深夜写好问题、整理定稿再发出去。代码评审时间提前了 9 个小时，但幸运的是，时差也让我在被评审之前有更多机会自查自己的工作。

The critique from the team improved my ability to judge my own code and to contemplate the trade offs for different implementations. My reviewers pointed out areas I overlooked and asked questions about what variance is and how to use it. I’d fix my code, answer their questions, and make sure to watch out for the same issues in the future. More importantly, I’d dig deeper and ask myself, *How did they think of this improvement? What piece of knowledge can I take away from this, more than the corrected version of the code?* It was important to me that I learned from each comment, rather than mindlessly clicking the convenient **Done** button.

团队的评审提升了我判断自己代码、权衡不同实现取舍的能力。评审者指出我忽略的地方，并提出关于型变是什么、如何使用的问题。我会修正代码、回答问题，并确保以后注意同样的问题。更重要的是，我会深挖并问自己：*他们是怎么想到这个改进的？除了修正后的代码，我还能从中带走什么知识？*对我来说，从每条评论中学习很重要，而不是无脑点击方便的 **Done** 按钮。

How I learned was through asking questions. There’s always a fragile balance between being a stubborn software engineer by gritting your teeth and grinding through code that doesn’t make any sense, and reluctantly poking the expert in that code base to help you. The latter almost always saved more time. I preferred allocating a decent amount of time to working independently, taking notes and writing questions as I came across new areas, then prodding another engineer when I had 2 or 3 questions and a solid roadblock. I realized I was much more productive inquiring about problems that would have required 3 hours of troubleshooting alone, compared to 10 minutes of direction and explanation from someone else.

我的学习方式是提问。在咬牙硬啃看不懂的代码的固执工程师，和不情愿地去戳代码库专家求助之间，总有一种微妙的平衡。后者几乎总是更省时间。我倾向于先分配相当多的时间独立工作，遇到新领域时记笔记、写问题，攒到两三个问题且确实卡住时再去请教另一位工程师。我意识到，对于独自排查需要 3 小时的问题，别人 10 分钟的指点和讲解能让我的效率高得多。

Safety in a workplace also increases productivity.

职场中的安全感也能提升生产力。

Safety, for me, came in the form of asking questions, making jokes, and having lunch with the team. As soon as the clock flickered to 11:30, I knew that the next half hour would be filled with warm food and bright faces. Every day I would listen to the most elaborate stories and thoughts: the advantages of having 6 fingers, getting a cooked lobster as a Christmas gift, the hours of cleanup after mixing two different pipes in Factorio… anything and everything. My team supported me through my mistakes and my accomplishments. A good team makes it a lot easier to get out of bed in the morning to go to work.

对我来说，安全感来自提问、开玩笑和与团队共进午餐。时钟一到 11:30，我就知道接下来半小时会有热腾腾的食物和灿烂的笑脸。每天我都会听到最精彩的故事和想法：有 6 根手指的好处、收到煮龙虾作圣诞礼物、在 Factorio 里混接两种管道后清理数小时……天南海北，无所不聊。无论我犯错还是取得成就，团队都支持我。一个好团队让早上起床去上班容易得多。

The hours before and after lunch were also just as enjoyable. I spent most of the time reading code and understanding new concepts. The Dart compiler is comprised of many large, constantly changing components, which meant I needed to dive into a few different code bases. I loved having the opportunity to reach out to the front-end teams in charge of the static analysis, as well as the back-end teams who managed runtime behaviours. It was amazing to see how the components work together to create a new feature in the Dart language.

午餐前后的时光同样愉快。我大部分时间都在读代码、理解新概念。Dart 编译器由许多庞大且不断变化的组件组成，这意味着我需要深入几个不同的代码库。我很喜欢有机会联系负责静态分析的前端团队，以及管理运行时行为的后端团队。看到各组件如何协作为 Dart 语言创造新特性，真是令人惊叹。

The rift between implementation and theory was the most challenging aspect of my project. It’s not every day that one would need to solidify a proof into tangible code. While working on variance, this rift surfaced when I had questions — sometimes my inquiries weaved the components of the language proposal with an appropriate implementation. The people I sought for answers either knew which file contained the subtyping algorithm, or knew how the subtyping changes affected assignment operations, but never both. It felt like building a treehouse with a couple pieces of plywood and an artist’s rendition of the end result.

实现与理论之间的鸿沟是我项目中最大的挑战。不是每天都有人需要把证明落实成实实在在代码。做型变时，这道鸿沟在我提问时显现——有时我的问题交织着语言提案的各个部分与相应的实现。我求助的人要么知道子类型算法在哪个文件，要么知道子类型变更如何影响赋值操作，但从没有人两者都知道。那感觉就像拿着几块胶合板和一张艺术家画的效果图去建树屋。

Still, working on Dart was immensely rewarding and fun. I loved the challenge, especially knowing that there was so much to learn about areas beyond variance. Dart was, and still is, growing and evolving to better support the developers that use the language. I watched the team move like well-tuned clockwork when crucial issues surfaced and required immediate attention. I listened in as the team looked back on previous mistakes, ensuring that future processes don’t repeat them.

尽管如此，参与 Dart 的工作回报巨大且充满乐趣。我喜欢这种挑战，尤其是知道型变之外还有那么多领域可以学习。Dart 过去和现在都在成长演进，以更好地支持使用这门语言的开发者。我看到当关键问题出现、需要立即处理时，团队像调校精准的钟表一样运转。我也旁听团队复盘过去的错误，确保未来的流程不再重蹈覆辙。

My internship on the Dart team improved my engineering skills, my communication skills, and my confidence in my own abilities. It taught me the importance of having a friendly, but also very functional team. It taught me the many ways that theory can translate into code, and the problem-solving techniques necessary to do so. It taught me more about myself and what I value in the work I do.

在 Dart 团队的实习提升了我的工程技能、沟通能力，以及对自己能力的信心。它让我明白拥有一个既友好又高效运转的团队有多重要。它教会我理论转化为代码的多种方式，以及所需的问题解决技巧。它让我更了解自己，以及我在工作中看重什么。

Thanks Dart. Until next time.

谢谢你，Dart。下次再见。
