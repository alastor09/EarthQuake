# EarthQuake
Displaying earthquake information


Network Layer
GetBaseAPIClient class manages all sessions and makes the required request to server and fetches the data

Each API which will be used will have one class, which will be child of GetBaseAPIClient and always have these functions overridden
    func requestUrl() -> String
    func processResponseSuccessData(dataArray : NSDictionary)
    func processResponseFailureError(error : NSError)


All the API specific handling will be done in there individual class, this makes API implementation scalable
requestURL - returns the url string for the string 
depending upon response below functions will be called
func processResponseSuccessData(dataArray : NSDictionary)
func processResponseFailureError(error : NSError)

One manager class is implemented which keeps the data and makes the appropriate request calls