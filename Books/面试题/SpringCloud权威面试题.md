<b>更多面试题，干货内容，可以查看此处，从编程工具到面试要点。
全流程编程工具集&学习集 https://www.johngo689.com/2617/，欢迎留言交流！</b> 
<i>以下面试题来自网络以及自己整理，如有侵权，请及时联系删除！</i> 
 *** 
[TOC]

### 1、设计微服务的最佳实践是什么?
<p>以下是设计微服务的最佳实践:</p><p><img class="" src="https://www.johngo689.com/wp-content/uploads/member/avatars/spring-cloud-1.jpg" alt="spring-cloud-1" width="522" height="287" /></p>



### 2、什么是 REST / RESTful 以及它的用途是什么?
<p>Representational State Transfer(REST)/ RESTful Web 服务是一种帮助计算 机系统通过 Internet 进行通信的架构风格。这使得微服务更容易理解和实现。 微服务可以使用或不使用 RESTful API 实现，但使用 RESTful API 构建松散耦合 的微服务总是更容易。</p>



### 3、什么是 feigin?它的优点是什么?
<ul><li>feign采用的是基于接口的注解。</li><li>feign整合了ribbon，具有负载均衡的能力。</li><li>整合了Hystrix，具有熔断的能力。</li></ul><p><strong>使用:</strong></p><ul><li>添加pom依赖。</li><li>启动类添加 @EnableFeignClients。</li><li>定义一个接口@FeignClient(name=“xxx”)指定调用哪个服务。</li></ul>



### 4、负载平衡的意义什么?
<p>在计算中，负载平衡可以改善跨计算机，计算机集群，网络链接，中央处理单元或磁盘驱动器等多种计算资源的工作负载分布。</p><p>负载平衡旨在优化资源使用，最 大化吞吐量，最小化响应时间并避免任何单一资源的过载。</p><p>使用多个组件进行负 载平衡而不是单个组件可能会通过冗余来提高可靠性和可用性。</p><p>负载平衡通常涉及专用软件或硬件，例如多层交换机或域名系统服务器进程。</p>



### 5、服务网关的作用
<ul><li>简化客户端调用复杂度，统一处理外部请求。</li><li>数据裁剪以及聚合，根据不同的接口需求，对数据加工后对外。</li><li>多渠道支持，针对不同的客户端提供不同的网关支持。</li><li>遗留系统的微服务化改造，可以作为新老系统的中转组件。</li><li>统一处理调用过程中的安全、权限问题。</li></ul>



### 6、服务降级底层是如何实现的?
<p>Hystrix 实现服务降级的功能是通过重写 HystrixCommand 中的 getFallback() 方法，当 Hystrix 的 run 方法或 construct 执行发生错误时转而执行 getFallback() 方法。</p>



### 7、微服务的端到端测试意味着什么?
<p>端到端测试 验证工作流中的所有流程，以检查一切是否按预期工作。</p><p>它还确保系统以统一的方式工作，从而满足业务需求。</p>



### 8、Spring Cloud 断路器的作用是什么?
<p>在分布式架构中，断路器模式的作用也是类似的，当某个服务单元发生故障(类 似用电器发生短路)之后，通过断路器的故障监控(类似熔断保险丝)，向调用方返回一个错误响应，而不是长时间的等待。这样就不会使得线程因调用故障服 务被长时间占用不释放，避免了故障在分布式系统中的蔓延。</p>



### 9、什么是端到端微服务测试?
<p><img class="alignright" src="https://www.johngo689.com/wp-content/uploads/member/avatars/spring-cloud-2.jpg" alt="spring-cloud-2" width="484" height="365" />端到端测试验证了工作流中的每个流程都正常运行。这可确保系统作为一个整体 协同工作并满足所有要求。 通俗地说，你可以说端到端测试是一种测试，在特定时期后测试所有东西。</p><p>&nbsp;</p>



### 10、Spring Cloud Security
<p>安全工具包，对 Zuul 代理中的负载均衡 OAuth2 客户端及登录认证进行支持。</p>


