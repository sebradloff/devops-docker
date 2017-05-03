require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do

    @image = Docker::Image.build_from_dir('../') do |v|
      if (log = JSON.parse(v)) && log.has_key?("stream")
        $stdout.puts log["stream"]
      end
    end

    @image.tag('repo' => 'devops-fat-test', 'tag' => 'latest', force: true)

    set :os, family: :alpine
    set :backend, :docker
    set :docker_image, @image.id
  end

  it "should have ruby 2.3.3" do
    output = command('ruby -v')
    expect(output.stdout).to contain("ruby 2.3.3")
  end

 it "should have java 1.8" do
   output = command('java -version')
   expect(output.stderr).to contain("1.8")
 end

 it "should set a JAVA_HOME environment variable" do
   output = command('echo $JAVA_HOME')
   expect(output.stdout).to match('/usr/lib/jvm/java-1.8.0-openjdk')
 end

 it "should create a java_home.sh with the JAVA_HOME environment variable" do
   java_file = file('/etc/profile.d/java_home.sh')
   expect(java_file).to exist
   expect(java_file.content).to match("export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk")
 end
end
