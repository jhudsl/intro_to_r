
url = "http://johnmuschelli.com/intro_to_r/data/kaggleCarAuction.csv"

# default
cars <- read_csv(url)
problems(cars)


# most robust way
cars <- read_csv(url, guess_max = Inf)

spec(cars)

## best answer - quick and simple
cars = read_csv(
  url,
  col_types = cols(
    VehBCost = col_double()
  ))

# explicitly specify columns for ALL columns
cars = read_csv(
  url,
  col_types = cols(
    RefId = col_integer(),
    IsBadBuy = col_integer(),
    PurchDate = col_character(),
    Auction = col_character(),
    VehYear = col_integer(),
    VehicleAge = col_integer(),
    Make = col_character(),
    Model = col_character(),
    Trim = col_character(),
    SubModel = col_character(),
    Color = col_character(),
    Transmission = col_character(),
    WheelTypeID = col_character(),
    WheelType = col_character(),
    VehOdo = col_integer(),
    Nationality = col_character(),
    Size = col_character(),
    TopThreeAmericanName = col_character(),
    MMRAcquisitionAuctionAveragePrice = col_character(),
    MMRAcquisitionAuctionCleanPrice = col_character(),
    MMRAcquisitionRetailAveragePrice = col_character(),
    MMRAcquisitonRetailCleanPrice = col_character(),
    MMRCurrentAuctionAveragePrice = col_character(),
    MMRCurrentAuctionCleanPrice = col_character(),
    MMRCurrentRetailAveragePrice = col_character(),
    MMRCurrentRetailCleanPrice = col_character(),
    PRIMEUNIT = col_character(),
    AUCGUART = col_character(),
    BYRNO = col_integer(),
    VNZIP1 = col_integer(),
    VNST = col_character(),
    VehBCost = col_double(),
    IsOnlineSale = col_integer(),
    WarrantyCost = col_integer()
  ))

