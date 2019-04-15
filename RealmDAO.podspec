Pod::Spec.new do |spec|
  spec.name = "RealmDAO"
  spec.version = "1.2.3"
  spec.summary = "Swift framework to work with generic DAO's in Realm"
  spec.homepage = "https://github.com/rusito-23/RealmDAO"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Igor Andruskiewitsch" => 'i.andruskiewitsch23@gmail.com' }

  spec.platform = :ios, "12.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/rusito-23/RealmDAO.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "RealmDAO/**/*.{h,swift}"

  spec.dependency 'Realm'
  spec.dependency 'RealmSwift'
end
