<b>更多面试题，干货内容，可以查看此处，从编程工具到面试要点。
全流程编程工具集&学习集 https://www.johngo689.com/2617/，欢迎留言交流！</b> 
<i>以下面试题来自网络以及自己整理，如有侵权，请及时联系删除！</i> 
 *** 
[TOC]

### 1、讲一下 HBase 的存储结构，这样的存储结构有什么优缺点？
<p><img src="https://www.johngo689.com/wp-content/uploads/member/avatars/hbase1.jpg" alt="hbase1" /></p><p>&nbsp;</p><p><strong>HBase的优点及应用场景:</strong></p><ol><li><strong>半结构化或非结构化数据:</strong><br />对于数据结构字段不够确定或杂乱无章非常难按一个概念去进行抽取的数据适合用HBase，因为HBase支持动态添加列。</li><li><strong>记录很稀疏:</strong><br />RDBMS的行有多少列是固定的。为null的列浪费了存储空间。HBase为null的Column不会被存储，这样既节省了空间又提高了读性能。</li><li><strong>多版本号数据:</strong><br />依据Row key和Column key定位到的Value能够有随意数量的版本号值，因此对于须要存储变动历史记录的数据，用HBase是很方便的。比方某个用户的Address变更，用户的Address变更记录也许也是具有研究意义的。</li><li><strong>仅要求最终一致性:</strong><br />对于数据存储事务的要求不像金融行业和财务系统这么高，只要保证最终一致性就行。(比如 HBase+elasticsearch时，可能出现数据不一致)</li><li><strong>高可用和海量数据以及很大的瞬间写入量:</strong><br />WAL解决高可用，支持PB级数据，put性能高适用于插入比查询操作更频繁的情况。比如，对于历史记录表和日志文件。(HBase的写操作更加高效)</li><li><strong>业务场景简单:</strong><br />不需要太多的关系型数据库特性，列入交叉列，交叉表，事务，连接等。</li></ol><p>&nbsp;</p><p><strong>HBase的缺点:</strong></p><ol><li>单一RowKey固有的局限性决定了它不可能有效地支持多条件查询；</li><li>不适合于大范围扫描查询；</li><li>不直接支持SQL的语句查询。</li></ol>



### 2、讲一下 HBase 的写数据的流程？
<ol><li>Client先访问zookeeper，从 meta 表获取相应region信息，然后从meta表获取相应region信息；</li><li>根据namespace、表名和rowkey根据meta表的数据找到写入数据对应的region信息；</li><li>找到对应的regionserver把数据先写到WAL中，即HLog，然后写到MemStore上；</li><li>MemStore达到设置的阈值后则把数据刷成一个磁盘上的StoreFile文件；</li><li>当多个StoreFile文件达到一定的大小后(这个可以称之为小合并，合并数据可以进行设置，必须大于等于2，小于10——hbase.hstore.compaction.max和hbase.hstore.compactionThreshold，默认为10和3)，会触发 Compact合并操作，合并为一个StoreFile，(这里同时进行版本的合并和数据删除。)；</li><li>当Storefile大小超过一定阈值后，会把当前的Region分割为两个(Split)【可称之为大合并，该阈值通过 hbase.hregion.max.filesize设置，默认为10G】，并由Hmaster分配到相应的HRegionServer，实现负载均衡。</li></ol>



### 3、讲一下HBase读数据的流程？
<ol><li>首先，客户端需要获知其想要读取的信息的Region的位置，这个时候，Client访问hbase上数据时并不需要 Hmaster参与(HMaster仅仅维护着table和Region的元数据信息，负载很低)，只需要访问zookeeper，从 meta表获取相应region信息(地址和端口等)。【Client请求ZK获取.META.所在的RegionServer的地址。】</li><li>客户端会将该保存着RegionServer的位置信息的元数据表.META.进行缓存。然后在表中确定待检索rowkey所在的RegionServer信息(得到持有对应行键的.META表的服务器名)。【获取访问数据所在的RegionServer 地址】</li><li>根据数据所在RegionServer的访问信息，客户端会向该RegionServer发送真正的数据读取请求。服务器端接收到该请求之后需要进行复杂的处理。</li><li>先从MemStore找数据，如果没有，再到StoreFile上读(为了读取的效率)。</li></ol>



### 4、讲一下 HBase 架构？
<p><img src="https://www.johngo689.com/wp-content/uploads/member/avatars/hbase2.jpg" alt="hbase2" /></p><p>&nbsp;</p><p><strong>Hbase主要包含HMaster/HRegionServer/Zookeeper</strong></p><ul><li><strong>HRegionServer 负责实际数据的读写.当访问数据时,客户端直接与RegionServer通信.</strong><br />HBase的表根据Row Key的区域分成多个Region,一个Region包含这这个区域内所有数据.而Region server负责管理多个Region,负责在这个Region server上的所有region的读写操作.</li><li><strong>HMaster 负责管理Region的位置, DDL(新增和删除表结构)</strong><br /><ul><li>协调RegionServer </li><li>在集群处于数据恢复或者动态调整负载时,分配Region到某一个RegionServer中</li><li>管控集群,监控所有Region Server的状态</li><li>提供DDL相关的API,新建(create),删除(delete)和更新(update)表结构.</li></ul></li><li><strong>Zookeeper 负责维护和记录整个Hbase集群的状态</strong><br />zookeeper探测和记录Hbase集群中服务器的状态信息.如果zookeeper发现服务器宕机,它会通知Hbase的 master节点.</li></ul>



