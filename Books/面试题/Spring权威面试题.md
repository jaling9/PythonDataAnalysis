<b>更多面试题，干货内容，可以查看此处，从编程工具到面试要点。
全流程编程工具集&学习集 https://www.johngo689.com/2617/，欢迎留言交流！</b> 
<i>以下面试题来自网络以及自己整理，如有侵权，请及时联系删除！</i> 
 *** 
[TOC]

### 1、什么是 Spring 框架?Spring 框架有哪些主要模块?
<p>Spring 框架是一个为 Java 应用程序的开发提供了综合、广泛 的基础性支持的 Java 平台。Spring 帮助开发者解决了开发中 基础性的问题，使得开发人员可以专注于应用程序的开发。 Spring 框架本身亦是按照设计模式精心打造，这使得我们可 以在开发环境中安心的集成 Spring 框架，不必担心 Spring 是 如何在后台进行工作的。</p><p>Spring 框架至今已集成了 20 多个模块。这些模块主要被分如 下图所示的核心容器、数据访问/集成,、Web、AOP(面向切 面编程)、工具、消息和测试模块。</p><ul><li>核心模块包括：core、beans、context、context-support、expression共5个模块；</li><li>AOP模块包括：aop、aspects、instrument共3个模块；</li><li>数据访问模块包括：jdbc、tx、orm、oxm共4个模块；</li><li>Web模块包括：web、webmvc、websocket、webflux共4个模块；</li><li>集成测试模块：test模块。</li></ul><p>&nbsp;</p>



### 2、SpringBoot 运行项目的几种方式?
<p>打包用命令或者放到容器中运行<br />1、 打成 jar 包，使用 java -jar xxx.jar 运行<br />2、 打成 war 包，放到 tomcat 里面运行<br />直接用 maven 插件运行 maven spring-boot:run 直接执行 main 方法运行</p>



### 3、IOC 的优点是什么?
<p>IOC 或 依赖注入把应用的代码量降到最低。它使应用容易测试，单元测试不再需要单例和 JNDI 查找机制。最小的代价和最小的侵入性使松散耦合得以实 现。IOC 容器支持加载服务时的饿汉式初始化和懒加载。</p>



### 4、在 Spring MVC 应用程序中使用 WebMvcTest 注释有什么用 处?
<p>WebMvcTest 注释用于单元测试 Spring MVC 应用程序。我们只想启动 ToTestController。执行此单元测试时，不会启动所有其他控制器和映射。</p><p>@WebMvcTest(value = ToTestController.class, secure = false):</p>



### 5、什么是 Spring Cloud?
<p>根据 Spring Cloud 的官方网站，Spring Cloud 为开发人员提供了快速构建分 布式系统中一些常见模式的工具(例如配置管理，服务发现，断路器，智能路 由，领导选举，分布式会话，集群状态)。</p>



### 6、eureka 服务注册与发现原理
<ul><li>每 30s 发送心跳检测重新进行租约，如果客户端不能多次更新租约，它将在 90s 内从服务器注册中心移除。</li><li>注册信息和更新会被复制到其他 Eureka 节点，来自任何区域的客户端可以查找到注册中心信息，每 30s 发生一次复制来定位他们的服务，并进行 远程调用。</li><li>客户端还可以缓存一些服务实例信息，所以即使 Eureka 全挂掉，客户端也是可以定位到服务地址的。</li></ul><p><img class="" src="https://www.johngo689.com/wp-content/uploads/member/avatars/spring-1.jpg" alt="spring-1" width="553" height="336" /></p>



