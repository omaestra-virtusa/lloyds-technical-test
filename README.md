# lloyds-technical-test

# iOS Tech Test

For this technical test I have implemented an iOS application written in Swift using MVP as architecture pattern for clear separation of concerns.
I have chosen this pattern due to time and scope restrictions.

Regarding the application, it is a simple Stock Market app which retrieves the data from a public API (https://www.stockdata.org/) and displays the information on a simplified manner. The app contains 3 main modules:

1. Stocks module: Displays a list of the most interesting stock quotes from the market. Also, the user can navigate to the detail of a certain quote to expand the information about it, see the charts, etc.
2. News module: Displays a list of the most interesting stock news from the market.

The interesting about this app, is not its functionality but its architecture. I have implemented a protocol based architecture which improves the app's performance, readability, maintainability, testability, scalability and simplicity.

For the networking layer, services can be instantiated with different data sources. There are 2 relevent classes to consider:

1. AlamofireNetworking: This class makes real API calls.
2. MockNetworking: This class reads the data from local JSON files.

## Thid-party libraries:
I have used different third-party libraries to simplified the solution and to demostrate Cocoapods integration.

1. Alamofire: Networking library (https://github.com/Alamofire/Alamofire)
2. Kingfisher: Image loading library (https://github.com/onevcat/Kingfisher)
3. DSFSparkline: Lightweight Charts library (https://github.com/dagronf/DSFSparkline)

