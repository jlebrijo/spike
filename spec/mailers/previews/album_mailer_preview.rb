class AlbumMailerPreview < ActionMailer::Preview

  def pdf_attached
    @album = User.first.albums.first
    pdf = 'x'
    AlbumMailer.pdf_attached(@album, pdf)
  end

end
