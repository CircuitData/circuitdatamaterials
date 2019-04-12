class MaterialSearch < Struct.new(:material_name, :numerical_filter, :min, :max, keyword_init: true)
  def has_valid_params?
    !conditions.empty?
  end

  def results
    Material.where(query)
  end

  private

  def query
    # Combine all the parameters into an AND query.
    conditions.reduce do |acc, condition|
      next condition if acc.nil?
      acc.and(condition)
    end
  end

  def has_valid_filter_param?
    valid_filter_attribute? && (min.present? || max.present?)
  end

  def valid_filter_attribute?
    numerical_filter.present? &&
      Material.numerical_columns.include?(numerical_filter)
  end

  def conditions
    @conditions ||= build_conditions
  end

  def build_conditions
    conditions = []
    if material_name.present?
      conditions << table[:name].matches("%#{material_name}%")
    end
    conditions + numerical_filter_conditions
  end

  def numerical_filter_conditions
    return [] unless valid_filter_attribute?
    column = numerical_filter
    conditions = []
    if min.present?
      conditions << table[column].gteq(min.to_i)
    end
    if max.present?
      conditions << table[column].lteq(max.to_i)
    end
    conditions
  end

  def table
    @table ||= Material.arel_table
  end
end
