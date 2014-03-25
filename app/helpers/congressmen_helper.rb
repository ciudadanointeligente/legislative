module CongressmenHelper
  def age(dob)
    today = Date.today
    age = today.year - dob.year
    age -= 1 if dob.strftime("%m%d").to_i > today.strftime("%m%d").to_i
    return age
  end

  def congressmen_pic(name, img)
    fantasy_name = Rack::Utils.escape(I18n.transliterate(name.gsub("'", "")))
    url_image = open('app/assets/images/default-profile.png')

    if ! File.exist?('app/assets/images/'+fantasy_name+'.jpg')
      image = Magick::ImageList.new
      begin
        Timeout.timeout(5) do
          url_image = open(img)
        end
      rescue Timeout::Error
        url_image = open('app/assets/images/default-profile.png')
      end
      image.from_blob(url_image.read)
      crop = image.crop(15,15,160,150)
      crop.write('app/assets/images/'+fantasy_name+'.jpg')
    end
    return fantasy_name
  end
end
