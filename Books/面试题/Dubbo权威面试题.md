<b>更多面试题，干货内容，可以查看此处，从编程工具到面试要点。
全流程编程工具集&学习集 https://www.johngo689.com/2617/，欢迎留言交流！</b> 
<i>以下面试题来自网络以及自己整理，如有侵权，请及时联系删除！</i> 
 *** 
[TOC]

### 1、Dubbo 支持哪些协议，每种协议的应用场景，优缺点?
<h3>dubbo</h3><p>单一长连接和 NIO 异步通讯，适合大并发小数据量的服务调用，以及消费者远大于提供者。传输协议 TCP，异步，Hessian 序列化;</p><h3>rmi</h3><p>采用 JDK 标准的 rmi 协议实现，传输参数和返回参数对象需要实现 Serializable 接口，使用 java 标准序列化机制，使用阻塞式短连接，传输数据包大小混合，消费者和提供者个数差不多，可传文件，传输协议 TCP。多个短连接，TCP 协议传输，同步传输，适用常规的远程服务调用和 rmi 互操作。在依赖低版本的 Common-Collections 包，java 序列化存在安全漏洞;</p><h3>webservice</h3><p>基于 WebService 的远程调用协议，集成 CXF 实现，提供和原生 WebService 的互操作。多个短连接，基于 HTTP 传输，同步传输，适用系统集成和跨语言调用;</p><h3>http</h3><p>基于 Http 表单提交的远程调用协议，使用 Spring 的 HttpInvoke 实现。多个短连接，传输协议 HTTP，传入参数大小混合，提供者个数多于消费者，需要给应用程序和浏览器 JS 调用;</p><h3>hessian</h3><p>集成 Hessian 服务，基于 HTTP 通讯，采用 Servlet 暴露服务， Dubbo 内嵌 Jetty 作为服务器时默认实现，提供与 Hession 服务互操作。多个短连接，同步 HTTP 传输，Hessian 序列化，传入参数较大，提供者大于消费者，提供者压力较大，可传文件;</p><h3>memcache</h3><p>基于 memcached 实现的 RPC 协议</p><h3>redis</h3><p>基于 redis 实现的 RPC 协议</p>



### 2、Dubbo 超时时间怎样设置?
<p>Dubbo 超时时间设置有两种方式</p><ul><li>服务提供者端设置超时时间，在 Dubbo 的用户文档中，推荐如果能在服务 端多配置就尽量多配置，因为服务提供者比消费者更清楚自己提供的服务特性。</li><li>服务消费者端设置超时时间，如果在消费者端设置了超时时间，以消费者端 为主，即优先级更高。因为服务调用方设置超时时间控制性更灵活。如果消 费方超时，服务端线程不会定制，会产生警告。</li></ul>



### 3、Dubbo 有些哪些注册中心?
<h3>Multicast 注册中心</h3><p>Multicast 注册中心不需要任何中心节点，只要广播地址，就能进行服务注册和发现。基于网络中组播传输实现;</p><h3>Zookeeper 注册中心</h3><p>基于分布式协调系统 Zookeeper 实现，采用Zookeeper 的 watch 机制实现数据变更;</p><h3>redis 注册中心</h3><p>基于 redis 实现，采用 key/Map 存储，住 key 存储服务名 和类型，Map 中 key 存储服务 URL，value 服务过期时间。基于 redis 的发布/订阅模式通知数据变更; </p><h3>Simple 注册中心</h3><p>&nbsp;</p>



### 4、Dubbo 集群的负载均衡有哪些策略
<p>Dubbo 提供了常见的集群策略实现，并预扩展点予以自行实现</p><h3>Random LoadBalance</h3><p>随机选取提供者策略，有利于动态调整提供者权重。截面碰撞率高，调用次数越多，分布越均匀;</p><h3>RoundRobin LoadBalance</h3><p>轮循选取提供者策略，平均分布，但是存在请求累积的问题;</p><h3>LeastActive LoadBalance</h3><p>最少活跃调用策略，解决慢提供者接收更少的请求;</p><h3>ConstantHash LoadBalance</h3><p>一致性 Hash 策略，使相同参数请求总是发到同一提供者，一台机器宕机，可以基于虚拟节点，分摊至其他提供者，避免引起提供者的剧烈变动;</p>



### 5、Dubbo 是什么?
<p>Dubbo 是一个分布式、高性能、透明化的 RPC 服务框架，提供服务自动注册、自动发现等高效服务治理方案， 可以和 Spring 框架无缝集成。</p>



### 6、Dubbo 的主要应用场景?
<ul><li>透明化的远程方法调用，就像调用本地方法一样调用远程方法，只需简单配置，没有任何 API 侵入。</li><li>软负载均衡及容错机制，可在内网替代 F5等硬件负载均衡器，降低成本，减少单点。</li><li>服务自动注册与发现，不再需要写死服务提供方地址，注册中心基于接口名查询服务提供者的 IP 地址，并且能够平滑添加或删除服务提供者</li></ul>