### 7、SpringBoot 配置文件的加载顺序
<p>由 jar 包外向 jar 包内进行寻找<br />优先加载带 profile<br />jar 包外部的 application-{profile}.properties 或 application.yml(带 spring.profile 配置文件<br />jar 包内部的 application-{profile}.properties 或 application.yml(带 spring.profile 配置文件<br />再来加载不带 profile<br />jar 包外部的 application.properties 或 application.yml(不带 spring.profile 配置文件<br />jar 包内部的 application.properties 或 application.yml(不带 spring.profile 配置文件</p>



### 8、什么是 spring 装配
<p>当 bean 在 Spring 容器中组合在一起时，它被称为装配或 bean 装配。</p><p>Spring 容器需要知道需要什么 bean 以及容器应该如何使用依赖注入来将 bean 绑定在一起，同时装配 bean。</p>



### 9、为什么要用 SpringBoot
<p>快速开发，快速整合，配置简化、内嵌服务容器。</p>



### 10、怎么样把 ModelMap 里面的数据放入 Session 里面?
<p>可以在类上面加上@SessionAttributes 注解,里面包含的字符串就是要放入 session 里面的 key。</p>



### 11、什么是微服务架构中的 DRY?
<p>DRY 代表不要重复自己。它基本上促进了重用代码的概念。这导致开发和共享库，这反过来导致紧密耦合。</p>



### 12、使用 Spring 框架能带来哪些好处?
<p>下面列举了一些使用 Spring 框架带来的主要好处:</p><ul><li>Dependency Injection(DI) 方法使得构造器和 JavaBean properties 文件中的依赖关系一目了然。</li><li>与 EJB 容器相比较，IoC 容器更加趋向于轻量级。这样一来 IoC 容器在有限的内存和 CPU 资源的情况下进行应用程序的 开发和发布就变得十分有利。</li><li>Spring 并没有闭门造车，Spring 利用了已有的技术比如 ORM 框架、logging 框架、J2EE、Quartz 和 JDK Timer，以 及其他视图技术。</li><li>Spring 框架是按照模块的形式来组织的。由包和类的编号就 可以看出其所属的模块，开发者仅仅需要选用他们需要的模块 即可。</li><li>要测试一项用 Spring 开发的应用程序十分简单，因为测试相 关的环境代码都已经囊括在框架中了。更加简单的是，利用 JavaBean 形式的 POJO 类，可以很方便的利用依赖注入来写 入测试数据。</li><li>Spring 的 Web 框架亦是一个精心设计的 Web MVC 框架，为 开发者们在 web 框架的选择上提供了一个除了主流框架比如 Struts、过度设计的、不流行 web 框架的以外的有力选项。</li><li>Spring 提供了一个便捷的事务管理接口，适用于小型的本地 事物处理(比如在单 DB 的环境下)和复杂的共同事物处理 (比如利用 JTA 的复杂 DB 环境)。</li></ul>



### 13、什么是控制反转(IOC)?什么是依赖注入?
<h3>控制反转</h3><ol><li>控制反转是应用于软件工程领域中的，在运行时被装配器对象 来绑定耦合对象的一种编程技巧，对象之间耦合关系在编译时 通常是未知的。在传统的编程方式中，业务逻辑的流程是由应 用程序中的早已被设定好关联关系的对象来决定的。在使用控<br />制反转的情况下，业务逻辑的流程是由对象关系图来决定的， 该对象关系图由装配器负责实例化，这种实现方式还可以将对 象之间的关联关系的定义抽象化。而绑定的过程是通过“依赖 注入”实现的。</li><li>控制反转是一种以给予应用程序中目标组件更多控制为目的设 计范式，并在我们的实际工作中起到了有效的作用。</li><li>依赖注入是在编译阶段尚未知所需的功能是来自哪个的类的情 况下，将其他对象所依赖的功能对象实例化的模式。这就需要 一种机制用来激活相应的组件以提供特定的功能，所以依赖注 入是控制反转的基础。否则如果在组件不受框架控制的情况 下，框架又怎么知道要创建哪个组件?</li></ol><h3>依赖注入</h3><p>在 Java 中依然注入有以下三种实现方式:<br />1. 构造器注入<br />2. Setter 方法注入 3. 接口注入</p>



### 14、请解释下 Spring 框架中的 IoC?
<ul><li>Spring 中的 org.springframework.beans 包和 org.springframework.context 包构成了 Spring 框架 IoC 容器的基础。</li><li>BeanFactory 接口提供了一个先进的配置机制，使得任何类 型的对象的配置成为可能。ApplicationContex 接口对 BeanFactory(是一个子接口)进行了扩展，在 BeanFactory 的基础上添加了其他功能，比如与 Spring 的 AOP 更容易集 成，也提供了处理 message resource 的机制(用于国际 化)、事件传播以及应用层的特别配置，比如针对 Web 应用 的 WebApplicationContext。</li><li>org.springframework.beans.factory.BeanFactory 是 Spring IoC 容器的具体实现，用来包装和管理前面提到的各种 bean。BeanFactory 接口是 Spring IoC 容器的核心接口。</li></ul>



### 15、Spring 有几种配置方式?
<p>将 Spring 配置到应用开发中有以下三种方式:</p><p>1. 基于 XML 的配置</p><p>2. 基于注解的配置</p><p>3. 基于 Java 的配置</p>



### 16、Spring Bean 的作用域之间有什么区别?
<p><br />Spring 容器中的 bean 可以分为 5 个范围。所有范围的名称都是自说明的，但是为了避免混淆，还是让我们来解释一下:</p><p>1. singleton:这种 bean 范围是默认的，这种范围确保不管接受到多少个请求，每个容器中只有一个 bean 的实例，单例的模 式由 bean factory 自身来维护。</p><p>2. prototype:原形范围与单例范围相反，为每一个 bean 请求 提供一个实例。</p><p>3. request:在请求 bean 范围内会每一个来自客户端的网络请 求创建一个实例，在请求完成以后，bean 会失效并被垃圾回收器回收。</p><p>4. Session:与请求范围类似，确保每个 session 中有一个 bean 的实例，在 session 过期后，bean 会随之失效。</p><p>5. global-session:global-session 和 Portlet 应用相关。当你 的应用部署在 Portlet 容器中工作时，它包含很多 portlet。如 果你想要声明让所有的 portlet 共用全局的存储变量的话，那 么这全局变量需要存储在 global-session 中。</p><p>全局作用域与 Servlet 中的 session 作用域效果相同。</p><p><em>更多内容请参考 : Spring Bean Scopes。</em></p>



### 17、Spring 框架中的单例 Beans 是线程安全的么?
<ul><li>Spring 框架并没有对单例 bean 进行任何多线程的封装处理。 关于单例 bean 的线程安全和并发问题需要开发者自行去搞 定。但实际上，大部分的 Spring bean 并没有可变的状态(比 如 Serview 类和 DAO 类)，所以在某种程度上说 Spring 的单 例 bean 是线程安全的。如果你的 bean 有多种状态的话(比 如 View Model 对象)，就需要自行保证线程安全。</li><li>最浅显的解决办法就是将多态 bean 的作用域由“singleton” 变更为“prototype”。</li></ul>



### 18、请解释自动装配模式的区别?
<p>在 Spring 框架中共有 5 种自动装配，让我们逐一分析。</p><ul><li>no:这是 Spring 框架的默认设置，在该设置下自动装配是关 闭的，开发者需要自行在 bean 定义中用标签明确的设置依赖 关系。</li><li>byName:该选项可以根据 bean 名称设置依赖关系。当向一 个 bean 中自动装配一个属性时，容器将根据 bean 的名称自 动在在配置文件中查询一个匹配的 bean。如果找到的话，就 装配这个属性，如果没找到的话就报错。</li><li>byType:该选项可以根据 bean 类型设置依赖关系。当向一个 bean 中自动装配一个属性时，容器将根据 bean 的类型自动 在在配置文件中查询一个匹配的 bean。如果找到的话，就装 配这个属性，如果没找到的话就报错。</li><li>constructor:造器的自动装配和 byType 模式类似，但是仅 仅适用于与有构造器相同参数的 bean，如果在容器中没有找 到与构造器参数类型一致的 bean，那么将会抛出异常。</li><li>autodetect:该模式自动探测使用构造器自动装配或者 byType 自动装配。首先，首先会尝试找合适的带参数的构造 器，如果找到的话就是用构造器自动装配，如果在 bean 内部 没有找到相应的构造器或者是无参构造器，容器就会自动选择 byTpe 的自动装配方式。</li></ul>



### 19、FileSystemResource 和 ClassPathResource 有何区别?
<p>在 FileSystemResource 中需要给出 spring-config.xml 文件 在你项目中的相对路径或者绝对路径。在 ClassPathResource 中 spring 会在 ClassPath 中自动搜寻配置文件，所以要把ClassPathResource 文件放在 ClassPath 下。</p><p>如果将 spring-config.xml 保存在了 src 文件夹下的话，只需 给出配置文件的名称即可，因为 src 文件夹是默认。</p><p>简而言之，ClassPathResource 在环境变量中读取配置文件， FileSystemResource 在配置文件中读取配置文件。</p>



### 20、Spring 框架中都用到了哪些设计模式?
<p>Spring 框架中使用到了大量的设计模式，下面列举了比较有代表性的:</p><ol><li>代理模式—在 AOP 和 remoting 中被用的比较多。</li><li>单例模式—在 spring 配置文件中定义的 bean 默认为单例模 式。</li><li>模板方法—用来解决代码重复的问题。比如. RestTemplate, JmsTemplate, JpaTemplate。</li><li>前端控制器—Spring 提供了 DispatcherServlet 来对请求进行 分发。</li><li>视图帮助(View Helper )—Spring 提供了一系列的 JSP 标签， 高效宏来辅助将分散的代码整合在视图里。</li><li>依赖注入—贯穿于 BeanFactory / ApplicationContext 接口 的核心理念。</li><li>工厂模式—BeanFactory 用来创建对象的实例。</li></ol>



### 21、谈谈你对 spring IOC 和 DI 的理解，它们有什么区别?
<h3>IoC Inverse of Control 反转控制的概念</h3><p>就是将原本在程序中手动创建 UserService 对象的控 制权，交由 Spring框架管理，简单说，就是创 建 UserService 对象控制权被反转到了 Spring 框架</p><h3>DI</h3><p>Dependency Injection 依 赖 注 入 ， 在 Spring 框架负责创建 Bean 对象时，动态的将依 赖对象注入到 Bean 组件</p><p>即：</p><p>IoC 控制反转，指将对象的创建权，反转到 Spring 容器 ， DI 依赖注入，指 Spring 创建 对象的过程中，将对象依赖属性通过配置进行注 入</p>



### 22、Bean 注入属性有哪几种方式?
<p>spring 支持构造器注入和 setter 方法注入</p><ul><li>构造器注入，通过元素完成注入</li><li>setter方法注入， 通过元素完成注入【开发中常用方式】</li></ul>



### 23、什么是 AOP，AOP 的作用是什么?
<p>面向切面编程(AOP)提供另外一种角度来思考 程序结构，通过这种方式弥补了面向对象编程 (OOP)的不足，除了类(classes)以外，AOP 提供了切面。切面对关注点进行模块化，例如横 切多个类型和对象的事务管理</p><p>Spring 的一个关键的组件就是 AOP 框架，可以 自由选择是否使用 AOP 提供声明式企业服务， 特别是为了替代 EJB声明式服务。最重要的服务 是声明性事务管理，这个服务建立在 Spring的 抽象事物管理之上。允许用户实现自定义切面， 用 AOP 来完善 OOP 的使用,可以把 Spring AOP 看作是对 Spring 的一种增强</p>



### 24、Spring 的核心类有哪些，各有什么作用
<h3>BeanFactory</h3><p>产生一个新的实例，可以实现单 例模式</p><h3>BeanWrapper</h3><p>提供统一的 get 及 set 方法</p><h3>ApplicationContext</h3><p>提供框架的实现，包括BeanFactory 的所有功能</p>



### 25、Spring 如何处理线程并发问题?
<ol><li>Spring 使用 ThreadLocal 解决线程安全问题</li><li>我们知道在一般情况下，只有无状态的 Bean才可以在多线程环境下共享，在 Spring中，绝大 部分 Bean 都可以声明为 singleton 作用域。就 是因为 Spring 对一些 Bean(如 RequestContextHolder、 TransactionSynchronizationManager、 LocaleContextHolder等)中非线程安全状态采 用 ThreadLocal 进行处理，让它们也成为线程安 全的状态，因为有状态的 Bean就可以在多线程 中共享了。</li><li>ThreadLocal 和线程同步机制都是为了解决多线 程中相同变量的访问冲突问题。</li><li>在同步机制中，通过对象的锁机制保证同一时间 只有一个线程访问变量。这时该变量是多个线程共享的，使用同步机制要求程序慎密地分析什么 时候对变量进行读写，什么时候需要锁定某个对 象，什么时候释放对象锁等繁杂的问题，程序设 计和编写难度相对较大。</li><li>而 ThreadLocal 则从另一个角度来解决多线程的 并发访问。ThreadLocal 会为每一个线程提供一 个独立的变量副本，从而隔离了多个线程对数据 的访问冲突。因为每一个线程都拥有自己的变量 副本，从而也就没有必要对该变量进行同步了。 ThreadLocal 提供了线程安全的共享对象，在编 写多线程代码时，可以把不安全的变量封装进 ThreadLocal。</li><li>由于 ThreadLocal 中可以持有任何类型的对象， 低版本 JDK 所提供的 get()返回的是 Object 对 象，需要强制类型转换。但 JDK5.0通过泛型很 好的解决了这个问题，在一定程度地简化 ThreadLocal 的 使 用 。</li><li>概括起来说，对于多线程资源共享的问题，同步 机制采用了“以时间换空间”的方式，而 ThreadLocal 采用了“以空间换时间”的方式。 前者仅提供一份变量，让不同的线程排队访问，而后者为每一个线程都提供了一份变量，因此可 以同时访问而互不影响。</li></ol>


