# lloyds-technical-test

# iOS Tech Test

For this technical test I have implemented an iOS application written in Swift using MVP+Coordinator as architecture pattern for clear separation of concerns.
I have chosen this pattern due to time and scope restrictions.

Regarding the application, it is a simple Stock Market app which retrieves the data from a public API (https://www.stockdata.org/) and displays the information on a simplified manner. The app contains 3 main modules:

1. **Stocks module**: Displays a list of the most interesting stock quotes from the market. Also, the user can navigate to the detail of a certain quote to expand the information about it, see the charts, etc.
2. **News module**: Displays a list of the most interesting stock news from the market.

The interesting about this app, is not its functionality but its architecture. I have implemented a protocol based architecture which improves the app's performance, readability, maintainability, testability, scalability and simplicity.

For the networking layer, services can be instantiated with different data sources. There are 2 relevent classes to consider:

1. **AlamofireNetworking**: This class makes real API calls.
2. **MockNetworking**: This class reads the data from local JSON files.

***Note**: MockNetworking class was implemented because the used API has a limited requests quntity per day.*

## Thid-party libraries:
I have used different third-party libraries to simplified the solution and to demostrate Cocoapods integration.

1. **[Alamofire](https://github.com/Alamofire/Alamofire)**: Networking library.
2. **[Kingfisher](https://github.com/onevcat/Kingfisher)**: Image loading library.
3. **[DSFSparkline](https://github.com/dagronf/DSFSparkline)**: Lightweight Charts library.

## Unit tests:
Unit testing have been implemented to demostrate the solution's unit testing capability.