### 5、HBase 的 HA实现，ZooKeeper在其中的作用？
<p>HBase中可以启动多个HMaster，通过Zookeeper的Master Election机制保证总有一个Master运行。</p><p>配置HBase高可用，只需要启动两个HMaster，让Zookeeper自己去选择一个Master Acitve即可 zk的在这里起到的作用就是用来管理master节点,以及帮助hbase做master选举。</p>



### 6、HBase 数据结构是怎样的？
<ul><li><strong>RowKey</strong><br />与nosql数据库们一样,RowKey是用来检索记录的主键。访问HBASE table中的行，只有三种方式:<br /><ul><li>通过单个RowKey访问(get)</li><li>通过RowKey的range(正则)(like)</li><li>全表扫描(scan)<br />RowKey行键(RowKey)可以是任意字符串(最大⻓度是64KB，实际应用中⻓度一般为10-100bytes)，在HBASE内部，RowKey保存为字节数组。存储时，数据按照RowKey的字典序(byte order)排序存储。设计RowKey时，要充分排序存储这个特性，将经常一起读取的行存储放到一起。(位置相关性)。</li></ul></li><li><strong>Column Family</strong><br />列族:HBASE表中的每个列，都归属于某个列族。列族是表的schema的一部分(而列不是)，必须在使用表之前定义。列名都以列族作为前缀。例如 courses:history，courses:math都属于courses 这个列族。</li><li><strong>Cell</strong><br />由{rowkey, column Family:columu, version}唯一确定的单元。cell中的数据是没有类型的，全部是字节码形式存贮。<br />关键字:无类型、字节码</li><li><strong>Time Stamp</strong><br />HBASE 中通过rowkey和columns确定的为一个存贮单元称为cell。每个 cell都保存着同一份数据的多个版本。版本通过时间戳来索引。时间戳的类型是64位整型。时间戳可以由HBASE(在数据写入时自动)赋值，此时时间戳是精确到毫秒的当前系统时间。时间戳也可以由客户显式赋值。如果应用程序要避免数据版本冲突，就必须自己生成具有唯一性的时间戳。每个 cell中，不同版本的数据按照时间倒序排序，即最新的数据排在最前面。<br />为了避免数据存在过多版本造成的的管理(包括存贮和索引)负担，HBASE提供了两种数据版本回收方式。一是保存数据的最后n个版本，二是保存最近一段时间内的版本(比如最近七天)。用户可以针对每个列族进行设置。</li><li><strong>命名空间</strong><br />命名空间结构如下:<br />1. Table:表，所有的表都是命名空间的成员，即表必属于某个命名空间，如果没有指定，则在default默认的命名空间中。<br />2. RegionServergroup:一个命名空间包含了默认的RegionServerGroup。<br />3. Permission:权限，命名空间能够让我们来定义访问控制列表ACL(AccessControlList)。例如，创建表，<br />读取表，删除，更新等等操作。<br />4. Quota:限额，可以强制一个命名空间可包含的region的数量。</li></ul>



### 7、HBase 如何设计 rowkey？
<ul><li>RowKey⻓度原则<br />Rowkey是一个二进制码流，Rowkey的⻓度被很多开发者建议说设计在10~100个字节，不过建议是越短越 好，不要超过16个字节。<br />原因如下:<br /><ul><li>数据的持久化文件HFile中是按照KeyValue存储的，如果Rowkey过⻓比如100个字节，1000万列数据光Rowkey就要占用100*1000万=10亿个字节，将近1G数据，这会极大影响HFile的存储效率;</li><li>MemStore将缓存部分数据到内存，如果Rowkey字段过⻓内存的有效利用率会降低，系统将无法缓存更多的数据，这会降低检索效率。因此Rowkey的字节⻓度越短越好。 </li><li>目前操作系统是都是64位系统，内存8字节对⻬。控制在16个字节，8字节的整数倍利用操作系统的最佳 特性。</li></ul></li><li>RowKey散列原则<br />如果Rowkey是按时间戳的方式递增，不要将时间放在二进制码的前面，建议将Rowkey的高位作为散列字 段，由程序循环生成，低位放时间字段，这样将提高数据均衡分布在每个Regionserver实现负载均衡的几 率。如果没有散列字段，首字段直接是时间信息将产生所有新数据都在一个RegionServer上堆积的热点现 象，这样在做数据检索的时候负载将会集中在个别RegionServer，降低查询效率。</li><li>RowKey唯一原则 <br />必须在设计上保证其唯一性。</li></ul>


