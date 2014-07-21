require 'componentize'

comp = Componentize::component 'story' do |c|
  c.fragment :thumbnail

  c.fragment :title

  c.media_state 'all and (min-width: 640px)' do |m|
    m.fragment :title do |f|
      f.style :width, '100%'
    end
  end

  c.class_state :preview do |s|
    s.fragment :thumbnail do |f|
      f.include 'grid-width', 6, last_column: true
      f.style :width, '50%'
    end
  end

  c.class_state :preview_featured do |s|
    s.media_state 'all and (min-width: 300px)' do |m|
      m.style :height, '17px'
    end
  end

  c.class_state :preview_small do |s|
  end

  c.class_state :full do |s|

  end

  c.pseudo_class_state :hover do |s|
    s.style :height, '24px'
  end
end

puts comp.to_sass
puts comp.to_json
