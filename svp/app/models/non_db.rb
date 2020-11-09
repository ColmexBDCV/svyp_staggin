class VidDB < ActiveRecord::Base
  establish_connection(:vids)
end

class PubDB < ActiveRecord::Base
  establish_connection(:pub)
end

class Pub < PubDB
  self.table_name = "publicaciones"
end

class Video < VidDB
  self.table_name = "info_videos"
end
