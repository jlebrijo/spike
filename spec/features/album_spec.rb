feature Album, :js do
  let(:user) { create :user }
  let!(:album) { create :album, user: user }

  before do
    login_with(user)
    visit albums_path
  end

  scenario 'index: list all albums for a user' do
    expect(page).to have_content album.name
  end

  scenario 'show: album details page' do
    find("tr[data-id='#{album.id}'] a.show").click
    expect(page.find('#formModal')).to have_content album.name
  end

  context 'Create' do
    before do
      find('a.new').click
    end
    scenario 'with valid values, creates album' do
      album_name = 'Black'
      album_content = 'Some content'
      fill_in 'Name', with: album_name
      find(:xpath, "//trix-editor[@id='album_content']").click.set album_content
      click_button 'Save'
      expect(page).to have_content album_name

      persisted_album = Album.find_by(name: album_name)
      expect(persisted_album).not_to be_nil
      expect(persisted_album.content.to_plain_text).to include album_content
    end
    scenario 'with invalid values, shows errors in forms' do
      album_name = ''
      fill_in 'Name', with: album_name
      click_button 'Save'
      expect(page).to have_content "Name can't be blank"
    end
  end

  context 'Edit' do
    before do
      find("tr[data-id='#{album.id}'] a.edit").click
    end
    scenario 'with valid values, modifies album' do
      album_name = 'Roots'
      fill_in 'Name', with: album_name
      click_button 'Save'
      expect(page).to have_content album_name
      expect(Album.where(name: album_name)).to be_any
    end
    scenario 'with invalid values, shows errors in forms' do
      album_name = ''
      fill_in 'Name', with: album_name
      click_button 'Save'
      expect(page).to have_content "Name can't be blank"
    end
  end

  scenario 'delete: removes album' do
    expect(Album.count).to be 1
    find("tr[data-id='#{album.id}'] a[data-method='delete']").click
    page.accept_alert
    expect(page).to have_content 'Album was successfully destroyed.'
    expect(Album.count).to be_zero
  end
end