module RepairServicesHelper

  def spare_part_row_class(spare_part)
    case spare_part.remnant_s(current_user.spare_parts_store)
      when 'none' then 'error'
      when 'low' then 'warning'
      when 'many' then 'success'
      else ''
    end
  end

end
