class Avo::Resources::ServiceTime < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :day_of_week, as: :text
    field :open_time, as: :date_time
    field :close_time, as: :date_time
    field :lunch_start, as: :date_time
    field :lunch_end, as: :date_time
    field :off_day, as: :boolean
    field :shop_id, as: :number
    field :shop, as: :belongs_to
  end
end
