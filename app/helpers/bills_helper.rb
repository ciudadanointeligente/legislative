module BillsHelper
  def preset_queries
    i = 1
    presets = Array.new
    while i < 10
      if !ENV['preset' + i.to_s].nil?
        preset = JSON.parse(ENV['preset' + i.to_s])
        presets << preset
      end
      i = i + 1
    end
    return presets
  end
end
