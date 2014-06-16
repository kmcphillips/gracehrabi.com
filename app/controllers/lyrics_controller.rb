class LyricsController < FrontEndController
  def index
    @lyrics = Lyric.sorted
  end

  def show
    @lyric = Lyric.find_by!(permalink: params[:id])
  end
end
