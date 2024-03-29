connect to db4ad3;

CREATE INDEX idx_Product_price ON Product(price) CLUSTER;
CREATE INDEX idx_Person_dateOfBirth_first_last_name ON Person(dateOfBirth, firstname, lastname);
CREATE INDEX idx_Transaction_productId_ammount ON Transaction(productId, amount);
CREATE INDEX idx_Transaction_attendeeId_date ON Transaction(attendeeId, date);
CREATE INDEX idx_Transaction_date_paymentMethod_amount ON Transaction(date, paymentMethod, amount);
CREATE INDEX idx_Sell_vendorID ON Sell(vendorID);