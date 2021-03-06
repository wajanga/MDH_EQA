module DemoPagesHelper

	def populate_pie_chart
		#{"Successful (95-100)" => 75, "Satisfactory (90-95)" => 10, "Unsatisfactory (<90)" => 15}
		
		total_count = Result.count

		successful_count = Result.where("'95' <= score AND score <= '100'").count
		successful_percent = successful_count.to_f / total_count.to_f * 100.0

		satisfactory_count = Result.where("'90' <= score AND score < '95'").count
		satisfactory_percent = satisfactory_count.to_f / total_count.to_f * 100.0

		unsatisfactory_count = Result.where("score < '90'").count
		unsatisfactory_percent = unsatisfactory_count.to_f / total_count.to_f * 100.0

		if successful_count == 0 && satisfactory_count == 0 && unsatisfactory_count == 0
			{"No result" => 100}
		else
			{"Successful (95-100)" => successful_count,
		 	"Satisfactory (90-95)" => satisfactory_count, 
		 	"Unsatisfactory (<90)" => unsatisfactory_count}
		end
	end

	def populate_bar_chart
		#{"Dodoma" => 20, "Arusha" => 40, "Kagera" => 30}
		data = {}
		Region.find_each do |region|
			data["#{region.name}"] = 
				Result.joins(facility: {district: :region}).where(regions: {name: region.name}).count
		end
		data.sort_by {|k, v| -v }.first(3)
	end

end
