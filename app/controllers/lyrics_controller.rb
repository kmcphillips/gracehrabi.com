class LyricsController < FrontEndController
  def index
    @lyrics = Lyric.sorted
  end

  def show
    @lyric = Lyric.find(params[:id])
  end
end
