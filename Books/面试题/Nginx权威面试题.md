<b>更多面试题，干货内容，可以查看此处，从编程工具到面试要点。
全流程编程工具集&学习集 https://www.johngo689.com/2617/，欢迎留言交流！</b> 
<i>以下面试题来自网络以及自己整理，如有侵权，请及时联系删除！</i> 
 *** 
[TOC]

### 1、Nginx 是如何实现高并发的?
<p>如果一个 server 采用一个进程(或者线程)负责一个 request 的方式，那么进程数就是并发数。那么显而易见的，就是会有很多进程在等待中。等什么?最 多的应该是等待网络传输。其缺点胖友应该也感觉到了，此处不述。</p><p>而 Nginx 的异步非阻塞工作方式正是利用了这点等待的时间。在需要等待的 时候，这些进程就空闲出来待命了。因此表现为少数几个进程就解决了大量的 并发问题。</p><p><br />Nginx 是如何利用的呢，简单来说:同样的 4 个进程，如果采用一个进程负 责一个 request 的方式，那么，同时进来 4 个 request 之后，每个进程就 负责其中一个，直至会话关闭。期间，如果有第 5 个 request 进来了。就无 法及时反应了，因为 4 个进程都没干完活呢，因此，一般有个调度进程，每当 新进来了一个 request ，就新开个进程来处理。</p><p>Nginx 不这样，每进来一个 request ，会有一个 worker 进程去处理。但不 是全程的处理，处理到什么程度呢?处理到可能发生阻塞的地方，比如向上游 (后端)服务器转发 request ，并等待请求返回。那么，这个处理的 worker 不会这么傻等着，他会在发送完请求后，注册一个事件:“如果 upstream 返 回了，告诉我一声，我再接着干”。于是他就休息去了。此时，如果再有 request 进来，他就可以很快再按这种方式处理。而一旦上游服务器返回了，就会触发这个事件，worker 才会来接手，这个 request 才会接着往下走。</p><p><strong>这就是为什么说，Nginx 基于事件模型。</strong></p><p>由于 web server 的工作性质决定了每个 request 的大部份生命都是在网络 传输中，实际上花费在 server 机器上的时间片不多。这是几个进程就解决高 并发的秘密所在。即:<br /><strong>webserver 刚好属于网络 IO 密集型应用，不算是计算密集型。异步，非阻 塞，使用 epoll ，和大量细节处的优化，也正是 Nginx 之所以然的技术基石。</strong></p>



### 2、请解释 Nginx 如何处理 HTTP 请求。
<p>Nginx 使用反应器模式。</p><p>主事件循环等待操作系统发出准备事件的信号，这样数据就可以从套接字读取，在该实例中读取到缓冲区并进行处理。单个线程可以提供数万个并发连接。</p>



### 3、Nginx 为什么要做动、静分离?
<p>在我们的软件开发中，有些请求是需要后台处理的(如:.jsp,.do 等等)，有些请求是不需要经过后台处理的(如:css、html、jpg、js 等等)，这些不需要 经过后台处理的文件称为静态文件，否则动态文件。</p><p>因此我们后台处理忽略静态文件，但是如果直接忽略静态文件的话，后台的请求次数就明显增多了。</p><p>在我们对资源的响应速度有要求的时候，应该使用这种动静分离的策略去解决动、静分离将网站静态资源(HTML，JavaScript，CSS 等)与后台应用分开部署，提高用户访问静态代码的速度，降低对后台应用访问。</p><p>这里将静态资源 放到 nginx 中，动态资源转发到 tomcat 服务器中, 毕竟 Tomcat 的优势是处理 动态请求。 </p>



### 4、nginx 是如何实现高并发的?
<p>一个主进程，多个工作进程，每个工作进程可以处理多个请求，每进来一个 request，会有一个 worker 进程去处理。</p><p>但不是全程的处理，处理到可能发生阻塞的地方，比如向上游(后端)服务器转发 request，并等待请求返回。</p><p>那 么，这个处理的 worker 继续处理其他请求，而一旦上游服务器返回了，就会触发这个事件，worker 才会来接手，这个 request 才会接着往下走。</p><p>由于 web server 的工作性质决定了每个 request 的大部份生命都是在网络传输中， 实际上花费在 server 机器上的时间片不多。</p><p>这是几个进程就解决高并发的秘密所在。即 webserver 刚好属于网络 IO 密集型应用，不算是计算密集型。</p>



### 5、Nginx 静态资源?
<p>静态资源访问，就是存放在 nginx 的 html 页面，我们可以自己编写。</p>



### 6、Nginx 配置高可用性怎么配置?
<p>当上游服务器(真实访问服务器)，一旦出现故障或者是没有及时相应的话，应该直接轮训到下一台服务器，保证服务器的高可用。</p><p>Nginx 配置代码:</p><blockquote><p>server {<br />    listen 80;<br />    server_name www.johngo689.com;<br />    proxy_send_timeout 1s; <br />    index index.html index.htm;<br />}</p></blockquote>



### 7、502 错误可能原因？
<ul><li>FastCGI进程是否已经启动</li><li>FastCGI worker 进程数是否不够 </li><li>FastCGI执行时间过长<br /><ul><li>fastcgi_connect_timeout 300; </li><li>fastcgi_send_timeout 300;</li><li>fastcgi_read_timeout 300;</li></ul></li><li>FastCGI Buffer 不够<br /><ul><li>nginx和apache一样，有前端缓冲限制，可以调整缓冲参数 </li><li>fastcgi_buffer_size 32k;</li><li>fastcgi_buffers 8 32k;</li></ul></li><li>Proxy Buffer 不够<br /><ul><li>如果你用了Proxying，调整 </li><li>proxy_buffer_size 16k;</li><li>proxy_buffers 4 16k;</li></ul></li><li>php脚本执行时间过长<br /><ul><li>将php-fpm.conf的0s的0s改成一个时间</li></ul></li></ul>



### 8、Nginx 服务器上的 Master 和 Worker 进程分别是什么?
<h3>Master 进程</h3><p>读取及评估配置和维持 ;</p><h3>Worker 进程</h3><p>处理请求。</p>



### 9、Nginx 的优缺点?
<p>优点:</p><ul><li>占内存小，可实现高并发连接，处理响应快。</li><li>可实现HTTP服务器、虚拟主机、方向代理、负载均衡。</li><li>Nginx配置简单。</li><li>可以不暴露正式的服务器IP地址。</li></ul><p>缺点:<br />动态处理差，nginx 处理静态文件好，耗费内存少，但是处理动态页面则很鸡肋，现在一般前端用 nginx 作为反向代理抗住压力。</p>


