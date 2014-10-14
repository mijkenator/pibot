#!/bin/bash

sess=pibot


tmux list-session 2>&1 | grep -q "^$sess:" || tmux new-session -s $sess -d -n tests
tmux list-window -t $sess 2>&1 | grep -q ": polling \[" || tmux new-window -t $sess -n polling
tmux send-keys -t $sess:polling 'cd /home/ashim/work/pibot' Enter
tmux split-window -h -t $sess:polling 
tmux split-window -v -t $sess:polling
tmux split-window -v -t $sess:polling.0

tmux send-keys -t $sess:polling.0 'cd /home/ashim/work/pibot' Enter
tmux send-keys -t $sess:polling.1 'cd /home/ashim/work/pibot' Enter
tmux send-keys -t $sess:polling.2 'cd /home/ashim/work/pibot' Enter
tmux send-keys -t $sess:polling.3 'cd /home/ashim/work/pibot' Enter
#tmux set-window-option -t $sess:polling synchronize-panes on
tmux rename-window -t $sess:tests tests
tmux rename-window -t $sess:polling polling


tmux list-window -t $sess 2>&1 | grep -q ": vim \[" || tmux new-window -t $sess -n vim
tmux send-keys -t $sess:vim 'cd /home/ashim/work/pibot' Enter
tmux send-keys -t $sess:vim 'vim -c ":so pibot"' Enter
tmux rename-window -t $sess:vim vim


tmux list-window -t $sess 2>&1 | grep -q ": release \[" || tmux new-window -t $sess -n release
tmux send-keys -t $sess:release 'cd /home/ashim/work/pibot' Enter
tmux send-keys -t $sess:release './makeall.sh' Enter
tmux send-keys -t $sess:release 'rel/pibot/bin/pibot console' Enter

tmux list-window -t $sess 2>&1 | grep -q ": compile \[" || tmux new-window -t $sess -n compile
tmux send-keys -t $sess:compile 'cd /home/ashim/work/pibot' Enter

tmux list-window -t $sess 2>&1 | grep -q ": nginx \[" || tmux new-window -t $sess -n nginx
tmux send-keys -t $sess:nginx 'cd /home/ashim/work/pibot' Enter
#tmux send-keys -t $sess:nginx 'vim -c ":so nginx"' Enter

tmux list-window -t $sess 2>&1 | grep -q ": int \[" || tmux new-window -t $sess -n int
tmux send-keys -t $sess:nginx 'cd /home/ashim/work/pibot' Enter

tmux list-window -t $sess 2>&1 | grep -q ": coleman \[" || tmux new-window -t $sess -n coleman
#tmux send-keys -t $sess:coleman 'ssh -i /home/ashim/.ssh/edapi.pem ec2-user@54.235.152.167' Enter

tmux -2 attach-session -t $sess
