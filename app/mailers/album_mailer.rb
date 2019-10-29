class AlbumMailer < ApplicationMailer
  def pdf_attached(album, pdf)
    @user = album.user
    @album = album

    attachments["album-#{@album.name.parameterize}.pdf"] = pdf

    mail to: @user.email, subject: 'Album PDF info'
  end
end
