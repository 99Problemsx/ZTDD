module Events
  module Animations
    class Wind
      SPEED = 8

      # @return [Integer]
      attr_accessor :x
      # @return [Integer]
      attr_accessor :y
      # @return [Integer]
      attr_accessor :z
      # @return [Integer]
      attr_accessor :ex
      # @return [Integer]
      attr_accessor :ey
      # @return [Integer]
      attr_accessor :opacity

      # @param viewport [Viewport]
      def initialize(viewport)
        @viewport = viewport
        @sprites = {}
        @x = 0
        @y = 0
        @z = 999
        @ex = 0
        @ey = 0
        @opacity = 255

        # Create sprites
        @sprites[0] = create_sprite('Graphics/Animations/Wind/wind1') do |s|
          s.src_rect.width = 0
          s.src_rect.x = s.bitmap.width
          s.oy = s.bitmap.height
        end
        @sprites[1] = create_sprite('Graphics/Animations/Wind/wind2') do |s|
          s.src_rect.height = 0
          s.src_rect.y = s.bitmap.height
          s.ox = s.bitmap.width
        end
        @sprites[2] = create_sprite('Graphics/Animations/Wind/wind3') do |s|
          s.src_rect.height = 0
          s.end_y = s.bitmap.height
          s.ox = s.bitmap.width
        end
      end

      def create_sprite(bitmap_path)
        sprite = ::Sprite.new(@viewport)
        
        begin
          sprite.bitmap = Bitmap.new(bitmap_path)
        rescue => e
          puts "Error loading wind bitmap '#{bitmap_path}': #{e.message}" if $DEBUG
          sprite.bitmap = Bitmap.new(64, 64)
          sprite.bitmap.fill_rect(0, 0, 64, 64, Color.new(255, 255, 0, 128))
        end
        
        # Add custom properties
        sprite.instance_variable_set(:@toggle, 1)
        sprite.instance_variable_set(:@ex, 0)
        sprite.instance_variable_set(:@ey, 0)
        sprite.instance_variable_set(:@end_x, 0)
        sprite.instance_variable_set(:@end_y, 0)
        
        class << sprite
          attr_accessor :toggle, :ex, :ey, :end_x, :end_y
        end
        
        sprite.toggle = 1
        sprite.ex = 0
        sprite.ey = 0
        sprite.end_x = 0
        sprite.end_y = 0
        
        yield sprite if block_given?
        sprite
      end

      # Checks if sprite finished animating?
      # @return [Boolean]
      def finished?
        @sprites.each_value do |sprite|
          return false unless sprite.toggle > 2
        end
        true
      end

      # Dispose sprites
      def dispose
        @sprites.each_value(&:dispose)
        @sprites.clear
      end

      # @return [Boolean]
      def disposed?
        @sprites.empty?
      end

      # @param val [Boolean]
      def visible=(val)
        @sprites.each_value { |sprite| sprite.visible = val }
      end

      # Updates sprites
      def update
        return if disposed?

        @sprites.each_value(&:update)

        # Handle beginning of swirl
        case @sprites[0].toggle
        when 1
          @sprites[0].ex += SPEED.lerp
          @sprites[0].src_rect.width = @sprites[0].ex
          @sprites[0].end_x = @sprites[0].width
          @sprites[0].src_rect.x = @sprites[0].bitmap.width - @sprites[0].width
          @sprites[0].toggle = 2 if @sprites[0].width >= @sprites[0].bitmap.width
        when 2
          @sprites[0].ex -= SPEED.lerp
          @sprites[0].src_rect.width = @sprites[0].ex
          @sprites[0].toggle = 3 if @sprites[0].width <= 0
        end

        # Handle loop at the swirl
        if @sprites[0].toggle >= 2
          case @sprites[1].toggle
          when 1
            @sprites[1].ey += SPEED.lerp
            @sprites[1].src_rect.height = @sprites[1].ey
            @sprites[1].end_y = @sprites[1].height
            @sprites[1].src_rect.y = @sprites[1].bitmap.height - @sprites[1].height
            @sprites[1].toggle = 2 if @sprites[1].height >= @sprites[1].bitmap.height
          when 2
            @sprites[1].ey -= SPEED.lerp
            @sprites[1].src_rect.height = @sprites[1].ey
            @sprites[1].toggle = 3 if @sprites[1].height <= 0
          end
        end

        # Handle tail of the swirl
        if @sprites[1].toggle >= 2
          case @sprites[2].toggle
          when 1
            @sprites[2].ey += SPEED.lerp
            @sprites[2].src_rect.height = @sprites[2].ey
            @sprites[2].toggle = 2 if @sprites[2].height >= @sprites[2].bitmap.height
          when 2
            @sprites[2].ey -= SPEED.lerp
            @sprites[2].src_rect.height = @sprites[2].ey
            @sprites[2].end_y = @sprites[2].height
            @sprites[2].src_rect.y = @sprites[2].bitmap.height - @sprites[2].height
            @sprites[2].toggle = 3 if @sprites[2].height <= 0
          end
        end

        # Position sprites relative to map
        @sprites.each_value do |sprite|
          sprite.x = @ex + @x + sprite.bitmap.width - sprite.end_x - $game_map.display_x / Game_Map::X_SUBPIXELS
          sprite.y = @ey + @y + sprite.bitmap.height - sprite.end_y - $game_map.display_y / Game_Map::Y_SUBPIXELS
          sprite.z = @z
          sprite.opacity = @opacity
        end
      end
    end

    # WindManager - handles multiple wind animations
    class WindManager
      MAX_PARTICLES = 2

      def initialize(viewport)
        @viewport = viewport
        @sprites = {}
        @frame = 0
        @wait = 180  # Wait time before spawning (3 seconds at 60 FPS)
        @finished = false
      end

      def dispose
        @sprites.each_value do |sprite|
          sprite.dispose if sprite && !sprite.disposed?
        end
        @sprites.clear
      end

      def update
        @frame += 1.lerp if @frame.to_i < @wait
        # Add wind sprites unless 2 playing
        add_wind if !@finished && @frame.to_i >= @wait && able_count < MAX_PARTICLES

        # Update wind sprite components
        @sprites.each do |key, sprite|
          next if sprite.disposed?

          sprite.update
          sprite.x = -$game_map.display_x / Game_Map::X_SUBPIXELS
          sprite.y = -$game_map.display_y / Game_Map::Y_SUBPIXELS
          dispose_sprite(key) if sprite.finished?
        end
      end

      private

      def able_count
        @sprites.count { |_, sprite| !sprite.disposed? }
      end

      def add_wind
        particle = Wind.new(@viewport)
        
        # Random position - x/y are the base position!
        particle.x = rand(Graphics.width - 100) + 50
        particle.y = rand(Graphics.height - 100) + 50
        particle.z = 999
        
        key = @sprites.size
        @sprites[key] = particle
        @frame = 0  # Reset timer
      end

      def dispose_sprite(key)
        sprite = @sprites[key]
        sprite.dispose if sprite && !sprite.disposed?
        @sprites.delete(key)
      end
    end
  end
end

# Lerp extension for Integer
class Integer
  def lerp
    self
  end
end

#===============================================================================
# Integration into Spriteset_Map
#===============================================================================
class Spriteset_Map
  alias wind_manager_initialize initialize
  def initialize(map = nil)
    wind_manager_initialize(map)
    @wind_manager = Events::Animations::WindManager.new(self.class.viewport)
  end

  alias wind_manager_dispose dispose
  def dispose
    @wind_manager&.dispose
    @wind_manager = nil
    wind_manager_dispose
  end

  alias wind_manager_update update
  def update
    wind_manager_update
    @wind_manager&.update
  end
end
