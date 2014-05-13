module RunPal
  class ShowOpenCircles < UseCase

    def run(inputs)
      circle_arr = get_open_circles

      success :circle_arr => circle_arr
    end

    def get_open_circles
      RunPal.db.circles_filter_full
    end

  end
end
