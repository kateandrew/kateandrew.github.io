module Gallery
  @code = 'main'
  @group_id = {}
  def gallery_sizes(code = nil)
    sizes = {
        :thumb => {:width => 80, :height => 74, :crop => true},
        :half => {:width => 272, :height => 198, :crop => true},
        :feature => {:width => 560, :crop => false},
        :zoom => {width:1280, :height => 1024, :crop => false}
    }
    code ? sizes[code] : sizes
  end
  def image_data(file)
    image_data = {}
    gallery_sizes.each do |size_code, size_data|
      image_data[size_code] = resized_image_uri(file, size_code)
    end
    image_data
  end

  def resized_image_path(file, size)
    File.join(root, 'source', 'images', 'galleries', @code, size.to_s, File.basename(file))
  end

  def resized_image_uri(file, size)
    resize_image(file, size) if (!File.exists? resized_image_path(file, size))
    File.join('/', 'images', 'galleries', @code, size.to_s, File.basename(file))
  end

  def resize_image(file, size)
    size_dir = File.join(root, 'source', 'images', 'galleries', @code, size.to_s)
    FileUtils.mkdir size_dir unless File.exist? size_dir
    image = Magick::Image.read(file).first
    size_data = gallery_sizes(size)
    newimg = size_data[:crop] ? image.resize_to_fill(size_data[:width], size_data[:height]) : image.resize_to_fit(size_data[:width], size_data[:height])
    newimg.write(resized_image_path(file, size)) { self.quality = 90 }
  end

  def gallery_data(code)
    @code = code
    path = File.join(root, 'source', 'images', 'galleries', code)
    files = Dir.glob("#{path}/*.{jpg,png,gif}")
    files.sort_by! {|file| File.basename(file)}
    images = []
    files.each do |file|
      images << image_data(file)
    end
    images
  end

  def gallery(code, config = {})
    @group_id ||= {}
    @group_id[code] ||= 0
    config[:template] ||= 'gallery'
    partial 'shared/'+config[:template], :locals => {:code => code.to_s, :group_id => code.to_s+(@group_id[code] += 1).to_s}
  end
end
