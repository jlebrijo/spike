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