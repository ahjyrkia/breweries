require 'rails_helper'

describe "BeermappingApi" do
  it "When HTTP GET returns one entry, it is parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>12411</id><name>Gallows Bird</name><status>Brewery</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12411</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=12411&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=12411&amp;d=1&amp;type=norm</blogmap><street>Merituulentie 30</street><city>Espoo</city><state></state><zip>02200</zip><country>Finland</country><phone>+358 9 412 3253</phone><overall>91.66665</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("espoo")

    expect(places.size).to eq(1)
    place = places.first
    expect(place.name).to eq("Gallows Bird")
    expect(place.street).to eq("Merituulentie 30")
  end
  it "When HTTP GET returns no entries, empty table returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*kumpula/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("kumpula")

    expect(places.size).to eq(0)

  end
  it "When HTTP GET returns multiple entries, they are parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>6725</id><name>Oslo Mikrobryggeri</name><status>Brewpub</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=6725</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=6725&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=6725&amp;d=1&amp;type=norm</blogmap><street>Bogstadveien 6</street><city>Oslo</city><state></state><zip>0355</zip><country>Norway</country><phone>+47 22569776</phone><overall>78.33335</overall><imagecount>2</imagecount></location><location><id>6756</id><name>Beer Palace</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=6756</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=6756&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=6756&amp;d=1&amp;type=norm</blogmap><street>Holmens gate 3</street><city>Oslo</city><state></state><zip>0250</zip><country>Norway</country><phone>+47 22 83 71 5</phone><overall>83.3334</overall><imagecount>1</imagecount></location><location><id>6767</id><name>Lorry</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=6767</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=6767&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=6767&amp;d=1&amp;type=norm</blogmap><street>Parkveien 12</street><city>Oslo</city><state></state><zip>0350</zip><country>Norway</country><phone>+47 22 69 69 0</phone><overall>48.33345</overall><imagecount>0</imagecount></location><location><id>7040</id><name>Vinmonopolet - Steen and Strøm</name><status>Beer Store</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=7040</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=7040&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=7040&amp;d=1&amp;type=norm</blogmap><street>Kongens gate 23</street><city>Oslo</city><state></state><zip>0153</zip><country>Norway</country><phone>+47  22 41 59 92</phone><overall>61.66685</overall><imagecount>0</imagecount></location><location><id>7041</id><name>Vinmonopolet - Rosenkrantz Gate</name><status>Beer Store</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=7041</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=7041&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=7041&amp;d=1&amp;type=norm</blogmap><street>Rosenkrantz gate 11</street><city>Oslo</city><state></state><zip>0153</zip><country>Norway</country><phone>+47  22 33 43 03</phone><overall>75.0001</overall><imagecount>0</imagecount></location><location><id>7042</id><name>ICA Gourmet</name><status>Beer Store</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=7042</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=7042&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=7042&amp;d=1&amp;type=norm</blogmap><street>Holmens gate 7</street><city>Oslo</city><state></state><zip>0250</zip><country>Norway</country><phone>+47 2201 7860</phone><overall>56.6668</overall><imagecount>0</imagecount></location><location><id>9570</id><name>Olympen</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=9570</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=9570&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=9570&amp;d=1&amp;type=norm</blogmap><street>Grønlandsleiret 15</street><city>Oslo</city><state></state><zip>0190</zip><country>Norway</country><phone>+47 24 10 19 99</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>13350</id><name>Håndverkerstuene</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13350</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13350&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13350&amp;d=1&amp;type=norm</blogmap><street>Rosenkrantzgate 7</street><city>Oslo</city><state></state><zip>0159</zip><country>Norway</country><phone>+47 22 42 07 50</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>13670</id><name>Schouskjelleren Mikrobryggeri</name><status>Brewpub</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13670</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13670&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13670&amp;d=1&amp;type=norm</blogmap><street>Trondheimsveien 2</street><city>Oslo</city><state></state><zip>0560</zip><country>Denmark</country><phone></phone><overall>0</overall><imagecount>0</imagecount></location><location><id>17330</id><name>Amundsen Bryggeri and Spiseri</name><status>Brewpub</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=17330</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=17330&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=17330&amp;d=1&amp;type=norm</blogmap><street>Stortingsgaten 20</street><city>Oslo</city><state></state><zip>0161</zip><country>Norway</country><phone>24200900</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*oslo/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("oslo")

    expect(places.size).to eq(10)
    place = places.first
    expect(place.name).to eq("Oslo Mikrobryggeri")

  end

  describe "in case of cache miss" do

    before :each do
      Rails.cache.clear
    end

    it "When HTTP GET returns one entry, it is parsed and returned" do
      canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>13307</id><name>O'Connell's Irish Bar</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13307</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap><street>Rautatienkatu 24</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227032</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
      END_OF_STRING

      stub_request(:get, /.*tampere/).to_return(body: canned_answer, headers: {'Content-Type' => "text/xml"})

      places = BeermappingApi.places_in("tampere")

      expect(places.size).to eq(1)
      place = places.first
      expect(place.name).to eq("O'Connell's Irish Bar")
      expect(place.street).to eq("Rautatienkatu 24")
    end
  end

  describe "in case of cache hit" do

    it "When one entry in cache, it is returned" do
      canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>13307</id><name>O'Connell's Irish Bar</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13307</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap><street>Rautatienkatu 24</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227032</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
      END_OF_STRING

      stub_request(:get, /.*tampere/).to_return(body: canned_answer, headers: {'Content-Type' => "text/xml"})

      # ensure that data found in cache
      BeermappingApi.places_in("tampere")

      places = BeermappingApi.places_in("tampere")

      expect(places.size).to eq(1)
      place = places.first
      expect(place.name).to eq("O'Connell's Irish Bar")
      expect(place.street).to eq("Rautatienkatu 24")
    end
  end
end
