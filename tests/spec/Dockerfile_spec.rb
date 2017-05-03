require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do

    @image = Docker::Image.build_from_dir('../') do |v|
      if (log = JSON.parse(v)) && log.has_key?("stream")
        $stdout.puts log["stream"]
      end
    end

    set :os, family: :alpine
    set :backend, :docker
    set :docker_image, @image.id
  end

  describe command('ruby -v') do
   it "ruby version" do
     expect(subject.stdout).to contain("ruby 2.3.3")
   end
 end
end
