require 'dotenv/load'
require 'pixela'

def main
  copy_graph rescue nil
  copy_pixels
end

def client
  @client ||= Pixela::Client.new(username: ENV['PIXELA_USERNAME'], token: ENV['PIXELA_TOKEN'])
end

def graph_original
  @graph_original ||= client.graph(ARGV[0])
end

def graph_backup
  @graph_backup ||= client.graph(ARGV[1])
end

def copy_graph
  graph_definition_original = graph_original.def
  graph_backup.create(
    name: graph_definition_original.name,
    unit: graph_definition_original.unit,
    type: graph_definition_original.type,
    color: graph_definition_original.color,
    timezone: graph_definition_original.timezone,
    self_sufficient: graph_definition_original.selfSufficient,
    is_secret: graph_definition_original.isSecret,
    publish_optional_data: graph_definition_original.publishOptionalData
  )
end

def copy_pixels
  pixels = graph_original.pixels
  pixel_count = pixels.count
  pixels.each.with_index(1) do |pixel, count|
    graph_backup.pixel(Date.parse(pixel.date)).create(quantity: pixel.quantity)

    print "\r#{count}/#{pixel_count}"

    if count == pixel_count
      puts
    else
      sleep 1
    end
  end
end

main