### 7、Dubbo 的核心功能?
<p>主要就是如下3个核心功能:</p><h3>Remoting</h3><p>网络通信框架，提供对多种NIO框架抽象封装，包括“同步转异步”和“请求-响应”模式的信息交换方式。</p><h3>Cluster</h3><p>服务框架，提供基于接口方法的透明远程过程调用，包括多协议支持，以及软负载均衡，失败容错，地址路由，动态配置等集群支持。</p><h3>Registry</h3><p>服务注册，基于注册中心目录服务，使服务消费方能动态的查找服务提供方，使地址透明，使服务提供方可以平滑增加或减少机器</p>



### 8、Dubbo 服务注册与发现的流程?
<p><img src="https://www.johngo689.com/wp-content/uploads/member/avatars/dubbo1.jpg" alt="dubbo1" /></p><p>&nbsp;</p><h3>流程说明</h3><ul><li>Provider(提供者)绑定指定端口并启动服务</li><li>指供者连接注册中心，并发本机IP、端口、应用信息和提供服务信息发送至注册中心存储</li><li>Consumer(消费者)，连接注册中心，并发送应用信息、所求服务信息至注册中心</li><li>注册中心根据消费者所求服务信息匹配对应的提供者列表发送至Consumer 应用缓存。</li><li>Consumer 在发起远程调用时基于缓存的消费者列表择其一发起调用。</li><li>Provider 状态变更会实时通知注册中心、在由注册中心实时推送至Consumer</li></ul><h3>设计的原因</h3><ul><li>Consumer 与 Provider 解偶，双方都可以横向增减节点数。</li><li>注册中心对本身可做对等集群，可动态增减节点，并且任意一台宕掉后，将自动切换到另一台</li><li>去中心化，双方不直接依懒注册中心，即使注册中心全部宕机短时间内也不会影响服务的调用</li><li>服务提供者无状态，任意一台宕掉后，不影响使用</li></ul>



### 9、Dubbo 的架构设计?
<h2><img src="https://www.johngo689.com/wp-content/uploads/member/avatars/dobbp3.jpg" alt="dobbp3" /></h2><h2>Dubbo 框架设计一共划分了 10 个层</h2><ul><li>服务接口层(Service):该层是与实际业务逻辑相关的，根据服务提供方和服务消费方的业务设计对应的接口和实现。</li><li>配置层(Config):对外配置接口，以ServiceConfig和 ReferenceConfig 为中心。</li><li>服务代理层(Proxy):服务接口透明代理，生成服务的客户端Stub 和服务器端 Skeleton。</li><li>服务注册层(Registry):封装服务地址的注册与发现，以服务URL 为中心。</li><li>集群层(Cluster):封装多个提供者的路由及负载均衡，并桥接注册中心，以 Invoker 为中心。</li><li>监控层(Monitor):RPC调用次数和调用时间监控。</li><li>远程调用层(Protocol):封将RPC调用，以Invocation和Result为中心，扩展接口为 Protocol、Invoker 和 Exporter。</li><li>信息交换层(Exchange):封装请求响应模式，同步转异步，以Request 和 Response 为中心。</li><li>网络传输层(Transport):抽象mina和netty为统一接口，以Message 为中心。</li></ul>



### 10、dubbo 推荐用什么协议?
<p>默认使用 dubbo 协议</p>



### 11、Dubbo 默认采用注册中心?
<p>采用 Zookeeper</p>



### 12、Dubbo 的注册中心集群挂掉，发布者和订阅者之间还能通信么?
<p>可以的，启动 dubbo 时，消费者会从 zookeeper 拉取注册的生产者 的地址接口等数据，缓存在本地。</p><p>每次调用时，按照本地存储的地址进行调用。</p>



### 13、Dubbo 与 Spring 的关系?
<p>Dubbo 采用全 Spring 配置方式，透明化接入应用，对应用没有任何 API 侵入，只需用 Spring 加载 Dubbo 的配置即可，Dubbo 基于 Spring 的 Schema 扩展进行加载。</p>



### 14、Dubbo 使用的是什么通信框架?
<p>默认使用 NIO Netty 框架</p>



### 15、Dubbo 集群提供了哪些负载均衡策略?
<ul><li>Random LoadBalance:随机选取提供者策略，有利于动态调整提供者权重。截面碰撞率高，调用次数越多，分布越均匀;</li><li>RoundRobin LoadBalance:轮循选取提供者策略，平均分布，但是存在请求累积的问题;</li><li>LeastActive LoadBalance:最少活跃调用策略，解决慢提供者接收更少的请求;</li><li>ConstantHash LoadBalance:一致性 Hash 策略，使相同参数请求总是发到同一提供者，一台机器宕机，可以基于虚拟节点，分摊至其他提供者，避免引起提供者的剧烈变动;<br />缺省时为 Random 随机调用</li></ul>


