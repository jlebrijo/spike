describe 'api Albums' do
  let(:user) { create :user }
  let!(:album) { create :album, user: user }

  describe '#LIST: GET /albums' do
    it 'return 200 and returns album list' do
      create_list :album, 3, user: user
      get albums_path, headers: auth_headers(user)

      expect(response).to have_http_status :ok
      expect(Album.count).to eq 4
      expect(body_hash.count).to eq 4
    end
    it 'return 401:unauthorized if not logged in' do
      get albums_path

      expect(response).to have_http_status :unauthorized
    end
  end

  describe '#SHOW: GET /v2/albums/1' do
    it 'return 200 and returns album 1 details' do
      get album_path(album), headers: auth_headers(user)

      expect(response).to have_http_status :ok
      expect(body_hash[:name]).to eq album.name
    end
  end

  describe '#CREATE: POST /v2/album' do
    let(:payload) {{name: 'Fear of the Dark'}}

    it 'return 200 and create the album' do
      a = build :album
      post albums_path, params: { album: a.attributes }, headers: auth_headers(user)

      expect(response).to have_http_status :created
      found = Album.find_by name: a.name
      expect(found.name).to eq a.name
    end

    it 'run with payload' do
      post albums_path, params: { album: payload }, headers: auth_headers(user)

      expect(response).to have_http_status :created
      found = Album.find body_hash[:id]
      expect(found.name).to eq payload[:name]
    end
  end

  describe '#UPDATE: PUT /v2/albums/1' do
    it 'returns 200 and update album attributes' do
      put album_path(album, album: { name: 'Breaking the law' }),
          headers: auth_headers(user)

      album.reload
      expect(response).to have_http_status :ok
      expect(album.name).to eq 'Breaking the law'
    end
  end

  describe '#DELETE: DELETE /v2/albums/1' do
    it 'returns a 204 status' do
      expect(Album.first).to eq album
      delete album_path(album.id), headers: auth_headers(user)
      expect(Album.all).to be_empty
      expect(response).to have_http_status :no_content
    end
  end
end
