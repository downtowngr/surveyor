translate = (right, down) ->
  "translate(" + right + "," + down + ")"

barChart = ->
  margins =
    top: 15
    right: 32
    bottom: 10
    left: 10

  width = 350

  itemHeight = 20
  barHeight = 10
  labelWidth = 100

  scale = d3.scale.linear()
    .range([0, width - margins.left - margins.right - labelWidth])

  my = (selection) ->
    selection.each (data) ->
      scale.domain([0, d3.max(keyword.votes for keyword in data)])
      height = (data.length * itemHeight) + margins.top + margins.bottom

      svg = d3.select(@)
        .append "svg"
        .attr "width", width
        .attr "height", height
        .append "g"
        .attr "transform", translate(margins.left, margins.top)

      bars = svg.selectAll(".bars")
        .data(data.sort((a, b) -> b.votes - a.votes))

      bars.enter().append("g")
        .attr "class", "bars"
        .attr "transform", (d, i) -> translate(0, i * itemHeight)

      bars.append("text")
        .text (d) -> d.name
        .attr "x", labelWidth - 5
        .style "text-anchor", "end"
        .style "font-size", "12px"

      bars.append("rect")
        .attr "x", labelWidth
        .attr "y", -barHeight
        .attr "width", (d) -> scale(d.votes)
        .attr "height", barHeight

      bars.append("text")
        .text (d) -> d.votes
        .attr "x", (d) -> labelWidth + scale(d.votes) + 5

  return my

myBarChart = barChart()

renderChart = ->
        poll_id = $("#chart").data("poll-id")
        d3.json "/admin/polls/" + poll_id + ".json", (error, data) ->
                d3.select("#chart")
                .datum data
                .call myBarChart

$(document).ready(renderChart)



