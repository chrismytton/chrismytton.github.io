deploy:
	jekyll build && rsync -avz --delete _site/ chrismytton.uk:/data/www.chrismytton.uk
