deploy:
	jekyll build && rsync --archive --verbose --compress --delete _site/ hecticjeff:/data/hecticjeff.net
