# SDWebImage 的正确使用方式



#### 1、每次启动app 时需要清除过期的 磁盘数据, app尽量少占用用户磁盘空间

#### 2、WDWebImage 根据手机当时的网络情况来决定 下载原图 下载缩略图

#### 3、TableView在滚动过程中,清除SDWebImageView 为使用的内存图片, 保证App 最少的内存开销
