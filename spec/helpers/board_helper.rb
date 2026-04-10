module BoardHelper

  extend self
  def count_array_cells(array)
    return unless array.is_a?(Array) || array.empty?

    counter = 0
    array.each do |item|
      if item.is_a?(Array) && item.length.positive?
        item.each do
          counter += 1
        end
      end
    end
    counter
  end
end
