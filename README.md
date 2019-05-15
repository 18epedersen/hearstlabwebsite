# hearstlabwebsite


### `data/`

in `data`, the website is rendered from these data files:

- `projectspage.yaml` (output from `parse.rb`)

note that `parse.rb` uses the projectspage.csv file, which is exported from
the Hearst Lab Projects Page spreadsheet in shared [Google Drive folder]. To update this CSV file, you can run the download script (`ruby download.rb`),
but that requires setting up an access token for the Google Drive API as
detailed [here](https://developers.google.com/drive/v3/web/quickstart/ruby).
specifically, it requires installing the `google-api-client` gem (which you can
do by running `bundle`). installing the gem:

    [sudo] gem install google-api-client --no-document

also: the writing of the `credentials.json` file (setting up the auth is
helped by running download for the first time, but only after turning on the
drive api as specified in the guide). once you do these things, you should just
be able to run `make` to pull the latest version. further, if you want to
auto-update the site from this, you can run `make site`, which commits and
pushes the newly downloaded data.

don't commit the credentials.json!!! i added it to .gitignore.

### Links

Above writing (with exception of the data relevant for this project is from Jeremy Warner's repo for the class website for CS160 Fall 2017)

Jeremy's repo [here](https://github.com/cs160-berkeley/website)

CS160 Fall 2017 website [here](http://cs160.ninja/f17/)

Hearst Lab Project Page spreadsheet in Google Drive [here](https://docs.google.com/spreadsheets/d/1n5040fdFngI5AkSWAwbJ0rtzvcZmZp6rtUqL8uXjcH8/edit?usp=sharing)

The figma mockups for the website can be found in mockups-1.pdf and mockups-2.pdf. These are the mockups I presented during group meeting.


