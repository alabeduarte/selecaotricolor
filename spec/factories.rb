Factory.define :bahia, :class => Team do |f|
  f.name 'Bahia'
end

Factory.define :vitoria, :class => Team do |f|
  f.name "Vit\u00f3ria".force_encoding("UTF-8")
end

Factory.define :calendar do |f|
  f.day Time.utc(3000, 1, 1, 17, 0)
  f.association :home, :factory => :bahia
  f.association :away, :factory => :vitoria
  f.contains_formations false
end