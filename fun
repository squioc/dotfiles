
function gmail-chk { curl -u $GMAIL_USERNAME --silent -k "https://mail.google.com/mail/feed/atom" | perl -ne 'print "\t" if /<name>/; print "$2\n" if /<(title|name)>(.*)<\/\1>/;'; }

#function youtube-video { echo $(echo "http://youtube.com/get_video.php?$(curl -s $1 | sed -n "/watch_fullscreen/s;.*\(video_id.\+\)&title.*;\1;p")"); }

function youtube-video { echo $(youtube-dl -g $1); }

function youtube-mp { mplayer -fs $(youtube-video $1); }

function youtube-vlc { vlc -vvv $(youtube-video $1); }

function opencoffee-feed { feed.py "http://opencoffeerennes.com/feed/"; }

function lacantine-feed { feed.py "http://www.lacantine-rennes.net/feed/"; }

function git-download { git clone $1 $2; }

function curl-download { curl $1 > $2; }

function wget-download { wget -o $2 $1; }

function yaml2json { python -c "import sys, json, yaml; data = sys.stdin.read(); print json.dumps(yaml.load(data), sort_keys=True, indent=4, separators=(',', ': '))"; }

function json2yaml { python -c "import sys, json, yaml; data = sys.stdin.read(); print yaml.dump(json.loads(data), default_flow_style=False, indent=4)"; }

function json { python -c "import sys, json; data = sys.stdin.read(); print json.dumps(json.loads(data), sort_keys=True, indent=4, separators=(',', ': '))"; }

function yaml { python -c "import sys, yaml; data = sys.stdin.read(); print yaml.dump(yaml.load(data), default_flow_style=False, indent=4)"; }

