该脚本用于对FilePath路径下的文件进行压缩，所压缩的文件最后修改日期需在BakUpDate前的文件，压缩至BackPath路径下，并最终清理成功压缩的文件。
1、获取当前执行该脚本的时间
2、解析BakUpDate日期（该日期应为执行日期前一个月的日期）
3、设置环境变量
4、执行压缩命令：a:添加文件到压缩文档 -r:递归子目录 -tb:处理YYYY-MM-DD之前修改过的文件 -ep1:从名称里排除根目录 -dr:删除原文件至回收站/-df:彻底删除原文件
END
