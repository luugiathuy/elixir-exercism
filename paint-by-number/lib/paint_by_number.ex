defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    case color_count do
      0 -> 0
      1 -> 0
      value -> 1 + palette_bit_size(ceil(value / 2))
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(<<>>, color_count, pixel_color_index) do
    bit_size = palette_bit_size(color_count)
    <<pixel_color_index::size(bit_size)>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bit_size = palette_bit_size(color_count)
    <<pixel_color_index::size(bit_size), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _color_count) do
    nil
  end

  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<value::size(bit_size), _rest::bitstring>> = picture
    value
  end

  def drop_first_pixel(<<>>, _color_count) do
    <<>>
  end

  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<_value::size(bit_size), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
