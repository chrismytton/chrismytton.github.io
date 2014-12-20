deploy:
	jekyll build && rsync -avz --delete _site/ chrismytton.uk:/var/www/www.chrismytton.uk
