feature Album do
  let(:user) { create :user }
  let!(:album) { create :album, user: user }

  before { login_with(user) }
  scenario 'index: list all albums for a user' do
    visit albums_path
    expect(page).to have_content album.name
  end
  scenario 'show: album details page' do
    visit album_path(album)
    expect(page).to have_content album.name
  end
  context 'Create' do
    before do
      visit new_album_path
      expect(page).to have_content 'Name'
    end
    scenario 'with valid values, creates album' do
      album_name = 'Black'
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
  context 'Edit' do
    before do
      visit edit_album_path(album)
      expect(page).to have_content 'Name'
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
  scenario 'delete: removes album', :js do
    expect(Album.count).to be 1
    visit albums_path
    find("tr[data-id='#{album.id}'] a[data-method='delete']").click
    page.accept_alert
    expect(Album.count).to be_zero
  end
end