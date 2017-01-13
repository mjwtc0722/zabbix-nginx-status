# zabbix-nginx-status
Nginx状态zabbix监控
## 使用说明
* 将nginx_status.sh置于/etc/zabbix/scripts/目录下并赋予执行权限
```
[root@localhost ~]# ls -l /etc/zabbix/scripts/
total 4
-rwxr-xr-x 1 root root 825 Jan  13 16:08 nginx_status.sh
```
* 将userparameter_nginx.conf置于/etc/zabbix/zabbix_agentd.d/目录下
```
[root@localhost ~]# ls -l /etc/zabbix/zabbix_agentd.d/
total 4
-rw-r--r-- 1 root root 69 Jan  9 21:51 userparameter_nginx.conf
```
* Nginx开启stub_status状态，需要stub_status模块支持，编译参数需加入--with-http_stub_status_module
```
[root@localhost ~]# vim /usr/local/nginx/conf/nginx.conf
server {
    listen 80;
    location /nginx_stat {
        stub_status on;
        access_log off;
        allow 127.0.0.1;
        deny all;
    }
}
```
* 重启zabbix-agent守护进程
```
[root@localhost ~]# service zabbix-agent restart
Shutting down Zabbix agent:                                [  OK  ]
Starting Zabbix agent:                                     [  OK  ]
```
* 在zabbix web导入模板zbx_nginx_templates.xml并关联主机

## 监控项说明
```
Active connections          #活动连接数
Accepted connections\min    #每分钟建立的连接数
Handled connections\min     #每分钟握手的连接数
Requests\min                #每分钟请求数
Reading Connections         #读取客户端的连接数
Writing Connections         #响应数据到客户端的数量
Waiting Connections         #开启keep-alive的情况下,这个值等于active–(reading+writing),意思就是Nginx已经处理完正在等候下一次请求指令的驻留连接
Nginx Proc_Num              #Nginx活动进程数
```
