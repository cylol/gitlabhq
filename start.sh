PROCESS=`ps -ef|grep sidekiq|grep -v grep|grep -v PPID|awk '{ print $2}'`
for i in $PROCESS
do
  echo "Kill the sidekiq process [ $i ]"
  kill -9 $i
done
echo "begin to start sidekiq"
nohup bundle exec sidekiq -q post_receive -q mailer -q system_hook -q project_web_hook -q gitlab_shell -q common -q default >> 'log/sidekiq.log' 2>&1 &
echo "begin to start rails"
bundle exec rails s
