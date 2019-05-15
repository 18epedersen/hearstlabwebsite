require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

# Download the Schedule Google Spreadsheet as a CSV
# from documentation:
# https://developers.google.com/drive/v3/web/quickstart/ruby
FILENAME = "Hearst Lab Projects Page"
DOWNLOAD = "projectspage.csv"

require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'Drive API Ruby Quickstart'
CLIENT_SECRETS_PATH = 'credentials.json'

CREDENTIALS_PATH = File.join(Dir.home, '.credentials', "drive-ruby-quickstart.yaml")
SCOPE = Google::Apis::DriveV3::AUTH_DRIVE

# relevant:
# http://www.rubydoc.info/github/google/google-api-ruby-client/Google/Apis/DriveV3

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(
    client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts "Open the following URL in the browser and enter the " +
      "resulting code after authorization"
    puts url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI)
  end
  credentials
end

# Initialize the API
service = Google::Apis::DriveV3::DriveService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

# Search for file name Schedule
response = service.list_files(q: "name = '#{FILENAME}'",
                              spaces: 'drive',
                              fields: 'files(id, name)')

response.files.each do |file|
  puts "Found file: #{file.name} #{file.id}"
end

file = response.files.first
begin
  content = service.export_file(file.id,
                                'text/csv',
                                download_dest: DOWNLOAD)
   puts "file #{FILENAME} exported to #{DOWNLOAD}"
rescue Exception => e
  pp e
end
