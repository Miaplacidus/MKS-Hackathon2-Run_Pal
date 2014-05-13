module RunPal
  class UpdateCircle < UseCase

    def run(inputs)
      circle = RunPal.db.get_circle(inputs[:circle_id])
      return failure (:circle_does_not_exist) if circle.nil?

      updated_circle = update_circle(inputs)
      success :circle => updated_circle
    end

    def update_circle(attrs)
      attrs_sans_circleid = attrs.clone
      attrs_sans_circleid.delete(:circle_id)
      RunPal.db.update_circle(attrs[:circle_id], attrs_sans_circleid)
    end

  end
end
