function gmail-chk { curl -u $GMAIL_USERNAME --silent -k "https://mail.google.com/mail/feed/atom" | perl -ne 'print "\t" if /<name>/; print "$2\n" if /<(title|name)>(.*)<\/\1>/;'; }

function opencoffee-feed { feed.py "http://opencoffeerennes.com/feed/"; }

function lacantine-feed { feed.py "http://www.lacantine-rennes.net/feed/"; }

function base64() { python -c 'import sys; print open(sys.argv[1], "rb").read().encode("base64").replace("\n", "")' $1 }