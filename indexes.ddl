connect to db4ad3;

CREATE INDEX idx_Sell_vendorID ON Sell(vendorID);
CREATE INDEX idx_ProductBelongToSubcategory_productID ON ProductBelongToSubcategory(productID);
CREATE INDEX idx_Transaction_Date_VendorID ON Transaction(Date, vendorID);
CREATE INDEX idx_ProductTrial_minutesTried ON ProductTrial(minutesTried) CLUSTER;
CREATE INDEX idx_Product_price ON Product(price) CLUSTER;
CREATE INDEX idx_Person_dateOfBirth ON Person(dateOfBirth);
CREATE INDEX idx_ListenTo_attendeeID ON ListenTO(attendeeID);