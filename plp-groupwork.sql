-- Create Database
CREATE DATABASE IF NOT EXISTS train_booking;
USE train_booking;

-- Create train_station Table
CREATE TABLE train_station (
    id INT AUTO_INCREMENT PRIMARY KEY,
    station_name VARCHAR(255) NOT NULL
);

-- Create schedule Table
CREATE TABLE schedule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create train_journey Table
CREATE TABLE train_journey (
    id INT AUTO_INCREMENT PRIMARY KEY,
    schedule_id INT,
    name VARCHAR(255),
    FOREIGN KEY (schedule_id) REFERENCES schedule(id)
);

-- Create journey_station Table
CREATE TABLE journey_station (
    journey_id INT,
    station_id INT,
    stop_order INT,
    departure_time DATETIME,
    PRIMARY KEY (journey_id, station_id),
    FOREIGN KEY (journey_id) REFERENCES train_journey(id),
    FOREIGN KEY (station_id) REFERENCES train_station(id)
);

-- Create carriage_class Table
CREATE TABLE carriage_class (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(255),
    seating_capacity INT
);

-- Create journey_carriage Table
CREATE TABLE journey_carriage (
    journey_id INT,
    carriage_class_id INT,
    position INT,
    PRIMARY KEY (journey_id, carriage_class_id),
    FOREIGN KEY (journey_id) REFERENCES train_journey(id),
    FOREIGN KEY (carriage_class_id) REFERENCES carriage_class(id)
);

-- Create carriage_price Table
CREATE TABLE carriage_price (
    schedule_id INT,
    carriage_class_id INT,
    price DECIMAL(10, 2),
    PRIMARY KEY (schedule_id, carriage_class_id),
    FOREIGN KEY (schedule_id) REFERENCES schedule(id),
    FOREIGN KEY (carriage_class_id) REFERENCES carriage_class(id)
);

-- Create booking_status Table
CREATE TABLE booking_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

-- Create passenger Table
CREATE TABLE passenger (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255) UNIQUE,
    password VARCHAR(255)
);

-- Create booking Table
CREATE TABLE booking (
    id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT,
    position INT,
    status_id INT,
    booking_date DATE,
    starting_station_id INT,
    ending_station_id INT,
    train_journey_id INT,
    ticket_class_id INT,
    amount_paid DECIMAL(10, 2),
    ticket_no INT,
    seat_no INT,
    FOREIGN KEY (passenger_id) REFERENCES passenger(id),
    FOREIGN KEY (status_id) REFERENCES booking_status(id),
    FOREIGN KEY (starting_station_id) REFERENCES train_station(id),
    FOREIGN KEY (ending_station_id) REFERENCES train_station(id),
    FOREIGN KEY (train_journey_id) REFERENCES train_journey(id),
    FOREIGN KEY (ticket_class_id) REFERENCES carriage_class(id)
);

-- Insert Sample Data into train_station
INSERT INTO train_station (station_name)
VALUES 
('Grand Central Station'), 
('Union Station'),
('Chicago O\'Hare'),
('San Francisco Station'),
('Boston South Station'),
('Los Angeles Union Station');

-- Insert Sample Data into schedule
INSERT INTO schedule (name)
VALUES 
('Weekday Morning'),
('Weekend Evening'),
('Holiday Special'),
('Midnight Run');

-- Insert Sample Data into train_journey
INSERT INTO train_journey (schedule_id, name)
VALUES 
(1, '7:30 AM Grand Central to Boston South Station'),
(2, '6:45 PM Union Station to San Francisco Station'),
(3, '10:00 AM Chicago O\'Hare to Washington DC'),
(4, '12:15 AM Midnight Run to Los Angeles Union Station');

-- Insert Sample Data into journey_station
INSERT INTO journey_station (journey_id, station_id, stop_order, departure_time)
VALUES 
-- Journey 1: 7:30 AM Grand Central to Boston South Station
(1, 1, 1, '2025-01-10 07:30:00'),
(1, 5, 2, '2025-01-10 09:15:00'),

-- Journey 2: 6:45 PM Union Station to San Francisco Station
(2, 2, 1, '2025-01-11 18:45:00'),
(2, 4, 2, '2025-01-11 22:00:00'),

-- Journey 3: 10:00 AM Chicago O'Hare to Washington DC
(3, 3, 1, '2025-01-12 10:00:00'),
(3, 6, 2, '2025-01-12 14:45:00'),

-- Journey 4: 12:15 AM Midnight Run to Los Angeles Union Station
(4, 6, 1, '2025-01-13 00:15:00'),
(4, 2, 2, '2025-01-13 06:30:00');

-- Insert Sample Data into carriage_class
INSERT INTO carriage_class (class_name, seating_capacity)
VALUES 
('First Class', 50), 
('Business Class', 100), 
('Economy Class', 250), 
('Sleeper Car', 30);

-- Insert Sample Data into journey_carriage
INSERT INTO journey_carriage (journey_id, carriage_class_id, position)
VALUES 
-- Journey 1: Grand Central to Boston South Station
(1, 1, 1), (1, 2, 2), (1, 3, 3), (1, 4, 4),

-- Journey 2: Union Station to San Francisco Station
(2, 2, 1), (2, 3, 2), (2, 4, 3),

-- Journey 3: Chicago O'Hare to Washington DC
(3, 1, 1), (3, 3, 2), (3, 4, 3),

-- Journey 4: Midnight Run to Los Angeles Union Station
(4, 3, 1), (4, 4, 2);

-- Insert Sample Data into carriage_price
INSERT INTO carriage_price (schedule_id, carriage_class_id, price)
VALUES 
(1, 1, 300.00),
(1, 2, 200.00),
(1, 3, 100.00),
(1, 4, 150.00),

(2, 1, 280.00),
(2, 2, 180.00),
(2, 3, 120.00),
(2, 4, 160.00),

(3, 1, 350.00),
(3, 3, 140.00),
(3, 4, 160.00),

(4, 3, 120.00),
(4, 4, 180.00);

-- Insert Sample Data into booking_status
INSERT INTO booking_status (name)
VALUES 
('Active'), 
('Cancelled'), 
('Pending'),
('Confirmed');

-- Insert Sample Data into passenger
INSERT INTO passenger (first_name, last_name, email_address, password)
VALUES 
('John', 'Doe', 'john.doe@mail.com', 'password123'),
('Jane', 'Smith', 'jane.smith@mail.com', 'password456'),
('Michael', 'Johnson', 'michael.johnson@mail.com', 'password789'),
('Emily', 'Davis', 'emily.davis@mail.com', 'password000'),
('William', 'Brown', 'william.brown@mail.com', 'password999');

-- Insert Sample Data into booking
INSERT INTO booking (passenger_id, position, status_id, booking_date, starting_station_id, ending_station_id, train_journey_id, ticket_class_id, amount_paid, ticket_no, seat_no)
VALUES 
-- Booking 1: John Doe
(1, 1, 1, '2025-01-10', 1, 5, 1, 1, 300.00, 1001, 7),

-- Booking 2: Jane Smith
(2, 2, 2, '2025-01-11', 2, 4, 2, 3, 120.00, 1002, 15),

-- Booking 3: Michael Johnson
(3, 3, 3, '2025-01-12', 3, 6, 3, 4, 160.00, 1003, 22),

-- Booking 4: Emily Davis
(4, 4, 4, '2025-01-13', 6, 2, 4, 2, 200.00, 1004, 11),

-- Booking 5: William Brown
(5, 5, 1, '2025-01-14', 1, 5, 1, 3, 100.00, 1005, 5);
