# Train Booking System

A comprehensive database and booking system for managing train schedules, journeys, stations, bookings, and passenger information. This system facilitates creating, updating, and querying train journeys, stations, ticket bookings, and seat reservations.

---

## Features

- **Manage Train Stations**: Add, update, and delete train stations.
- **Create and View Train Schedules**: Manage weekly and weekend schedules for different train routes.
- **Train Journey Management**: Link train journeys to schedules, stations, and carriages.
- **Booking System**: Handle passenger bookings including ticket numbers, seat reservations, and status.
- **Carriage Class Management**: Define different carriage classes like First Class, Business, and Economy.
- **Real-time Pricing**: Set and view pricing for different carriage classes and schedules.

---

## Database Structure

The **Train Booking** system uses a relational database structured around the following entities:

### 1. **train_station**
Stores information about different train stations.

| Column Name  | Data Type     | Description                   |
|--------------|---------------|-------------------------------|
| id           | INT           | Auto-incremented primary key.  |
| station_name | VARCHAR(255)  | The name of the train station. |

### 2. **schedule**
Contains schedule information, differentiating between weekdays and weekends.

| Column Name  | Data Type     | Description                   |
|--------------|---------------|-------------------------------|
| id           | INT           | Auto-incremented primary key.  |
| name         | VARCHAR(255)  | Name of the schedule (e.g., 'Weekday', 'Weekend'). |

### 3. **train_journey**
Links a schedule to specific journeys.

| Column Name  | Data Type     | Description                   |
|--------------|---------------|-------------------------------|
| id           | INT           | Auto-incremented primary key.  |
| schedule_id  | INT           | Foreign key referencing `schedule` id. |
| name         | VARCHAR(255)  | Journey name (e.g., '9:05 Penn Station to Boston'). |

### 4. **journey_station**
Maps stations to specific train journeys and their stop orders.

| Column Name  | Data Type     | Description                   |
|--------------|---------------|-------------------------------|
| journey_id   | INT           | Foreign key referencing `train_journey` id. |
| station_id   | INT           | Foreign key referencing `train_station` id. |
| stop_order   | INT           | Order of stops in the journey. |
| departure_time | DATETIME    | Time of departure from the station. |

### 5. **carriage_class**
Defines the different classes of carriage for train journeys.

| Column Name  | Data Type     | Description                   |
|--------------|---------------|-------------------------------|
| id           | INT           | Auto-incremented primary key.  |
| class_name   | VARCHAR(255)  | Class name (e.g., 'First Class'). |
| seating_capacity | INT       | Total seating capacity in the carriage. |

### 6. **journey_carriage**
Links carriages to specific train journeys.

| Column Name      | Data Type     | Description                      |
|------------------|---------------|----------------------------------|
| journey_id       | INT           | Foreign key referencing `train_journey` id. |
| carriage_class_id| INT           | Foreign key referencing `carriage_class` id. |
| position         | INT           | Position of the carriage in the journey. |

### 7. **carriage_price**
Stores the pricing for each carriage class and schedule combination.

| Column Name     | Data Type    | Description                             |
|-----------------|--------------|-----------------------------------------|
| schedule_id     | INT          | Foreign key referencing `schedule` id.  |
| carriage_class_id | INT        | Foreign key referencing `carriage_class` id. |
| price           | DECIMAL(10, 2) | Price for the ticket in that carriage class. |

### 8. **booking_status**
Stores the different statuses a booking can have.

| Column Name  | Data Type     | Description                   |
|--------------|---------------|-------------------------------|
| id           | INT           | Auto-incremented primary key.  |
| name         | VARCHAR(255)  | Status name (e.g., 'Active', 'Cancelled'). |

### 9. **passenger**
Stores passenger details.

| Column Name  | Data Type     | Description                   |
|--------------|---------------|-------------------------------|
| id           | INT           | Auto-incremented primary key.  |
| first_name   | VARCHAR(255)  | Passenger's first name.        |
| last_name    | VARCHAR(255)  | Passenger's last name.         |
| email_address| VARCHAR(255)  | Passenger's email address (unique). |
| password     | VARCHAR(255)  | Passenger's password.          |

### 10. **booking**
Stores booking information including ticket and seat details.

| Column Name      | Data Type     | Description                         |
|------------------|---------------|-------------------------------------|
| id               | INT           | Auto-incremented primary key.       |
| passenger_id     | INT           | Foreign key referencing `passenger` id. |
| position         | INT           | Passenger's position in the journey. |
| status_id        | INT           | Foreign key referencing `booking_status` id. |
| booking_date     | DATE          | Date the booking was made.          |
| starting_station_id | INT       | Foreign key referencing `train_station` id (starting station). |
| ending_station_id | INT        | Foreign key referencing `train_station` id (ending station). |
| train_journey_id | INT          | Foreign key referencing `train_journey` id. |
| ticket_class_id  | INT          | Foreign key referencing `carriage_class` id. |
| amount_paid      | DECIMAL(10, 2) | Amount paid for the ticket.         |
| ticket_no        | INT           | Unique ticket number.               |
| seat_no          | INT           | Reserved seat number.               |

---

## Getting Started

### Prerequisites

1. **MySQL Database**: Ensure you have MySQL installed and running on your local machine or server.
2. **MySQL Workbench**: Optionally, you can use MySQL Workbench to manage the database and run SQL queries.

### Setting Up the Database

1. Clone this repository or download the SQL schema file.
2. Open MySQL Workbench (or your preferred MySQL management tool).
3. Execute the provided SQL schema in your MySQL environment to create the tables.
4. You may need to manually insert sample data or use the provided data insertion queries.

### Example Queries

- **Create a new train station**:
    ```sql
    INSERT INTO train_station (station_name) VALUES ('Union Station');
    ```

- **Create a new booking**:
    ```sql
    INSERT INTO booking (passenger_id, status_id, booking_date, starting_station_id, ending_station_id, train_journey_id, ticket_class_id, amount_paid, ticket_no, seat_no)
    VALUES (1, 1, '2025-01-10', 1, 2, 1, 1, 200.00, 1001, 5);
    ```

- **View all bookings**:
    ```sql
    SELECT * FROM booking;
    ```

### Testing the System

Once the database is set up and populated, you can test the system by making new bookings, querying train journeys, or checking the availability of seats for specific stations and dates.

---

## Contributing

Feel free to fork this repository, make changes, and submit a pull request. Ensure that you follow the appropriate coding style and add test cases for new features.


