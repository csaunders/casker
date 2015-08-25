require 'digest'

  class CaskDays
    attr_reader :festival, :beers, :breweries, :beer_styles, :locations
    def initialize(args)
      @cache ||= {}
      @festival = args.fetch(:festival, {})
      @beers = args.fetch(:beers, [])
      @breweries = args.fetch(:breweries, [])
      @beer_styles = args.fetch(:beer_styles, [])
      @locations = args.fetch(:locations, [])
    end

    def self.import(raw)
      importer = XLSXImporter.new(raw)
      self.new(
        beers: importer.beers,
        breweries: importer.breweries,
        beer_styles: importer.styles,
        locations: importer.locations,
      )
    end

    def finalize
      create_locations
      create_breweries
      create_styles
      create_beers
    end

    def to_hash
      {
        festival: festival,
        beers: beers,
        breweries: breweries,
        beer_styles: beer_styles,
        locations: locations
      }
    end

    private
    attr_reader :cache

    def  create_record(model, data)
      model.where(data).first_or_create
    end

    def create_locations
      locations.each do |loc|
        record = create_record(Location, loc.select(:city, :state, :country))
        cache[loc[:signature]] = record.id
      end
    end

    def create_breweries
      breweries.each do |brewery|
        attributes = brewery.select(:name, :website, :tagline)
        attributes[:location_id] = cache[brewery[:location_signature]]
        record = create_record(Brewery, attributes)
        cache[brewery[:signature]] = record.id
      end
    end

    def create_styles
      beer_styles.each do |style|
        record = create_record(BeerStyle, style.select(:name))
        cache[style[:signature]] = record.id
      end
    end

    def create_beers
      beers.each do |beer|
        attributes = beer.select(:name, :details, :abv, :ibu, :srm, :fg)
        attributes[:brewery_id] = cache[beer[:brewery_signature]]
        attributes[:beer_style_id] = cache[beer[:beer_style_signature]]
        record = create_record(Beer, attributes)
        cache[:beers] ||= []
        cache[:beers] << {beer_id: record.id, festival_identifier: beer[:identifier]}
      end
    end

    def create_festival
      festival = Festival.create(festival)
      cache[:beers].each do |beer|
        festival.festival_entries.create(beer)
      end
    end

    class XLSXImporter
      EVENT_NUM = "#"
      BREWERY_NAME = "BREWERY"
      BEER_NAME = "NAME"
      BEER_STYLE = "STYLE"
      BEER_ABV = "ALC/VOL"
      SESSION_NUM = "SESSION"

      def initialize(raw_data)
        @xls = Roo::Spreadsheet.open(StringIO.new(raw_data), extension: :xlsx)
      end

      def locations
        xls.sheets.map do |sheet|
          {name: normalize(sheet).gsub(/\(.+\)/, ''), signature: signature(sheet)}
        end
      end

      def breweries
        breweries = {}
        xls.each_with_pagename do |location_name, sheet|
          sheet.each(name: BREWERY_NAME) do |row|
            next if row[:name] == BREWERY_NAME
            name = row[:name]
            brewery_signature = signature(name)
            breweries[brewery_signature] ||= {
              name: normalize(name),
              signature: brewery_signature,
              location_signature: signature(location_name)
            }
          end
        end
        breweries.values
      end

      def styles
        styles = {}
        xls.each_with_pagename do |_, sheet|
          sheet.each(style: BEER_STYLE) do |row|
            next if row[:style] == BEER_STYLE
            style = row[:style]
            style_signature = signature(style)
            styles[style_signature] ||= {
              name: normalize(style),
              signature: style_signature
            }
          end
        end
        styles.values
      end

      def beers
        beers = []
        xls.each_with_pagename do |location, sheet|
          sheet.each(event_num: EVENT_NUM, brewery: BREWERY_NAME, name: BEER_NAME, style: BEER_STYLE, abv: BEER_ABV, session: SESSION_NUM) do |row|
            next if row[:event_num] == EVENT_NUM
            beers << {
              meta: {number: row[:event_num].to_i, session: row[:session_num]},
              name: row[:name],
              abv: row[:abv],
              details: row[:style],
              style_signature: signature(row[:style]),
              brewery_signature: signature(row[:brewery]),
              location_signature: signature(location)
            }
          end
        end
        beers
      end

      private
      attr_reader :xls
      def signature(value)
        Digest::MD5.hexdigest(value)
      end

      def normalize(str)
        str.gsub(/\*/, '').titleize.strip.gsub(/\s+/, ' ')
      end

    end
  end
