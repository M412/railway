class Station
  
  attr_reader :station_name
  
  def initialize(st_name)
    @trains = Array.new
    @station_name = st_name
    puts "Создана станция с именем #{st_name}"
  end
  
  def AddTrain(train)
    @trains << train
    puts "На станцию #{self.station_name} прибыл поезд с номером #{train.train_number}"
  end
  
  def DelTrain(train)
    @trains.delete(train)
    puts "Со станции #{self.station_name} отправился поезд с номером #{train.train_number}"
  end
  
  def ShowCurrentTrains
    @trains
  end
  
  def ShowTrainsByType(type)
    @trains.select{|tr| tr.type == type}
  end         
end
  
class Route
  
  attr_reader :stations
  
  def initialize(start_station, finish_station)
    @stations = Array.new << start_station << finish_station
  end

  def AddBetweenStation(station)
    @stations.insert(1, station)
  end
  
  def DelBetweenStation(station)
    @stations.delete(station)    
  end
  
  def Show
    @stations
  end
  
end

class Train
  
  attr_accessor :speed
  attr_reader :wagons
  attr_reader :type
  attr_reader :train_number
  
  def initialize(number, type, wagons)
    @train_number = number
    @speed = 0
    @type = type
    @wagons = wagons
  end
  
  def Brake
    @speed = 0
  end

  def AddWagon
    @wagons += 1 if @speed == 0
  end
    
  def DelWagon
    @wagons -=1 if @speed == 0
  end
  
  def Route(route)
    @route = route
    @route.stations[0].AddTrain(self)
    @current_station = 0
  end
  
  def NextStation
    @route.stations[@current_station].DelTrain(self)
    @current_station += 1
    @route.stations[@current_station].AddTrain(self)
    @route.stations[@current_station].station_name
  end
  
  def PrevStation
    @route.stations[@current_station].DelTrain(self)
    @current_station -= 1
    @route.stations[@current_station].AddTrain(self)
    @route.stations[@current_station].station_name
  end
  
  def ShowPrevStation
    @route.stations[@current_station - 1].station_name
  end
  
  def ShowNextStation
    @route.stations[@current_station + 1].station_name
  end
  
end