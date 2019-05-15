schedule:
	ruby download.rb
	ruby parse.rb > schedule.yaml

site: schedule
	git add .
	git commit -m update
	git push

develop:
	fw ruby parse.rb

.PHONY: schedule site develop
