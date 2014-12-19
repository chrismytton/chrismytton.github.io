deploy:
	jekyll build && rsync --archive --verbose --compress --delete _site/ chrismytton.uk:/data/www.chrismytton.uk
