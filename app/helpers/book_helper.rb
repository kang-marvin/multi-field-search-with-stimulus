module BookHelper

  def table_row_data_builder(object: , attribute: ,searchable_fields: [], class_name: "")
    options = searchable_fields.include?(attribute) ?
      {search_target: "searchable"} :
      nil

    tag.td key: attribute, class: class_name, data: options do
      object.send(attribute)
    end
  end

end
