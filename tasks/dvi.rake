namespace "dvi" do
  desc "Download sample tfm files."
  task :download_tfm do
    url = "http://www.ctan.org/get/fonts/cm/tfm"
    [ "cmr8.tfm", "cmr10.tfm", "cmr12.tfm", "cmb10.tfm" ].each do |name|
      unless File.exist?(File.join(File.dirname(__FILE__), "..", "tmp", "tfm", name))
        sh %{ curl --create-dirs --location -o tmp/tfm/#{name} #{url}/#{name} }
      end
    end
  end

  desc "Make ls-R."
  task :lsr => :download_tfm do
    sh %{mktexlsr tmp}
  end
end
